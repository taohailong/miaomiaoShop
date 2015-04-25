//
//  LastViewOnTable.m
//  yiwugou
//
//  Created by yiwugou on 13-12-11.
//  Copyright (c) 2013年 yiwugou. All rights reserved.
//

#import "LastViewOnTable.h"

@implementation LastViewOnTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        [activityView startAnimating];
        activityView.center = CGPointMake(self.center.x-30, self.center.y);
        [self addSubview:activityView];
        
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 18)];
        
        label.textColor = [UIColor colorWithRed:102/255.0 green:108/255.0 blue:113/255.0 alpha:1];
        label.text = @"加载更多...";
        label.center = CGPointMake(CGRectGetWidth(self.frame)/2.0+25, self.frame.size.height/2);
        label.font = [UIFont boldSystemFontOfSize:15.0];
        label.tag = 2;
        label.backgroundColor = [UIColor clearColor];
        [label sizeToFit];
        [self addSubview:label];
//        [label release];

    }
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self  = [super initWithCoder:aDecoder];
    
    UIActivityIndicatorView* activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [activityView startAnimating];
//    activityView.center = CGPointMake(self.center.x-30, self.center.y);
    [self addSubview:activityView];
    activityView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:0.3 constant:0.0]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:activityView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    
    
    
    
    
//    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 18)];
    UILabel* label = [[UILabel alloc]init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:label];

    label.textColor = [UIColor colorWithRed:102/255.0 green:108/255.0 blue:113/255.0 alpha:1];
    label.text = @"加载更多...";
//    label.center = CGPointMake(CGRectGetWidth(self.frame)/2.0+25, self.frame.size.height/2);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[activityView]-10-[label]-5|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(activityView,label)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[label]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
    
    
    label.font = [UIFont boldSystemFontOfSize:15.0];
    label.tag = 2;
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];
   

    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
