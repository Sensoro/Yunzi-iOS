//
//  UIImage+App.m
//  Blueberry
//
//  Created by huiter on 13-10-10.
//  Copyright (c) 2013年 huiter. All rights reserved.
//

#import "UIImage+App.h"

@implementation UIImage (App)
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

// 缩略图
- (UIImage *)imageWithSize:(CGSize)newSize
{
    NSLog(@"size :%@", NSStringFromCGSize(newSize));
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)weiboShareImage
{
    return nil;
//    return [self weiboShareImageType:1];
}

- (NSData *)imageData
{
    return UIImageJPEGRepresentation(self, 1);
}

- (NSData *)imageDataLessThan:(NSUInteger)size
{
    NSData *imageData = UIImageJPEGRepresentation(self, 1);
    
    while (imageData.length > size) {
        UIImage *image = [UIImage imageWithData:imageData];
        UIImage *smallerImage = [image imageWithSize:CGSizeMake(image.size.width * 0.7, image.size.height * 0.7)];
        imageData = UIImageJPEGRepresentation(smallerImage, 0.1);
    }
    
    return imageData;
}

- (NSData *)imageDataLessThan_10K
{
    return [self imageDataLessThan:10 * 1024];
}

@end
