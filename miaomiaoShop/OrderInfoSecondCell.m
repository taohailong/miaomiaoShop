//
//  OrderInfoFirstCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderInfoSecondCell.h"
#import "UIImageView+WebCache.h"
@interface OrderInfoSecondCell()
{
    UIImageView* _productImageV;
    UILabel* _titleLabel;
    UILabel* _moneyL;
    UILabel* _nuL;
}
@end
@implementation OrderInfoSecondCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _productImageV = [[UIImageView alloc]init];
    _productImageV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_productImageV];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_productImageV]-3-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageV)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_productImageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageV)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_productImageV attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_productImageV   attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
   
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = DEFAULTFONT(14);
    _titleLabel.textColor = FUNCTCOLOR(153, 153, 153);
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_productImageV]-5-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageV,_titleLabel)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    
    

    
    _moneyL = [[UILabel alloc]init];
    _moneyL.font = _titleLabel.font;
    _moneyL.textColor = _titleLabel.textColor;
    _moneyL.translatesAutoresizingMaskIntoConstraints = NO;
    [_moneyL setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addSubview:_moneyL];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_titleLabel]-[_moneyL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,_moneyL)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_moneyL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    
    
    
    
    _nuL = [[UILabel alloc]init];
    _nuL.font = _titleLabel.font;
    _nuL.textColor = _titleLabel.textColor;
    _nuL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_nuL];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_moneyL]-10-[_nuL]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nuL,_moneyL)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_nuL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];

    return self;
}


-(void)setTotalMoney:(NSString*)str
{
    _moneyL.text = str;
}

-(void)setNuStr:(NSString*)nu
{
    _nuL.text = nu;
}


-(void)setTitleText:(NSString*)str
{
    _titleLabel.text =str;
}

-(void)setProductUrl:(NSString*)url
{
    [_productImageV setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFAULTIMAGE];

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
