//
//  OrderData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface OrderData : NSObject
{
    UIFont* _addressFont;
    CGSize _addressSize;
    float _addressHeight;
}
@property(nonatomic,strong)NSString* orderAddress;
@property(nonatomic,strong)NSString* orderTime;
@property(nonatomic,strong)NSString* orderID;
@property(nonatomic,strong)NSString* telPhone;
@property(nonatomic,strong)NSString* mobilePhone;
@property(nonatomic,strong)NSString* shopName;
@property(nonatomic,strong)NSString* payWay;
@property(nonatomic,strong)NSString* orderStatue;
@property(nonatomic,strong)NSArray* productArr;
@property(nonatomic,strong)NSString* totalMoney;
@property(nonatomic,strong)NSString* messageStr;
@property(nonatomic,strong)NSString* orderNu;
@property(nonatomic,strong)NSString* orderTakeOver;
@property(nonatomic,strong)NSString* deadTime;
@property(nonatomic,assign)int countOfProduct;
@property(nonatomic,assign)float discountMoney;
@property(nonatomic,assign)BOOL isNew;

//calculate address Height
-(float)getAddressHeight;
-(float)calculateAddressHeightWithFont:(UIFont*)font WithSize:(CGSize)size;



-(void)setOrderInfoString:(NSString*)string;
-(void)setOrderStatueWithString:(NSString *)orderStatue;
-(NSString*)getPayMethod;
@end
