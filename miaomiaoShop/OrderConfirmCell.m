//
//  BusinessInfoCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderConfirmCell.h"
@interface OrderConfirmCell()
{
  
}
@end
@implementation OrderConfirmCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    _headSeparateV = [[UIView alloc]init];
    _headSeparateV.backgroundColor = FUNCTCOLOR(237, 237, 237);
    _headSeparateV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_headSeparateV];

    
    _imageV = [[UIImageView alloc]init];
    _imageV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_imageV];
    
    
    _separateV = [[UIView alloc]init];
    _separateV.backgroundColor = FUNCTCOLOR(221, 221, 221);
    _separateV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_separateV];
    
    
    
    _firstL = [[UILabel alloc]init];
    _firstL.font = DEFAULTFONT(15);
    _firstL.textColor = FUNCTCOLOR(153, 153, 153);
    _firstL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_firstL];
    
    
    _secondL = [[UILabel alloc]init];
    _secondL.font = [UIFont systemFontOfSize:15];
    _secondL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_secondL];
    

    
    _thirdL = [[UILabel alloc]init];
    _thirdL.font = [UIFont systemFontOfSize:15];
    _thirdL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_thirdL];
    

    
    _fourthL = [[UILabel alloc]init];
    _fourthL.font = [UIFont systemFontOfSize:15];
    _fourthL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_fourthL];
    
    
    [self setLayout];
    
    return self;
}

-(void)setLayout
{
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_headSeparateV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headSeparateV)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_headSeparateV(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headSeparateV)]];

    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_imageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageV)]];
    
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_headSeparateV]-10-[_imageV]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headSeparateV,_imageV)]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageV]-5-[_firstL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageV,_firstL)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_imageV attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_separateV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_separateV)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageV]-7-[_separateV(0.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageV,_separateV)]];
    
    
    
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_secondL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_separateV]-8-[_secondL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL,_separateV)]];
    

    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_thirdL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdL)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_secondL]-8-[_thirdL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondL,_thirdL)]];

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_fourthL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fourthL)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_thirdL]-8-[_fourthL]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_fourthL,_thirdL)]];

}

-(void)setImageViewImageName:(NSString*)name
{
    _imageV.image = [UIImage imageNamed:name];
}

-(void)setTitleLabelText:(NSString*)text
{
    _firstL.text = text;
}

-(void)setSecondLAttribute:(NSAttributedString*)text
{
    _secondL.attributedText = text;
}

-(void)setThirdLAttribute:(NSAttributedString*)text
{
    _thirdL.attributedText = text;
}

-(void)setFourthAttribute:(NSAttributedString*)text
{
    _fourthL.attributedText = text;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
