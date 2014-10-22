//
//  YunziViewController.h
//  yunzi
//
//  Created by 回特 on 14-10-14.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"
#import "SBKBeacon.h"

@interface YunziViewController : UIViewController<SBKBeaconDelegate>
@property (nonatomic, strong) SBKBeacon *beacon;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView * menuView;
@end
