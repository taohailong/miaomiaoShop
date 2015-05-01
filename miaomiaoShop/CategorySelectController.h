//
//  CategorySelectViewController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CategorySelectBk)(NSString* categoryID,NSString*categoryName);
@interface CategorySelectController : UIViewController
{
    CategorySelectBk _completeBk;
}
-(id)initWithCompleteBk:(CategorySelectBk)bk
;
@end
