//
//  SimulatorBayMaxViewController.m
//  FSAPMSDKDemo
//
//  Created by fengs on 2019/2/14.
//  Copyright © 2019 fengs. All rights reserved.
//

#import "SimulatorBayMaxViewController.h"
#import "SimulatorNotificationViewController.h"
#import "SimulatorTimerViewController.h"
#import "SimulatorZombieViewController.h"

#pragma mark - static const/#define
static NSString *const KCellReuseIdentifier = @"SimulatorBayMaxControllerCellReuseIdentifier";

@interface SimulatorBayMaxViewController ()

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat progress1;

@end

@implementation SimulatorBayMaxViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 35;
    [self addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SimulatorManager sharedInstance] showWithDataType:SimulatorDataBayMaxType];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"change:%@", change);
}

#pragma mark - Private Method
#pragma mark -NSArray


#pragma mark -NSMutableArray

#pragma mark - UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dicSection = [self.viewModel.dataArray objectAtIndex:section];
    NSArray *dataArray = [dicSection.allValues firstObject];
    return dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSDictionary *dicSection = [self.viewModel.dataArray objectAtIndex:section];
    NSString *title = [dicSection.allKeys firstObject];
    CGRect rect = CGRectMake(0, 0, self.tableView.frame.size.width, 35);
    UIView *headView = [[UIView alloc] initWithFrame:rect];
    rect.origin.x = 15;
    UILabel *headLabel = [[UILabel alloc] initWithFrame:rect];
    headLabel.textColor = [UIColor grayColor];
    headLabel.font = [UIFont systemFontOfSize:13.0];
    headLabel.text = title;
    [headView addSubview:headLabel];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellReuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCellReuseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    NSDictionary *dicSection = [self.viewModel.dataArray objectAtIndex:indexPath.section];
    NSArray *dataArray = [dicSection.allValues firstObject];
    NSString *title = [dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor colorWithRed:16/255.0 green:119/255.0 blue:255/255.0 alpha:1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // UndefineSelector
        if (indexPath.row == 0) {
            [self performSelector:@selector(testUndefineSelector)];
        } else if (indexPath.row == 1) {
            NSNull *null = [NSNull null];
            NSString *str = (NSString *)null;
            NSLog(@"Str length:%ld", str.length);
        }
    } else if (indexPath.section == 1) { // Dic
        NSString *key = nil;
        NSString *value = nil;
        if (indexPath.row == 0) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:value forKey:@"key"];
            NSLog(@"dic:%@", dic);
        } else if (indexPath.row == 1) {
            NSDictionary *dic = [NSDictionary dictionaryWithObject:@"value" forKey:key];
            NSLog(@"dic:%@", dic);
        } else if (indexPath.row == 2) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:value forKey:@"key"];
            NSLog(@"dic:%@", dic);
        } else if (indexPath.row == 3) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setObject:@"value" forKey:key];
            NSLog(@"dic:%@", dic);
        } else {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic removeObjectForKey:key];
            NSLog(@"dic:%@", dic);
        }
    } else if (indexPath.section == 2) { // Array
        NSString *value = nil;
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", nil];
        if (indexPath.row == 0) {
            // 对象赋空值@[nil]
            NSArray *array = @[value];
            NSLog(@"array:%@", array);
        } else if (indexPath.row == 1) {
            // 数组越界取值
            NSArray *array = [NSArray array];
            NSLog(@"array[6]:%@", array[6]);
        } else if (indexPath.row == 2) {
            // 数组越界删除object removeObjectAtIndex:
            [array removeObjectAtIndex:5];
        } else if (indexPath.row == 3) {
            // 数组越界删除objects removeObjectsInRange:
            [array removeObjectsInRange:NSMakeRange(2, 3)];
        } else if (indexPath.row == 4) {
            // 数组越界添加object insertObject:atIndex:
            [array insertObject:@"5" atIndex:5];
        } else if (indexPath.row == 5) {
            // 数组越界添加objects insertObjects:atIndexes:
            [array insertObjects:@[@"6",@"7",@"8"] atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(5, 3)]];
        } else if (indexPath.row == 6) {
            // 数组越界替换object replaceObjectAtIndex:
            [array replaceObjectAtIndex:5 withObject:@"5"];
        } else if (indexPath.row == 7) {
            // 数组越界替换objects replaceObjectsInRange:withObjectsFromArray:
            [array replaceObjectsInRange:NSMakeRange(1, 4) withObjectsFromArray:@[@"5",@"6",@"7",@"8"]];
        } else if (indexPath.row == 8) {
            // 数组越界替换objects replaceObjectsAtIndexes:indexSetWithIndexesInRange:
            [array replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, 4)] withObjects:@[@"5",@"6",@"7",@"8"]];
        }
    } else if (indexPath.section == 3) { // NSSet
        NSObject *nilObject = nil;
        NSMutableSet *m = [NSMutableSet set];
        if (indexPath.row == 0) {
            [NSSet setWithObject:nilObject];
        } else if (indexPath.row == 1) {
            [m addObject:nilObject];
        } else if (indexPath.row == 2) {
            [m removeObject:nilObject];
        }
    } else if (indexPath.section == 4) { // NSString
        NSString *string = @"abcdefg";
        NSMutableString *stringMutable = [NSMutableString stringWithFormat:@"abcdefg"];
        if (indexPath.row == 0) {
            NSLog(@"characterAtIndex:%c", [string characterAtIndex:20]);
        } else if (indexPath.row == 1) {
            NSLog(@"substringFromIndex:%@", [string substringFromIndex:20]);
        } else if (indexPath.row == 2) {
            NSLog(@"substringToIndex:%@", [string substringToIndex:20]);
        } else if (indexPath.row == 3) {
            NSLog(@"substringWithRange:%@", [string substringWithRange:NSMakeRange(2, 20)]);
        } else if (indexPath.row == 4) {
            [stringMutable replaceCharactersInRange:NSMakeRange(20, 2) withString:@"ab"];
        } else if (indexPath.row == 5) {
            [stringMutable insertString:@"123" atIndex:20];
        } else if (indexPath.row == 6) {
            [stringMutable deleteCharactersInRange:NSMakeRange(2, 20)];
        }
    } else if (indexPath.section == 5) { // NSAttributedString
        NSString *nilString = nil;
        NSDictionary *nilDic = nil;
        NSAttributedString *noramlAttribute = [[NSAttributedString alloc] initWithString:@"1"];
        NSMutableAttributedString *mutableAttribute = [[NSMutableAttributedString alloc] initWithString:@"12"];
        if (indexPath.row == 0) {
            NSLog(@"NSAttributedString initWithString:%@", [[NSAttributedString alloc] initWithString:nilString]);
        } else if (indexPath.row == 1) {
            [noramlAttribute attributedSubstringFromRange:NSMakeRange(100, 1000)];
        } else if (indexPath.row == 2) {
            NSRange point = NSMakeRange(100, 1000);
            [noramlAttribute attribute:@"test" atIndex:100 effectiveRange:&point];
        } else if (indexPath.row == 3) {
            [noramlAttribute enumerateAttribute:@"test" inRange:NSMakeRange(100, 1001) options:NSAttributedStringEnumerationReverse usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
                
            }];
        } else if (indexPath.row == 4) {
            [noramlAttribute enumerateAttributesInRange:NSMakeRange(0, 1000) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
                
            }];
        } else if (indexPath.row == 5) {
            NSLog(@"NSAttributedString initWithString:attributes: %@", [[NSMutableAttributedString alloc] initWithString:nilString attributes:nilDic]);
        } else if (indexPath.row == 6) {
            [mutableAttribute addAttribute:NSFontAttributeName value:nilString range:NSMakeRange(0, 1000)];
        } else if (indexPath.row == 7) {
            [mutableAttribute addAttributes:nilDic range:NSMakeRange(1000, 100000)];
        } else if (indexPath.row == 8) {
            [mutableAttribute setAttributes:nilDic range:NSMakeRange(100, 100)];
            [mutableAttribute setAttributes:@{} range:NSMakeRange(100, 100)];
        } else if (indexPath.row == 9) {
            [mutableAttribute removeAttribute:NSFontAttributeName range:NSMakeRange(0, 100)];
            [mutableAttribute removeAttribute:nilString range:NSMakeRange(0, 100)];
        } else if (indexPath.row == 10) {
            [mutableAttribute deleteCharactersInRange:NSMakeRange(0, 10)];
        } else if (indexPath.row == 11) {
            [mutableAttribute replaceCharactersInRange:NSMakeRange(0, 1) withString:nilString];
            [mutableAttribute replaceCharactersInRange:NSMakeRange(0, 100) withString:@"1"];
        } else if (indexPath.row == 12) {
            [mutableAttribute replaceCharactersInRange:NSMakeRange(0, 100) withAttributedString:noramlAttribute];
        }
  
    } else if (indexPath.section == 6) { // Zombie
        SimulatorZombieViewController *vc = [[SimulatorZombieViewController alloc] init];
        vc.title = @"Zombie Test";
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 7) { // KVO
        self.progress = 1.1;
        if (indexPath.row == 0) {
            [self addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
            [self addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
        } else if (indexPath.row == 1) {
            [self removeObserver:self forKeyPath:@"progress1"];
        } else if (indexPath.row == 2) {
            [self removeObserver:self forKeyPath:@"undefinedProgress"];
        } else if (indexPath.row == 3) {
            [self removeObserver:self forKeyPath:@"progress"];
            [self removeObserver:self forKeyPath:@"progress"];
        }
    } else if (indexPath.section == 8) { // NSTimer
        SimulatorTimerViewController *vc = [[SimulatorTimerViewController alloc] init];
        vc.title = @"Timer Test";
        vc.isScheduledTimer = (indexPath.row == 0);
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 9) { // NSNotification
        SimulatorNotificationViewController *vc = [[SimulatorNotificationViewController alloc] init];
        vc.title = @"Notification Test";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

@end
