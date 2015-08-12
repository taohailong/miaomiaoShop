//
//  FourLabelCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "FourLabelCell.h"

@implementation FourLabelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _fourthLabel = [[UILabel alloc]init];
    _fourthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_fourthLabel];
    return self;
}
-(UILabel*)getFourthLabel
{
    return _fourthLabel;
}
@end
