//
//  UIView+DEFrameAdditions.m
//
//  Copyright (c) 2011-2013 Double Encore, Inc. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
//  Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
//  Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer
//  in the documentation and/or other materials provided with the distribution. Neither the name of the Double Encore Inc. nor the names of its
//  contributors may be used to endorse or promote products derived from this software without specific prior written permission.
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
//  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE
//  GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
//  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "UIView+DEFrameAdditions.h"


@implementation UIView (DEFrameAdditions)


#pragma mark - Accessor methods

- (CGPoint)deFrameOrigin
{
    return self.frame.origin;
}


- (void)setDeFrameOrigin:(CGPoint)deFrameOrigin
{
    CGRect frame = self.frame;
    frame.origin = deFrameOrigin;
    self.frame = frame;
}


- (CGFloat)deFrameBottom
{
    return self.deFrameTop + self.deFrameHeight;
}


- (void)setDeFrameBottom:(CGFloat)deFrameBottom
{
    self.deFrameTop = deFrameBottom - self.deFrameHeight;
}


- (CGFloat)deFrameLeft
{
    return self.deFrameOrigin.x;
}


- (void)setDeFrameLeft:(CGFloat)deFrameLeft
{
    self.deFrameOrigin = CGPointMake(deFrameLeft, self.deFrameTop);
}


- (CGFloat)deFrameRight
{
    return self.deFrameLeft + self.deFrameWidth;
}


- (void)setDeFrameRight:(CGFloat)deFrameRight
{
    self.deFrameLeft = deFrameRight - self.deFrameWidth;
}


- (CGFloat)deFrameTop
{
    return self.deFrameOrigin.y;
}


- (void)setDeFrameTop:(CGFloat)deFrameTop
{
    self.deFrameOrigin = CGPointMake(self.deFrameLeft, deFrameTop);
}


- (CGSize)deFrameSize
{
    return self.frame.size;
}


- (void)setDeFrameSize:(CGSize)deFrameSize
{
    CGRect frame = self.frame;
    frame.size = deFrameSize;
    self.frame = frame;
}


- (CGFloat)deFrameHeight
{
    return self.deFrameSize.height;
}


- (void)setDeFrameHeight:(CGFloat)deFrameHeight
{
    self.deFrameSize = CGSizeMake(self.deFrameWidth, deFrameHeight);
}


- (CGFloat)deFrameWidth
{
    return self.deFrameSize.width;
}


- (void)setDeFrameWidth:(CGFloat)deFrameWidth
{
    self.deFrameSize = CGSizeMake(deFrameWidth, self.deFrameHeight);
}


@end
