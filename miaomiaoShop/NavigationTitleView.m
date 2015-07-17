//
//  NavigationTitleView.m
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-19.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "NavigationTitleView.h"
@interface NavigationTitleView()
{
    UILabel* _textLabel;
    UILabel* _detailLabel;
}
@end
@implementation NavigationTitleView
@synthesize delegate;

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
//    self.backgroundColor = [UIColor blackColor];
    
    _textLabel = [[UILabel alloc]init];
    _textLabel.font = DEFAULTFONT(16.5);
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.lineBreakMode = NSLineBreakByClipping;
    [self addSubview:_textLabel];
    _textLabel.textColor = [UIColor whiteColor];
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_textLabel(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];
    
    float setoff = 0;
    if (SCREENWIDTH == 320) {
        setoff = -15;
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:setoff]];
    
     [self addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];
    

    
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageView];

    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_textLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_textLabel]-[imageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel,imageView)]];
    imageView.image = [UIImage imageNamed:@"navBar_narrow"];
    

    
//    _detailLabel = [[UILabel alloc]init];
//    _detailLabel.textAlignment = NSTextAlignmentCenter;
//    _detailLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    _detailLabel.font = DEFAULTFONT(12);
//    _detailLabel.textColor = [UIColor whiteColor];
//    [self addSubview:_detailLabel];
//    
//     [self addConstraint:[NSLayoutConstraint constraintWithItem:_detailLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:setoff]];
//
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_textLabel]-3-[_detailLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel,_detailLabel)]];
//    
    
   
    
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction)];
    
    [self addGestureRecognizer:gesture];
    
    return self;
}


-(UILabel*)getTextLabel
{
    return _textLabel;
}

-(UILabel*)getDetailLabel
{
    return _detailLabel;
}

-(void)gestureAction
{
    if ([self.delegate respondsToSelector:@selector(navigationTitleViewDidTouchWithView:)]) {
        [self.delegate navigationTitleViewDidTouchWithView:self];
    }
}



@end
