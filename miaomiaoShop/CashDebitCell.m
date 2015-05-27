//
//  CashDebitCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-27.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CashDebitCell.h"
@interface CashDebitCell ()
{
   
}
@end
@implementation CashDebitCell
@synthesize titleLabel,contentLabel,detailLabel,subLabel;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    titleLabel = [[UILabel alloc]init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:titleLabel];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    
    contentLabel = [[UILabel alloc]init];
    contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:contentLabel];
    contentLabel.font = titleLabel.font;
    
    
    detailLabel = [[UILabel alloc]init];
    detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:detailLabel];
    detailLabel.font = titleLabel.font;
    
    
    subLabel = [[UILabel alloc]init];
    subLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:subLabel];
    subLabel.font = detailLabel.font;
    
    
    [self subViewLayout];
    return self;

}

-(void)subViewLayout
{
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)]];

    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[contentLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(contentLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel]-10-[contentLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel,contentLabel)]];

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[detailLabel]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLabel)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:detailLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:contentLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    
//    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentLabel]-10-[detailLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(detailLabel,contentLabel)]];

}


@end
