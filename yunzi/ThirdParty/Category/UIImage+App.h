//
//  UIImage+App.h
//  Blueberry
//
//  Created by huiter on 13-10-10.
//  Copyright (c) 2013年 huiter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (App)

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)imageWithSize:(CGSize)newSize;

- (UIImage *)weiboShareImage;

- (NSData *)imageDataLessThan:(NSUInteger)size;

- (NSData *)imageDataLessThan_10K;

- (NSData *)imageData;

@end
