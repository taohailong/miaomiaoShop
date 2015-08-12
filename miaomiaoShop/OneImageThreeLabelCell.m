//
//  OneImageThreeLabelCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OneImageThreeLabelCell.h"

@implementation OneImageThreeLabelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _secondLabel = [[UILabel alloc]init];
    _secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_secondLabel];
    
//    [self setLayout];
    return self;
}

-(UILabel*)getSecondLabel
{
    return _secondLabel;
}

-(void)setLayout
{

}
@end
