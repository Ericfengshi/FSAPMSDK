//
//  FSNetworkFlow.m
//  FSAPMSDK
//
//  Created by fengs on 2019/1/30.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "FSNetworkFlow.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>
#include <arpa/inet.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation FSNetworkFlow

#pragma mark - Public Method
/**
 获取系统网络流量
 
 @return fs_flow_IOBytes
 */
+ (fs_flow_IOBytes)getFlowIOBytes {
    struct ifaddrs *ifa_list = NULL, *ifa;
    fs_flow_IOBytes flow = {0, 0, 0, 0, 0, 0};
    if (getifaddrs(&ifa_list) == -1) {
        return flow;
    }
    for (ifa = ifa_list; ifa; ifa = ifa -> ifa_next) {
        if (AF_LINK != ifa -> ifa_addr -> sa_family)
            continue;
        if (!(ifa -> ifa_flags& IFF_UP) &&!(ifa -> ifa_flags & IFF_RUNNING))
            continue;
        if (ifa -> ifa_data == 0)
            continue;
        if (strcmp(ifa -> ifa_name, "en0") == 0) {
            // wifi
            struct if_data *if_data = (struct if_data *)ifa -> ifa_data;
            flow.wifi_received += if_data -> ifi_ibytes;
            flow.wifi_sent  += if_data -> ifi_obytes;
        } else if (strcmp(ifa -> ifa_name, "pdp_ip0") == 0) {
            struct if_data *if_data = (struct if_data *)ifa -> ifa_data;
            flow.cellular_received  += if_data -> ifi_ibytes;
            flow.cellular_sent += if_data -> ifi_obytes;
        }
    }
    flow.total_received = flow.wifi_received + flow.cellular_received;
    flow.total_sent = flow.wifi_sent + flow.cellular_sent;
    freeifaddrs(ifa_list);
    return flow;
}

/**
 获取 wifi iP 地址
 
 @return NSString
 */
+ (NSString *)getWifiIPAddress {
    NSDictionary *addresses = [self getIPAddresses];
    NSString *key = IOS_WIFI @"/" IP_ADDR_IPv4;
    NSString *address = addresses[key];
    //筛选出IP地址格式
    return [self p_isValidatIP:address] ? address : @"0.0.0.0";
}

/**
 获取 SIM 卡 iP 地址
 
 @return NSString
 */
+ (NSString *)getCellularIPAddress {
    NSDictionary *addresses = [self getIPAddresses];
    NSString *key = IOS_CELLULAR @"/" IP_ADDR_IPv4;
    NSString *address = addresses[key];
    //筛选出IP地址格式
    return [self p_isValidatIP:address] ? address : @"0.0.0.0";
}

/**
 iP 字典集合（包含iP4 iP6）
 
 @return NSDictionary
 */
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

/**
 获取设备当前网络IP地址
 
 @param isIPv4 iP 输出格式
 @return NSString
 */
+ (NSString *)getIPAddress:(BOOL)isIPv4 {
    NSArray *searchArray = isIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    NSDictionary *addresses = [self getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        //筛选出IP地址格式
        if([self p_isValidatIP:address]) {
            *stop = YES;
        }
    }];
    return address ? address : @"0.0.0.0";
}

#pragma mark - Private Method
/**
 校验 iP 格式

 @param ipAddress iP 地址
 @return BOOL
 */
+ (BOOL)p_isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        if (firstMatch) {
            return YES;
        }
    }
    return NO;
}

@end
