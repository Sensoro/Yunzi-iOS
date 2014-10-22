//
//  CheckViewController.m
//  yunzi
//
//  Created by 回特 on 14-10-17.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "CheckViewController.h"

@interface CheckViewController ()
@property (nonatomic,strong)NSTimer * timer;
@end

@implementation CheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0x222222);
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kStatusBarHeight - kNavigationBarHeight);
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
        label.backgroundColor = [UIColor clearColor];
        label.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2-100);
        label.font = [UIFont fontWithName:@"STHeitiSC" size:30];
        label.textColor = UIColorFromRGB(0xdcdcdc);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 2;
        label.text =NSLocalizedString(@"Check-Tips", @"");
        [self.view addSubview:label];
    }
    
    {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 240, 120)];
        view.backgroundColor = UIColorFromRGB(0x333333);
        view.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2+25);
        [self.view addSubview:view];
    }
    
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2);
        label.font = [UIFont fontWithName:@"STHeitiSC" size:30];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.text = NSLocalizedString(@"Location Services", @"");
        [self.view addSubview:label];
    }
    
    {
        UILabel * image = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
        image.text = [NSString fontAwesomeIconStringForEnum:FAtoggleOff];
        image.font = [UIFont fontWithName:kFontAwesomeFamilyName size:16];
        image.textColor = UIColorFromRGB(0x222222);
        image.backgroundColor = [UIColor whiteColor];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.textAlignment = NSTextAlignmentCenter;
        image.center = CGPointMake(kScreenWidth/2+80, self.view.bounds.size.height/2);
        image.layer.masksToBounds = YES;
        image.layer.cornerRadius = 16;
        image.tag = 1001;
        [self.view addSubview:image];
    }
    
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height/2+50);
        label.font = [UIFont fontWithName:@"STHeitiSC" size:30];
        label.textColor = UIColorFromRGB(0xffffff);
        label.textAlignment = NSTextAlignmentLeft;
        label.text = NSLocalizedString(@"Bluetooth", @"");
        [self.view addSubview:label];
    }
    
    {
        UILabel * image = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
        image.text = [NSString fontAwesomeIconStringForEnum:FAtoggleOff];
        image.font = [UIFont fontWithName:kFontAwesomeFamilyName size:16];
        image.textColor = UIColorFromRGB(0x222222);
        image.backgroundColor = [UIColor whiteColor];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.textAlignment = NSTextAlignmentCenter;
        image.center = CGPointMake(kScreenWidth/2+80, self.view.bounds.size.height/2+50);
        image.layer.masksToBounds = YES;
        image.layer.cornerRadius = 16;
        image.tag = 1002;
        [self.view addSubview:image];
    }
    
    
    UIButton * dismiss = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    dismiss.backgroundColor = UIColorFromRGB(0xffffff);
    dismiss.layer.cornerRadius = 30;
    dismiss.center = CGPointMake(kScreenWidth/2, self.view.bounds.size.height - 100);
    dismiss.hidden = YES;
    dismiss.tag = 1003;
    [dismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismiss];
    
    [self refresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Refresh
- (void)refresh
{
    UILabel * location = (UILabel *)[self.view viewWithTag:1001];
    UILabel * bluetooth = (UILabel *)[self.view viewWithTag:1002];
    UIButton * dismiss = (UIButton *)[self.view viewWithTag:1003];
    if ([kAppDelegate checkLocationServices]) {
        location.text = [NSString fontAwesomeIconStringForEnum:FAtoggleOn];
    }
    else
    {
        location.text = [NSString fontAwesomeIconStringForEnum:FAtoggleOff];
    }
    if ([kAppDelegate checkBluetoothServices]) {
        bluetooth.text = [NSString fontAwesomeIconStringForEnum:FAtoggleOn];
    }
    else
    {
        bluetooth.text = [NSString fontAwesomeIconStringForEnum:FAtoggleOff];
    }
    
    if([kAppDelegate checkBluetoothServices]&&[kAppDelegate checkLocationServices])
    {
        dismiss.hidden = NO;
        [self startCircle];
    }
    else
    {
        dismiss.hidden = YES;
        [self stopCircle];
    }
}


- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:NULL];
}





#pragma mark - Circle
- (void)startCircle {
    if (self.timer) return;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(work)
                                                    userInfo:nil
                                                     repeats:YES];
    [self work];
}

- (void)stopCircle {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)work
{
    UIButton * dismiss = (UIButton *)[self.view viewWithTag:1003];
    [self addNewCircleAiPoint:dismiss.center startRadius:30 endRadius:80 duration:0.8];
}

- (void)addNewCircleAiPoint:(CGPoint)point startRadius:(CGFloat)startRadius endRadius:(CGFloat)endRadius duration:(NSTimeInterval)duration{
    UIView *vc = [[UIView alloc] initWithFrame:CGRectMake(0, 0, endRadius * 2.0f, endRadius * 2.0f)];
    vc.userInteractionEnabled = NO;
    vc.center = point;
    vc.backgroundColor = [UIColor clearColor];
    
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathAddArc(aPath, NULL, endRadius, endRadius, startRadius, 0, 2*M_PI, YES);
    CGPathCloseSubpath(aPath);
    
    CGMutablePathRef aPath2 = CGPathCreateMutable();
    CGPathAddArc(aPath2, NULL, endRadius, endRadius, endRadius, 0, 2*M_PI, YES);
    CGPathCloseSubpath(aPath2);
    
    CALayer *layer = [vc layer];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor = NULL;
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeColor = [UIColorFromRGB(0xdcdcdc) CGColor];
    shapeLayer.fillColor = NULL;
    [layer addSublayer:shapeLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.duration = duration;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.fromValue = (__bridge_transfer id)aPath;
    pathAnimation.toValue = (__bridge_transfer id)aPath2;
    [shapeLayer addAnimation:pathAnimation
                      forKey:@"animatePath"];
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration = duration;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    opacityAnimation.fromValue = @(0.8f);
    opacityAnimation.toValue = @(0.0f);
    [shapeLayer addAnimation:opacityAnimation
                      forKey:@"opacityAnimation"];
    
    [self.view addSubview:vc];
    [self.view sendSubviewToBack:vc];
    
    [self performSelector:@selector(removeCircle:) withObject:vc afterDelay:duration + 1];
}

- (void)removeCircle:(UIView *)circle {
    [circle removeFromSuperview];
}


@end
