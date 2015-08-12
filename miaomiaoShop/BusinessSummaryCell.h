//
//  BusinessSummaryCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BusinessSummaryBk)(BOOL isLeft);
@interface BusinessSummaryCell : UITableViewCell
{
    BusinessSummaryBk _bk;
}
-(void)setFourthText:(NSString*)text;
-(void)setThirdLText:(NSString*)text;
-(void)setSecondLText:(NSString*)str;
-(void)setFirstLStr:(NSString*)str;
-(void)setBk:(BusinessSummaryBk)bk;
@end
