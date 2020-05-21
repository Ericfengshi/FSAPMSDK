//
//  SimulatorCrashViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/14.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorCrashViewController.h"

@implementation SimulatorCrashViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SimulatorManager sharedInstance] showWithDataType:SimulatorDataCrashType];
}

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSArray *text = [NSArray array];
        NSLog(@"text %@", text[2]);
    } else if (indexPath.row == 1) {
        int *p;
        free(p);
    }
}

@end
