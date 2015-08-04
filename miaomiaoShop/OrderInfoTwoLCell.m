//
//  OrderInfoTwoLCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderInfoTwoLCell.h"
@interface OrderInfoTwoLCell()
{
    UILabel* _firstL;
    UILabel* _secondL;
}
@end
@implementation OrderInfoTwoLCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _firstL = [[UILabel alloc]init];
    _firstL.textColor = FUNCTCOLOR(153, 153, 153);
    _firstL.font = DEFAULTFONT(15);
    _firstL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_firstL];
    
    _secondL = [[UILabel alloc]init];
    _secondL.textColor = DEFAULTNAVCOLOR;
    _secondL.font = DEFAULTFONT(15);
    _secondL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_secondL];

    [self setLayout];
    return self;
}

-(void)setLayout
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstL)]];
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_secondL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_secondL]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL)]];
}


-(void)setFirstLabelText:(NSString*)text
{
    _firstL.text = text;
}

-(void)setSecondLabelText:(NSString*)text
{
    _secondL.text = text;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
