//
//  EarthLoadingView.h
//
//  Created by huiter on 13-7-10.
//  Copyright (c) 2013年 guoku. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarthLoadingView : UIView  {
    BOOL      _isAnimating;
    NSTimer*  _timer;
    BOOL      _hidesWhenStopped;
    NSInteger _currentStep;
    NSInteger _dotCount;
    CGFloat   _duration;
}

@property (nonatomic, assign)BOOL hidesWhenStopped;
@property (nonatomic, assign)NSInteger dotCount;
@property (nonatomic, assign)CGFloat duration;
@property (nonatomic, strong)UIImageView *earth;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

- (id)init;

@end
