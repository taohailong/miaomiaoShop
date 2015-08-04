//
//  OrderInfoSecondCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-2.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderInfoFirstCell : UITableViewCell
-(void)setTelPhoneText:(NSString*)text;

-(void)setAddressText:(NSString*)str
;
-(void)setOrderMessage:(NSString*)str;




-(void)setFirstLabelAtt:(NSAttributedString*)att;
-(void)setSecondLabelAtt:(NSAttributedString*)att;
-(void)setThirdLabelAtt:(NSAttributedString*)att;
@end
