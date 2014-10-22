//
//  ProximityViewController.m
//  yunzi
//
//  Created by 回特 on 14-10-16.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "ProximityViewController.h"

@interface ProximityViewController ()
@end

@implementation ProximityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0x222222);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    
    UIButton * far = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 280, 280)];
    far.backgroundColor = UIColorFromRGB(0x333333);
    far.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
    far.layer.cornerRadius = 140;
    [far.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [far setTitle:NSLocalizedString(@"Far", @"") forState:UIControlStateNormal];
    [far setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [far setTitleEdgeInsets:UIEdgeInsetsMake(225, 0, 0, 0)];
    [self.view addSubview:far];
    
    UIButton * near = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
    near.backgroundColor = UIColorFromRGB(0x666666);
    near.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
    near.layer.cornerRadius = 90;
    [near.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [near setTitle:NSLocalizedString(@"Near", @"") forState:UIControlStateNormal];
    [near setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [near setTitleEdgeInsets:UIEdgeInsetsMake(115, 0, 0, 0)];
    [self.view addSubview:near];
    
    UIButton * immediate = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    immediate.backgroundColor = UIColorFromRGB(0x999999);
    immediate.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
    immediate.layer.cornerRadius = 40;
    [immediate.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [immediate setTitle:NSLocalizedString(@"Immediate", @"") forState:UIControlStateNormal];
    [immediate setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [self.view addSubview:immediate];
    
    UILabel * image = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    image.text = [NSString fontAwesomeIconStringForEnum:FAMale];
    image.font = [UIFont fontWithName:kFontAwesomeFamilyName size:16];
    image.textColor = UIColorFromRGB(0x222222);
    image.backgroundColor = [UIColor whiteColor];
    image.contentMode = UIViewContentModeScaleAspectFit;
    image.textAlignment = NSTextAlignmentCenter;
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 16;
    image.tag = 100;
    [self.view addSubview:image];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.proximity = self.proximity;
}

-(void)setProximity:(CLProximity)proximity
{
    switch (proximity) {
        case CLProximityUnknown:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self.view viewWithTag:100].center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2+200);
            }];
            break;
        }
        case CLProximityImmediate:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self.view viewWithTag:100].center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
            }];
            break;
        }
        case CLProximityNear:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self.view viewWithTag:100].center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2+65);
            }];
            break;
        }
        case CLProximityFar:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self.view viewWithTag:100].center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2+115);
            }];
            break;
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
