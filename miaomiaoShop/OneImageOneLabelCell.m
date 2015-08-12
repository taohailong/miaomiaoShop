//
//  OneImageOneLabelCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OneImageOneLabelCell.h"

@implementation OneImageOneLabelCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _cellImageView = [[UIImageView alloc]init];
    _cellImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_cellImageView];
    
    _cellLabel  = [[UILabel alloc]init];
    _cellLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_cellLabel];

//    [self setLayout];
    
    return self;
}

-(UILabel*)getCellLabel
{
    return _cellLabel;
}


-(UIImageView*)getCellImageView
{
    return _cellImageView;
}
-(void)setLayout
{
  
}
@end
