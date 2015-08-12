//
//  OneImageTwoLabelCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OneImageTwoLabelCell.h"

@implementation OneImageTwoLabelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _firstLabel = [[UILabel alloc]init];
    _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_firstLabel];
    
    
//    [self setLayout];
    return self;
}

-(UILabel*)getFirstLabel
{
    return _firstLabel;
}


-(void)setLayout
{
    
}

@end
