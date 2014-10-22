//
//  TitleView.m
//  Blueberry
//
//  Created by huiter on 13-10-10.
//  Copyright (c) 2013年 GuoKu. All rights reserved.
//

#import "TitleView.h"

@implementation TitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (UIView *)setTitleLabel:(NSString *)title
{
    UIView * titleV = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 140.0f, 30.0f)];
    UILabel *tableViewTitleL = [[UILabel alloc] initWithFrame:titleV.frame];
    tableViewTitleL.backgroundColor = [UIColor clearColor];
    tableViewTitleL.text = title;
    tableViewTitleL.textColor = [UIColor whiteColor];
    tableViewTitleL.shadowOffset = CGSizeMake(0.0f,1.0f);
    tableViewTitleL.textAlignment = NSTextAlignmentCenter;
    tableViewTitleL.adjustsFontSizeToFitWidth = YES;
    tableViewTitleL.font =  [UIFont systemFontOfSize:18];
    [titleV addSubview:tableViewTitleL];
    
    return titleV;
}


@end
