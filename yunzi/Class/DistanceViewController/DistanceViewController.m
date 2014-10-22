//
//  LightViewController.m
//  YZ
//
//  Created by 回特 on 14-6-30.
//  Copyright (c) 2014年 huiter. All rights reserved.
//

#import "DistanceViewController.h"

@interface  DistanceViewController ()
@property (nonatomic, assign) NSInteger status;
@end

@implementation  DistanceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0x222222);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    label.textColor = UIColorFromRGB(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 110;
    [self.view addSubview:label];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.distance = self.distance;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDistance:(NSNumber *)distance
{
    _distance = distance;
    if ([distance doubleValue] > 0) {
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@：%0.0fcm",NSLocalizedString(@"Distance", @""),[distance doubleValue]*100]];
    }else{
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"Distance", @""),NSLocalizedString(@"Unknown", @"")]];
    }
}


@end
