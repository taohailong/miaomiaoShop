//
//  CommonWebController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-27.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THActivityView.h"

@interface CommonWebController : UIViewController<UIWebViewDelegate>
{
    NSString* _url;
    UIWebView* web;
    THActivityView* _warnView;
}
-(id)initWithUrl:(NSString*)url;
@end
