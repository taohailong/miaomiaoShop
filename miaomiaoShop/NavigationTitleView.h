//
//  NavigationTitleView.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-19.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavigationTitleView;
@protocol NavigationTieleViewProtocol <NSObject>

-(void)navigationTitleViewDidTouchWithView:(NavigationTitleView*)titleView;

@end
@interface NavigationTitleView : UIView
@property(nonatomic,weak)id<NavigationTieleViewProtocol>delegate;
-(UILabel*)getTextLabel;
-(UILabel*)getDetailLabel;
@end
