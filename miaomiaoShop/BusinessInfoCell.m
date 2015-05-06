//
//  BusinessInfoCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "BusinessInfoCell.h"
@interface BusinessInfoCell()
{
    UILabel* _titleLabel;
    UILabel* _orderNuLabel;
    UILabel* _takeOverTime;
    UILabel* _orderDeadline;
}
@end
@implementation BusinessInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];

    
    _orderNuLabel = [[UILabel alloc]init];
    _orderNuLabel.font = [UIFont systemFontOfSize:15];
    _orderNuLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_orderNuLabel];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_orderNuLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_orderNuLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-5-[_orderNuLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_orderNuLabel,_titleLabel)]];

    
    _takeOverTime = [[UILabel alloc]init];
    _takeOverTime.font = [UIFont systemFontOfSize:15];
    _takeOverTime.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_takeOverTime];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_takeOverTime]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_takeOverTime)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_orderNuLabel]-5-[_takeOverTime]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_orderNuLabel,_takeOverTime)]];

    
    _orderDeadline = [[UILabel alloc]init];
    _orderDeadline.font = [UIFont systemFontOfSize:15];
    _orderDeadline.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_orderDeadline];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_orderDeadline]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_orderDeadline)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_takeOverTime]-5-[_orderDeadline]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_orderDeadline,_takeOverTime)]];
    
    return self;
}

-(void)setTitleLabelText:(NSString*)text
{
    _titleLabel.text = text;
}

-(void)setOrderNu:(NSString*)text
{
    _orderNuLabel.text = text;
}

-(void)setTakeOverTimeText:(NSString*)text
{
    _takeOverTime.text = text;
}

-(void)setDeadLineTime:(NSString*)text
{
    _orderDeadline.text = text;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
