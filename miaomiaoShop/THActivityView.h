//
//  THActivityVIew.h
//  xiuba
//
//  Created by 陶海龙 on 14-5-29.
//  Copyright (c) 2014年 hongnuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
typedef void (^LoadErrorBk)(void);
@interface THActivityView : UIView
{
//    UIView *view4;
//    UILabel *label3;
     LoadErrorBk _errorBk ;
    UILabel *labelTitle;
    UIActivityIndicatorView *activityView;
}
-(id)initActivityView;
-(id)initWithString:(NSString*)str;
-(void)show;
-(id)initActivityViewWithSuperView:(UIView*)superView;


-(id)initViewOnWindow;
-(void)loadViewAddOnWindow;



-(id)initWithNetErrorWithSuperView:(UIView*)su;
-(void)setErrorBk:(void(^)(void))completeBk;



-(id)initFullViewTransparentWithSuperView:(UIView*)superView;
//- (void)popOutsideWithDuration:(NSTimeInterval)duration;


//数据为空提示页

-(void)addBtWithTitle:(NSString*)btTitle WithBk:(void(^)(void))actionBk;

-(id)initEmptyDataWarnViewWithString:(NSString*)str WithImage:(NSString*)imageStr WithSuperView:(UIView*)superView
;

@end
