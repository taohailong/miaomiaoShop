//
//  OrderListCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
-(void)setAddress:(NSString*)address;
-(void)setTephone:(NSString*)tel;
-(void)setPayWay:(NSString*)payWay;
-(void)setPayNu:(NSString*)nu;
-(void)setOrderStatue:(NSString*)statue;
-(void)setOrderMessage:(NSString*)message;
-(void)setTitleText:(NSString*)text;
@end
