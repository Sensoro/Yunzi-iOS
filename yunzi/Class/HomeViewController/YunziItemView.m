//
//  YunziItemView.m
//  yunzi
//
//  Created by 回特 on 14-10-13.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "YunziItemView.h"

@implementation YunziItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBeacon:(SBKBeacon *)beacon
{
    _beacon = beacon;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    
    // 云子
    if (!self.imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f,40, 40)];
        self.imageView.backgroundColor = [UIColor whiteColor];
        self.imageView.layer.cornerRadius = 20;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.masksToBounds = YES;
        self.imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2-30);
        self.imageView.layer.shadowRadius =10;
        self.imageView.layer.shadowOpacity = 0.1;
        self.imageView.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        self.imageView.layer.shadowOffset = CGSizeMake(0, 0);
        [self addSubview:self.imageView];
        
    }
    
    //动作按钮
    if (!self.actionButton) {
        _actionButton = [[UIButton alloc] initWithFrame:self.bounds];
        [self.actionButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.actionButton];
    }
    
    // 标题
    if (!self.IDLabel) {
        _IDLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.bounds.size.width, 20)];
        self.IDLabel.font = [UIFont systemFontOfSize:10.f];
        self.IDLabel.textAlignment = NSTextAlignmentCenter;
        self.IDLabel.textColor = UIColorFromRGB(0xffffff);
        self.IDLabel.center = self.imageView.center;
        self.IDLabel.deFrameTop= self.imageView.deFrameBottom + 15;
        [self addSubview:self.IDLabel];
    }

    // 标题
    if (!self.SNLabel) {
        _SNLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.bounds.size.width, 20)];
        self.SNLabel.font = [UIFont systemFontOfSize:10.f];
        self.SNLabel.textAlignment = NSTextAlignmentCenter;
        self.SNLabel.textColor = UIColorFromRGB(0xffffff);
        self.SNLabel.center = self.imageView.center;
        self.SNLabel.deFrameTop= self.IDLabel.deFrameBottom;
        [self addSubview:self.SNLabel];
    }
    

    
    if (!self.beacon) {
        self.hidden = YES;
        return;
    }
    else{
        self.hidden = NO;
        self.imageView.backgroundColor = [UIColor whiteColor];
        [self.IDLabel setText:[NSString stringWithFormat:@"ID: %X-%X",[self.beacon.beaconID.major integerValue],[self.beacon.beaconID.minor integerValue]]];
        [self.SNLabel setText:[NSString stringWithFormat:@"SN: %@",self.beacon.serialNumber]];
    }
}

- (void)buttonAction
{
    if (self.tapBlock) {
        self.tapBlock(self.beacon);
    }
}

@end
