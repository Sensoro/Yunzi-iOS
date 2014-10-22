//
//  TemperatureViewController.m
//  YZ
//
//  Created by 回特 on 14-6-30.
//  Copyright (c) 2014年 huiter. All rights reserved.
//

#import "TemperatureViewController.h"

@interface TemperatureViewController ()
@property (nonatomic, strong) UIImageView * yellow;
@property (nonatomic, strong) UIImageView * green;
@property (nonatomic, strong) UIImageView * red;
@end

@implementation TemperatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    
    _green = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"green"]];
    self.green.frame = self.view.bounds;
    self.green.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.green.contentMode = UIViewContentModeScaleAspectFill;
    self.green.tag =200;
    [self.view addSubview:self.green];
    
    _yellow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"yellow"]];
    self.yellow.frame = self.view.bounds;
    self.yellow.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.yellow.contentMode = UIViewContentModeScaleAspectFill;
    self.yellow.tag =200;
    [self.view addSubview:self.yellow];
    
    _red = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"red"]];
    self.red.frame = self.view.bounds;
    self.red.backgroundColor = UIColorFromRGB(0xeeeeee);
    self.red.contentMode = UIViewContentModeScaleAspectFill;
    self.red.tag =200;
    [self.view addSubview:self.red];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.center = CGPointMake(kScreenWidth/2, 0);
    label.deFrameBottom = self.view.bounds.size.height - 40;
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:30];
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
    self.temperature = self.temperature;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTemperature:(NSNumber *)temperature
{
    _temperature = temperature;
    int i = [temperature intValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.green.alpha = (25-i)/25.0;
        self.yellow.alpha = (i-10)/15.0;
        self.red.alpha = (i-20)/15.0;
        
        if (i > 35) { self.red.alpha = 1; }
        if (i > 25) { self.yellow.alpha = 1; }
        if (i > 25) { self.green.alpha = 0; }
        
        if (i < 20) { self.red.alpha = 0; }
        if (i < 10) { self.yellow.alpha = 0; }
        if (i < 0) { self.green.alpha = 1; }
        
    }];
    if(temperature)
    {
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@ ℃",temperature]];
    }else{
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"未开启"]];
    }
}


@end
