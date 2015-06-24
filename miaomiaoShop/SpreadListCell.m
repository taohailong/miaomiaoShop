//
//  SpreadListCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//
//@implementation SpreadTableHeadView
//
//-(id)ini
//
//@end


#import "SpreadListCell.h"
@implementation SpreadListCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _fourthLabel = [[UILabel alloc]init];
    _fourthLabel.font = _firstLabel.font;
    _fourthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_fourthLabel];
    
    
    return self;
}


-(void)setLayout
{
    [super setLayout];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_fourthLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fourthLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_thirdLabel]-6-[_fourthLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdLabel,_fourthLabel)]];
}


-(UILabel*)getFourthLabel
{
    return _fourthLabel;
}
@end
