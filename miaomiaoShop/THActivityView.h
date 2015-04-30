//
//  THActivityVIew.h
//  xiuba
//
//  Created by 陶海龙 on 14-5-29.
//  Copyright (c) 2014年 hongnuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface THActivityView : UIView
{
//    UIView *view4;
//    UILabel *label3;
    UILabel *labelTitle;
    UIActivityIndicatorView *activityView;
}
-(id)initActivityView;
-(id)initWithString:(NSString*)str;
-(id)initWithFailView;
-(void)show;
-(id)initActivityViewWithSuperView:(UIView*)superView;

-(id)initViewOnWindow;
-(void)loadViewAddOnWindow;


-(id)initWithRose;
//-(void)activityRoseOnWindow;
- (void)popOutsideWithDuration:(NSTimeInterval)duration;
@end
