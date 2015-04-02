//
//  AppDelegate.m
//  yunzi
//
//  Created by 回特 on 14-10-11.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "CheckViewController.h"
#import "SBKBeacon.h"
#import "SBKBeaconManager.h"
#import "SBKBeaconManager+Cloud.h"


@interface AppDelegate ()<CBCentralManagerDelegate>
@property(strong, nonatomic)HomeViewController * homeVC;
@property(strong, nonatomic)CLLocationManager * locationManager;
@property(strong, nonatomic)CBCentralManager * CM;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (!self.CM) {
        self.CM = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self customizeAppearance];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.homeVC = [[HomeViewController alloc]init];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:self.homeVC];
    [nav.navigationBar setTranslucent:NO];
    self.window.rootViewController = nav;
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    
    if (iOS8) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }else{
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    }
    NSArray * supportedProximityUUIDs =
    @[[[NSUUID alloc] initWithUUIDString:@"23A01AF0-232A-4518-9C0E-323FB773F5EF"], //Sensoro
      [[NSUUID alloc] initWithUUIDString:@"E2C56DB5-DFFB-48D2-B060-D0F5A71096E0"], //AirLocate
      [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"] ,// Estimote
      [[NSUUID alloc] initWithUUIDString:@"63EA09C2-5345-4E6D-9776-26B9C6FC126C"],// Random for C54
      [[NSUUID alloc] initWithUUIDString:@"FDA50693-A4E2-4FB1-AFCF-C6EB07647825"]// weixin
      ];
    for (NSUUID *uuid  in supportedProximityUUIDs) {
        SBKBeaconID *beaconId = [SBKBeaconID beaconIDWithProximityUUID:uuid];
        [[SBKBeaconManager sharedInstance] startRangingBeaconsWithID:beaconId wakeUpApplication:NO];
    }
    SBKBeaconID *beaconID = [SBKBeaconID beaconIDWithProximityUUID:SBKSensoroDefaultProximityUUID];
    [[SBKBeaconManager sharedInstance] startRangingBeaconsWithID:beaconID
                                               wakeUpApplication:NO];
    [[SBKBeaconManager sharedInstance] requestAlwaysAuthorization];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beacon:) name:SBKBeaconInRangeStatusUpdatedNotification object:nil];
    NSLog(@"%d",[[SBKBeaconManager sharedInstance] respondsToSelector:@selector(setCloudServiceEnable:)]);
 
    [[SBKBeaconManager sharedInstance]addBroadcastKey:@"7b4b5ff594fdaf8f9fc7f2b494e400016f461205"];
    [[SBKBeaconManager sharedInstance] setCloudServiceEnable:YES];
    

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self check];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

-(void)customizeAppearance
{
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x111111)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setShadowImage:[[UIImage imageWithColor:UIColorFromRGB(0x111111) andSize:CGSizeMake(1, 1)] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
}

- (BOOL)checkLocationServices
{
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locationManager.distanceFilter=100.0f;
    }
    BOOL enable=[CLLocationManager locationServicesEnabled];//定位服务是否可用
    int status=[CLLocationManager authorizationStatus];//是否具有定位权限
    if(!enable || status<3){
        if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
        {
            [self.locationManager requestAlwaysAuthorization];//请求权限
        }
        return NO;//需求请求定位权限
    }
    return YES;
}

- (BOOL)checkBluetoothServices
{
    if (!self.CM) {
        self.CM = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    }

    if (self.CM.state == CBCentralManagerStatePoweredOff) {
        return NO;
    }
    else if(self.CM.state == CBCentralManagerStatePoweredOn){
        return YES;
    }
    return YES;
}


- (void)check{
    
    if ([self.window.rootViewController.presentedViewController isKindOfClass:[CheckViewController class]]) {
        [(CheckViewController *)self.window.rootViewController.presentedViewController refresh];
    }
    
    if ([self checkBluetoothServices]&&[self checkLocationServices]) {

    }
    else
    {
        if (self.window.rootViewController.presentedViewController) {
            return;
        }
        else
        {
            [self.window.rootViewController presentViewController:[[CheckViewController alloc]init] animated:YES completion:NULL];
        }
    }
}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    [self check];
}

- (void)beacon:(NSNotification *)notification {
    SBKBeacon *beacon = notification.object;
    if (!beacon.serialNumber) {
        return;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:beacon.serialNumber]) {
        return;
    }
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground){
        if (beacon.inRange) {
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            NSString * message = [NSString stringWithFormat:@"\U0001F603 IN:%@",beacon.serialNumber];
            notification.alertBody = message;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        else{
            UILocalNotification *notification = [[UILocalNotification alloc] init];
            NSString * message = [NSString stringWithFormat:@"\U0001F628 OUT:%@",beacon.serialNumber];
            notification.alertBody = message;
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        
    }
    else{
        if (beacon.inRange) {
            NSString * message = [NSString stringWithFormat:@"\U0001F603 IN:%@",beacon.serialNumber];
            [SVProgressHUD showImage:nil status:message];
        }
        else{
            NSString * message = [NSString stringWithFormat:@"\U0001F628 OUT:%@",beacon.serialNumber];
            [SVProgressHUD showImage:nil status:message];
        }
    }
}


@end
