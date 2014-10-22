//
//  LightViewController.m
//  YZ
//
//  Created by 回特 on 14-6-30.
//  Copyright (c) 2014年 huiter. All rights reserved.
//

#import "LightViewController.h"

@interface LightViewController ()
@property (nonatomic, assign) NSInteger status;
@end

@implementation LightViewController

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
    
    UILabel * image = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    image.font = [UIFont fontWithName:kFontAwesomeFamilyName size:60];
    image.textColor = [UIColor clearColor];
    image.backgroundColor = UIColorFromRGB(0xf6f6f6);
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.textAlignment = NSTextAlignmentCenter;
    image.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2-20);
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 40;
    image.tag = 100;
    [self.view addSubview:image];
    
    
    UIView * mask = [[UIView alloc]initWithFrame:image.frame];
    mask.alpha = 0;
    mask.tag = 90;
    mask.center = image.center;
    mask.layer.masksToBounds = YES;
    mask.layer.cornerRadius = 40;
    [self.view addSubview:mask];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.center = CGPointMake(kScreenWidth/2, 0);
    label.deFrameTop = mask.deFrameBottom + 40;
    label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16];
    label.textColor = UIColorFromRGB(0xffffff);
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = 110;
    [self.view addSubview:label];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.light = self.light;
    //self.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setLight:(NSNumber *)light
{
    _light = light;
    
    
    int i = [light intValue];
    if (i > 20000) {
        i = 20000;
    }
    
    NSInteger status = self.status;
    
    if (i < 10) {
        self.status = 0;
    } else if (i > 200) {
        self.status = 2;
    } else {
        self.status = 1;
    }
    
    if (status == self.status) {
        NSString * string;
        UILabel * icon = ((UILabel *)[self.view viewWithTag:100]);
        UIView * mask = ((UIView *)[self.view viewWithTag:90]);
        
        mask.alpha = 0;
        
        if (self.status == 0) {
            string = NSLocalizedString(@"Dark", @"");
            //[icon setText:[NSString fontAwesomeIconStringForEnum:FAStarO]];
            [icon setBackgroundColor:UIColorFromRGB(0x3333333)];
            icon.textColor = UIColorFromRGB(0xf8cb4e);
        }
        else if (self.status == 2) {
            string = NSLocalizedString(@"Bright", @"");
            //[icon setText:[NSString fontAwesomeIconStringForEnum:FASunO]];
            [icon setBackgroundColor:UIColorFromRGB(0xf8cb4e)];
            icon.textColor = UIColorFromRGB(0xf8cb4e);
            self.status = 2;
        } else {
            string = NSLocalizedString(@"Normal", @"");
            //[icon setText:[NSString fontAwesomeIconStringForEnum:FASunO]];
            [icon setBackgroundColor:UIColorFromRGB(0xeeeeee)];
            icon.textColor = UIColorFromRGB(0xf8cb4e);
            self.status = 1;
        }
        string = [NSString stringWithFormat:@"%@ (%d lx)", string, i];
        
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@",string]];
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        UIView * mask = ((UIView *)[self.view viewWithTag:90]);
        //UILabel * icon = ((UILabel *)[self.view viewWithTag:100]);
        
        mask.alpha = 1;
        if (i < 10) {
            mask.backgroundColor = UIColorFromRGB(0x333333);
        } else if (i > 200) {
            mask.backgroundColor = UIColorFromRGB(0xf8cb4e);
        } else {
            mask.backgroundColor = UIColorFromRGB(0xeeeeee);
        }
        
    }completion:^(BOOL finished) {
        
        NSString * string;
        UILabel * icon = ((UILabel *)[self.view viewWithTag:100]);
        UIView * mask = ((UIView *)[self.view viewWithTag:90]);
        
        mask.alpha = 0;
        
        if (self.status == 0) {
            string = NSLocalizedString(@"Dark", @"");
            //[icon setText:[NSString fontAwesomeIconStringForEnum:FAStarO]];
            [icon setBackgroundColor:UIColorFromRGB(0x3333333)];
            icon.textColor = UIColorFromRGB(0xf8cb4e);
        }
        else if (self.status == 2) {
            string = NSLocalizedString(@"Bright", @"");
            //[icon setText:[NSString fontAwesomeIconStringForEnum:FASunO]];
            [icon setBackgroundColor:UIColorFromRGB(0xf8cb4e)];
            icon.textColor = UIColorFromRGB(0xf8cb4e);
            self.status = 2;
        } else {
            string = NSLocalizedString(@"Normal", @"");
            //[icon setText:[NSString fontAwesomeIconStringForEnum:FASunO]];
            [icon setBackgroundColor:UIColorFromRGB(0xeeeeee)];
            icon.textColor = UIColorFromRGB(0xf8cb4e);
            self.status = 1;
        }
        string = [NSString stringWithFormat:@"%@ (%d lx)", string, i];
        
        [((UILabel *)[self.view viewWithTag:110]) setText:[NSString stringWithFormat:@"%@",string]];
       
    }];
    
}


@end
