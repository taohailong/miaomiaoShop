//
//  OrderHeadCell.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-18.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderHeadCell.h"
@interface OrderHeadCell()
{
    UIImageView* _titleImage;
    UILabel* _titleLabel;
    UILabel* _statusLabel;
}
@end
@implementation OrderHeadCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleImage = [[UIImageView alloc]init];
    _titleImage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleImage];
//    _titleImage.backgroundColor = [UIColor redColor];
    
    [_titleImage setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleImage)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_titleImage]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleImage)]];

    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = DEFAULTFONT(15);
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.textColor = FUNCTCOLOR(153, 153, 153);
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.contentView addSubview:_titleLabel];
    
    

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_titleImage]-6-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleImage,_titleLabel)]];
    

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    _statusLabel = [[UILabel alloc]init];
    _statusLabel.font = DEFAULTFONT(15);
    _statusLabel.textColor = DEFAULTGREENCOLOR;
    _statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_statusLabel];
    
    
    [_statusLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_titleLabel]-[_statusLabel]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,_statusLabel)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_statusLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    return self;

}

-(void)setTitleImage:(UIImage*)image
{
    _titleImage.image = image;
}

-(UILabel*)getTitleLabel
{
    return _titleLabel;
}

-(UILabel*)getStatusLabel
{
    return _statusLabel;
}

@end
