//
//  TwoLabelCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "TwoLabelCell.h"

@implementation TwoLabelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _firstLabel = [[UILabel alloc]init];
    _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_firstLabel];
    
    _secondLabel = [[UILabel alloc]init];
    _secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_secondLabel];
    
    [self setLayout];
    return self;
}

-(void)setLayout
{
}

-(UILabel*)getFirstLabel
{
    return _firstLabel;
}
-(UILabel*)getSecondLabel
{
    return _secondLabel;
}
@end
