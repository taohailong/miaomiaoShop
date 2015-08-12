//
//  OneLabelTableHeadView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/7.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OneLabelTableHeadView.h"

@implementation OneLabelTableHeadView

-(id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    _firstLabel = [[UILabel alloc]init];
    _firstLabel.textColor = FUNCTCOLOR(180, 180, 180);
    _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_firstLabel];
    
    [self setLayout];
    return self;
}

-(void)setSelectBk:(TableHeadBk)bk
{
    _bk = bk;
}


-(void)setLayout
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_firstLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];

}
-(UILabel*)getFirstLabel
{
    return _firstLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
