//
//  Config.h
//  yunzi
//
//  Created by huiter on 14-9-10.
//  Copyright (c) 2014年 huiter. All rights reserved.
//


// Display
// Screen Height
#ifndef kScreenHeight
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#endif

// Screen Width
#ifndef kScreenWidth
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#endif

// Status Bar Height
#ifndef kStatusBarHeight
#define kStatusBarHeight 20.f
#endif

// Navigation Bar Height
#ifndef kNavigationBarHeight
#define kNavigationBarHeight 44.f
#endif

// Tool Bar Height
#ifndef kToolBarHeight
#define kToolBarHeight 44.f
#endif

// Tab Bar Height
#ifndef kTabBarHeight
#define kTabBarHeight 49.f
#endif

#ifndef iOS8
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#endif

#ifndef iOS7
#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#endif

#ifndef iOS6
#define iOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#endif

#define kAppDelegate ((AppDelegate *)([UIApplication sharedApplication].delegate))

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#ifndef smile
#define smile @"\U0001F603"
#endif

#ifndef sad
#define sad @"\U0001F628"
#endif

//Category
#import "UIView+DEFrameAdditions.h"
#import "UIImage+App.h"

// FontAwesome
#import "NSString+FontAwesome.h"
#import "FAImageView.h"

// SDWebImage
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"

// SVProgressHUD
#import "SVProgressHUD.h"

//SBK
#import "SBKBeacon.h"
#import "SBKBeaconManager.h"

//TitleView
#import "TitleView.h"

