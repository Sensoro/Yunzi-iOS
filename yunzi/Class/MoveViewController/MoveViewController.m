//
//  MoveViewController.m
//  YZ
//
//  Created by 回特 on 14-6-30.
//  Copyright (c) 2014年 huiter. All rights reserved.
//

#import "MoveViewController.h"
#import "EarthLoadingView.h"

@interface MoveViewController ()
@property (nonatomic, strong) EarthLoadingView * earth;

@end

@implementation MoveViewController

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
    
    _earth = [[EarthLoadingView alloc]init];
    self.earth.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2-20);
    [self.view addSubview:self.earth];
    
    [self.earth startAnimating];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    label.textColor = UIColorFromRGB(0xdcdcdc);
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 110;
    label.deFrameTop = self.earth.deFrameBottom+20;
    [self.view addSubview:label];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.count = self.count;
    self.status = self.status;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCount:(NSNumber *)count
{
    int i = [count integerValue] - [self.count integerValue];
    
    if (i > 0 && self.count) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.center = CGPointMake(kScreenWidth/2, 50);
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xdcdcdc);
        label.textAlignment = NSTextAlignmentLeft;
        label.deFrameTop = self.earth.deFrameBottom+20;
        label.deFrameLeft = kScreenWidth/2 + 50;
        label.text = [NSString stringWithFormat:@"%+d", i];
        label.alpha = 0;
        [self.view addSubview:label];
        
        [UIView animateWithDuration:0.6 animations:^{
            label.alpha = 1;
            label.deFrameBottom = label.deFrameBottom - 15;
        }completion:^(BOOL finished) {
            [label removeFromSuperview];
            _count = count;
            [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"Move Count", @""),count]];
        }];
    }
    else
    {
        _count = count;
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@：%@",NSLocalizedString(@"Move Count", @""),count]];
    }
}

- (void)setStatus:(NSNumber *)status
{
    _status = status;
    if ([status boolValue]) {
        [self.earth startAnimating];
    }
    else
    {
        [self.earth stopAnimating];
    }
}

@end
