//
//  YunziItemView.h
//  yunzi
//
//  Created by 回特 on 14-10-13.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface YunziItemView : UIView

@property (nonatomic, strong) SBKBeacon *beacon;
@property (nonatomic, copy) void (^tapBlock)(SBKBeacon *);

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *SNLabel;
@property (nonatomic, strong) UILabel *IDLabel;
@property (nonatomic, strong) UIButton *actionButton;

@end
