//
//  AppDelegate.h
//  yunzi
//
//  Created by 回特 on 14-10-11.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (BOOL)checkLocationServices;
- (BOOL)checkBluetoothServices;


@end

