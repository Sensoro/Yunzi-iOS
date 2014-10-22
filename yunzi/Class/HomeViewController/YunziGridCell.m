//
//  YunziGridCell.m
//  yunzi
//
//  Created by 回特 on 14-10-13.
//  Copyright (c) 2014年 sensoro. All rights reserved.
//

#import "YunziGridCell.h"
#import "YunziItemView.h"


@implementation YunziGridCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = UIColorFromRGB(0xffffff);
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    if (!self.itemArray) {
        _itemArray = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 3; i++) {
            YunziItemView *item = [[YunziItemView alloc] initWithFrame:CGRectMake(0,0,self.bounds.size.width/3,self.bounds.size.height)];
            item.tapBlock = self.tapBlock;
            [self.itemArray addObject:item];
            [self.contentView addSubview:item];
            
            if (i == 0) {
                item.center = CGPointMake(kScreenWidth/6, self.bounds.size.height/2);
            }
            
            if (i == 1) {
                item.center = CGPointMake(kScreenWidth*3/6, self.bounds.size.height/2);
            }
            
            if (i == 2) {
                item.center = CGPointMake(kScreenWidth*5/6, self.bounds.size.height/2);
            }
        }
    }
    
    for (NSUInteger i = 0; i < 3; i++) {
        YunziItemView *item = self.itemArray[i];
        if (i < self.dataArray.count) {
            item.beacon = self.dataArray[i];
        } else {
            item.beacon = nil;
        }
    }
}

+ (CGFloat)height
{
    return 125;
}
@end
