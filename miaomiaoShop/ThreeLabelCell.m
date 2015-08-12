//
//  ThreeLabelCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ThreeLabelCell.h"

@implementation ThreeLabelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _thirdLabel = [[UILabel alloc]init];
    _thirdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_thirdLabel];
    
    return self;
}
-(UILabel*)getThirdLabel
{
    return _thirdLabel;
}

@end
