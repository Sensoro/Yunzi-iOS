//
//  NotificationViewController.m
//  yunzi
//
//  Created by 回特 on 14-10-16.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0x222222);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    
    UISwitch * switchControl = [[UISwitch alloc]init];
    switchControl.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2-100);
    [switchControl addTarget:self action:@selector(handleSwitch:) forControlEvents:UIControlEventValueChanged];
    switchControl.tag = 100;
    [self.view addSubview:switchControl];
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
        label.backgroundColor = [UIColor clearColor];
        label.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2+50);
        label.font = [UIFont fontWithName:@"STHeitiSC" size:20];
        label.textColor = UIColorFromRGB(0xdcdcdc);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.text =NSLocalizedString(@"Notification-Tips", @"");
        [self.view addSubview:label];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBeacon:(SBKBeacon *)beacon{
    _beacon = beacon;
    if ([[NSUserDefaults standardUserDefaults]valueForKey:beacon.serialNumber]) {
        ((UISwitch *)[self.view viewWithTag:100]).on = YES;
    }else{
        ((UISwitch *)[self.view viewWithTag:100]).on = NO;
    }
}

- (void)handleSwitch:(UISwitch *)sender{
    if (sender.on) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:self.beacon.serialNumber];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:self.beacon.serialNumber];
    }
}

@end
