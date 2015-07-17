//
//  FloatView.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/15.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FloatView;

typedef  enum _FloatActionStyle{
    FloatActionSuggestion,
    FloatActionAbout,
    FloatActionLogOut
}FloatActionStyle;

@protocol FloatProtocol <NSObject>

-(void)floatViewSelectStyle:(FloatActionStyle)action;

@end
@interface FloatView : UIView
@property(nonatomic,weak)id<FloatProtocol>delegate;
-(void)hidFloatView;
-(void)showFloatView;
@end
