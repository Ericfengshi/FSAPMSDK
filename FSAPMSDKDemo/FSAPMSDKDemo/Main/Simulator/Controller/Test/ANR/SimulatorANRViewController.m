//
//  SimulatorANRViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/14.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorANRViewController.h"

@interface SimulatorANRViewController ()

@property (nonatomic, strong) NSTimer *busyJobTimer;

@end

@implementation SimulatorANRViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SimulatorManager sharedInstance] showWithDataType:SimulatorDataANRType];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self p_cancelJob];
}

#pragma mark - Action Method
- (void)onBusyJobTimeout {
    [self p_doBusyJob];
}

#pragma mark - Private Method
- (void)p_doBusyJob {
    int logCount = 100000;
    for (int i = 0; i < logCount; i ++) {
        NSLog(@"busy...\n");
    }
}

- (void)p_cancelJob {
    if (self.busyJobTimer) {
        [self.busyJobTimer invalidate];
        self.busyJobTimer = nil;
    }
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.busyJobTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onBusyJobTimeout) userInfo:nil repeats:NO];
    }
}

@end
