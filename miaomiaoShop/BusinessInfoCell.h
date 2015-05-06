//
//  BusinessInfoCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessInfoCell : UITableViewCell
-(void)setTitleLabelText:(NSString*)text;
-(void)setOrderNu:(NSString*)text;
-(void)setTakeOverTimeText:(NSString*)text;
-(void)setDeadLineTime:(NSString*)text;
@end
