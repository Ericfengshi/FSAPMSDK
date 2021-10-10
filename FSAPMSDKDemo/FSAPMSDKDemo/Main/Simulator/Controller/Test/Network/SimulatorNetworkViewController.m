//
//  SimulatorNetworkViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/13.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorNetworkViewController.h"

@interface SimulatorNetworkViewController ()

@end

@implementation SimulatorNetworkViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SimulatorManager sharedInstance] showWithDataType:SimulatorDataNetworkType];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *url = nil;
    if (indexPath.row == 0) {
        url = @"http://www.baidu.com";
    } else if (indexPath.row == 1) {
        url = @"http://api.m.taobao.com/rest/api3.do?api=mtop.common.getTimestamp";
    } else if (indexPath.row == 2) {
        url = @"http://www.baidu.com/error";
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByRemovingPercentEncoding]]];
    NSURLSessionDataTask *dataTask =  [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
        NSLog(@"1");
    }];
    [dataTask resume];
}

@end
