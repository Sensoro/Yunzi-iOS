//
//  YunziGridCell.h
//  yunzi
//
//  Created by 回特 on 14-10-13.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

@interface YunziGridCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, copy) void (^tapBlock)(SBKBeacon *);

+ (CGFloat)height;

@end
