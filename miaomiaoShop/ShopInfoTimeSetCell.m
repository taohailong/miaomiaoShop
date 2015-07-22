//
//  ShopInfoTimeSetCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoTimeSetCell.h"

@implementation ShopInfoTimeSetCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"营业时间";
    _titleLabel.textColor = FUNCTCOLOR(102, 102, 102);
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
   
    _accessLabel = [[UILabel alloc]init];
    _accessLabel.textColor = FUNCTCOLOR(102, 102, 102);
    _accessLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _accessLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_accessLabel];
    
    [self setLayout];
    return self;
}

-(void)setLayout
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    
    
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_accessLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_accessLabel]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_accessLabel)]];
}

-(void)setAccessLabelStr:(NSString*)str
{
    if (str) {
        _accessLabel.text = str;
    }

}
@end
