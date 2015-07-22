//
//  RootIndicateCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "RootIndicateCell.h"

@implementation RootIndicateCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    _indicateView = [[UIImageView alloc]init];
    _indicateView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_indicateView];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_indicateView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_indicateView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_indicateView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_indicateView)]];
    
    return self;
}

-(void)setIndicateImage:(NSString*)imageName
{
    _indicateView.image = [UIImage imageNamed:imageName];
}

@end
