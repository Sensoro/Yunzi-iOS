//
//  YunziViewController.m
//  yunzi
//
//  Created by 回特 on 14-10-14.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "YunziViewController.h"
#import "TemperatureViewController.h"
#import "LightViewController.h"
#import "MoveViewController.h"
#import "DistanceViewController.h"
#import "ProximityViewController.h"
#import "NotificationViewController.h"

@interface YunziViewController ()
@property (strong, nonatomic) TemperatureViewController * temperatureVC;
@property (strong, nonatomic) LightViewController * lightVC;
@property (strong, nonatomic) MoveViewController * moveVC;
@property (strong, nonatomic) DistanceViewController * distanceVC;
@property (strong, nonatomic) ProximityViewController * proximityVC;
@property (strong, nonatomic) NotificationViewController * notificationVC;
@end

@implementation YunziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0x222222);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    [self configInfo];
    [self configMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setBeacon:(SBKBeacon *)beacon{
    _beacon = beacon;
    beacon.delegate = self;
}

- (void)configInfo{
    [[self.view viewWithTag:1000]removeFromSuperview];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    view.backgroundColor = UIColorFromRGB(0x222222);
    view.tag = 1000;
    [self.view addSubview:view];
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(30.f, 20.f,100, 100)];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.layer.cornerRadius = 49;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
        imageView.layer.shadowRadius =10;
        imageView.layer.shadowOpacity = 0.1;
        imageView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        imageView.layer.shadowOffset = CGSizeMake(0, 0);
        [view addSubview:imageView];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 160, 130, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"ID : %X-%X",[self.beacon.beaconID.major integerValue],[self.beacon.beaconID.minor integerValue]];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 180, 130, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"SN : %@",self.beacon.serialNumber];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:13];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100;
        [view addSubview:label];
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2-10, 20, 1, 80)];
    line.backgroundColor = UIColorFromRGB(0xffffff);
    [self.view addSubview:line];
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 20, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"RSSI : %d",self.beacon.rssi];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 40, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        if(self.beacon.temperature)
        {
            label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Temperature", @""),self.beacon.temperature];
        }
        else
        {
            label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Temperature", @""),NSLocalizedString(@"Close", @"")];
        }
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 60, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        if(self.beacon.light)
        {
            label.text = [NSString stringWithFormat:@"%@ : %0.2flx",NSLocalizedString(@"Light", @""),[self.beacon.light doubleValue]];
        }
        else
        {
            label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Light", @""),NSLocalizedString(@"Close", @"")];
        }
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 80, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        if(self.beacon.moving)
        {
            label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Move", @""),self.beacon.moving];
        }
        else
        {
            label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Move", @""),NSLocalizedString(@"Close", @"")];
        }
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 100, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Accelerometer Count", @""),self.beacon.accelerometerCount];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 120, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Hardware", @""),self.beacon.hardwareModelName];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 140, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%@ : %@",NSLocalizedString(@"Firmware", @""),self.beacon.firmwareVersion];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+10, 160, kScreenWidth/2, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = [NSString stringWithFormat:@"%@ : %0.0f%@",NSLocalizedString(@"Battery", @""),[self.beacon.batteryLevel floatValue]*100,@"%"];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:14];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [view addSubview:label];
    }
    

}

- (void)configMenu
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
    view.backgroundColor = UIColorFromRGB(0x222222);
    view.deFrameBottom = self.view.bounds.size.height;
    [self.view addSubview:view];
    
    NSArray * array = @[
                        @{@"icon":[NSString fontAwesomeIconStringForEnum:FAMapMarker], @"title":NSLocalizedString(@"Distance", @"")},
                        @{@"icon":[NSString fontAwesomeIconStringForEnum:FABullseye],@"title":NSLocalizedString(@"Proximity", @"")},
                        @{@"icon":[NSString fontAwesomeIconStringForEnum:FACloud], @"title":NSLocalizedString(@"Temperature", @"")},
                        @{@"icon":[NSString fontAwesomeIconStringForEnum:FALightbulbO], @"title":NSLocalizedString(@"Light", @"")},
                        @{@"icon":[NSString fontAwesomeIconStringForEnum:FARocket], @"title":NSLocalizedString(@"Move", @"")},
                        @{@"icon":[NSString fontAwesomeIconStringForEnum:FARss], @"title":NSLocalizedString(@"Notification", @"")},
                        ];
    
    int i = 0;
    for (NSDictionary * dic in array ) {
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 70, 50)];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel * image = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
        image.text = [dic valueForKey:@"icon"];
        image.font = [UIFont fontWithName:kFontAwesomeFamilyName size:16];
        image.textColor = UIColorFromRGB(0x222222);
        image.backgroundColor = [UIColor whiteColor];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.textAlignment = NSTextAlignmentCenter;
        image.center = CGPointMake(button.deFrameWidth/2, button.deFrameHeight/2-10);
        image.layer.masksToBounds = YES;
        image.layer.cornerRadius = 16;
        [button addSubview:image];
        
        UILabel * label = [[UILabel alloc]initWithFrame:button.bounds];
        label.deFrameHeight = 20;
        label.backgroundColor = [UIColor clearColor];
        label.center = CGPointMake(button.deFrameWidth/2, button.deFrameHeight/2+20);
        label.text = [dic valueForKey:@"title"];
        label.font = [UIFont fontWithName:@"STHeitiSC-Light" size:10];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 100;
        [button addSubview:label];
        
        [view addSubview:button];
        
        button.center = CGPointMake(10+(kScreenWidth-20)/8 + i%4 * (kScreenWidth-20)/4, 15+(view.deFrameHeight-20)/4 + (view.deFrameHeight-20)/2 * floor(i/4));
        i++;
    }
    
    self.menuView = view;
}

#pragma mark - ButtonActions
-(void)buttonAction:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSString * text = ((UILabel *)[button viewWithTag:100]).text;
    if ([text isEqualToString:NSLocalizedString(@"Distance", @"")]) {
        [self shareDistanceVC].distance = @(self.beacon.accuracy);
        [self.navigationController pushViewController:[self distanceVC] animated:YES];
        return;
    }
    if ([text isEqualToString:NSLocalizedString(@"Proximity", @"")]) {
        [self shareProximityVC].proximity = self.beacon.proximity;
        [self.navigationController pushViewController:[self shareProximityVC] animated:YES];
        return;
    }
    if ([text isEqualToString:NSLocalizedString(@"Temperature", @"")]) {
        [self shareTemperatureVC].temperature = self.beacon.temperature;
        [self.navigationController pushViewController:[self shareTemperatureVC] animated:YES];
        return;
    }
    if ([text isEqualToString:NSLocalizedString(@"Light", @"")]) {
        [self shareLightVC].light = self.beacon.light;
        [self.navigationController pushViewController:[self shareLightVC] animated:YES];
        return;
    }
    if ([text isEqualToString:NSLocalizedString(@"Move", @"")]) {
        [self shareMoveVC].status = self.beacon.moving;
        [self shareMoveVC].count = self.beacon.accelerometerCount;
        [self.navigationController pushViewController:[self shareMoveVC] animated:YES];
        return;
    }
    if ([text isEqualToString:NSLocalizedString(@"Notification", @"")]) {
        [self shareNotificationVC].beacon = self.beacon;
        [self.navigationController pushViewController:[self shareNotificationVC] animated:YES];
        return;
    }

}

#pragma mark - DemoVC
- (TemperatureViewController *)shareTemperatureVC
{
    if(!self.temperatureVC)
    {
        self.temperatureVC = [[TemperatureViewController alloc]init];
    }
    return  self.temperatureVC;
}

- (LightViewController *)shareLightVC
{
    if(!self.lightVC)
    {
        self.lightVC = [[LightViewController alloc]init];
    }
    return  self.lightVC;
}
- (MoveViewController *)shareMoveVC
{
    if (!self.moveVC) {
        self.moveVC = [[MoveViewController alloc]init];
    }
    return self.moveVC;
}
- (DistanceViewController *)shareDistanceVC
{
    if (!self.distanceVC) {
        self.distanceVC = [[DistanceViewController alloc]init];
    }
    return self.distanceVC;
}
- (ProximityViewController *)shareProximityVC
{
    if (!self.proximityVC) {
        self.proximityVC = [[ProximityViewController alloc]init];
    }
    return self.proximityVC;
}
- (NotificationViewController *)shareNotificationVC
{
    if (!self.notificationVC) {
        self.notificationVC =[[NotificationViewController alloc]init];
    }
    return self.notificationVC;
}


#pragma mark - SBKDelegate

- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateRSSI:(NSInteger)rssi
{
    [self shareDistanceVC].distance = @(beacon.accuracy);
    [self shareProximityVC].proximity = beacon.proximity;
    [self configInfo];
}

- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateTemperatureData:(NSNumber *)temperature
{
    [self shareTemperatureVC].temperature = temperature;
}

- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateLightData:(NSNumber *)light
{
    [self shareLightVC].light = light;
}

- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateAccelerometerCount:(NSNumber *)accelerometerCount
{
    [self shareMoveVC].count = accelerometerCount;
}

- (void)sensoroBeacon:(SBKBeacon *)beacon didUpdateMovingState:(NSNumber *)isMoving
{
    [self shareMoveVC].status = isMoving;
}

@end
