//
//  CashDebitController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-26.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashDebitController : UIViewController
-(id)initWithCash:(float)cash;
@property(nonatomic,assign)BOOL canTake;
@end
