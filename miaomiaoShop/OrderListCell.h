//
//  OrderListCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListCell : UITableViewCell
{
    UIImageView* _titleImage;
    UILabel* _titleLabel;
    UILabel* _nuLabel;
    UILabel* _moneyLabel;
    UILabel*_statusLabel;
    UILabel* _addressLabel;
    UILabel* _telLabel;
}

-(void)setAddress:(NSString*)address;
-(void)setTephone:(NSString*)tel;
-(void)setTotalNu:(NSString*)nu;
-(void)setTotalMoney:(NSString*)money;
-(void)setOrderTime:(NSString*)time;
-(void)setOrderStatus:(NSString*)status;
-(void)setSeparateHeight:(float)height;
//-(void)setPayWay:(NSString*)payWay;
//-(void)setPayNu:(NSString*)nu;
//-(void)setOrderStatue:(NSString*)statue;
//-(void)setOrderMessage:(NSString*)message;
//-(void)setTitleText:(NSString*)text;
@end
