//
//  OrderData.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderData.h"
#import "ShopProductData.h"
@implementation OrderData
@synthesize orderAddress,orderID,orderStatue,orderTime,telPhone,messageStr,mobilePhone,payWay,productArr,shopName,discountMoney,totalMoney,countOfProduct,orderNu;

-(NSString*)getPayMethod
{
    if ([self.payWay isEqualToString:@"wx"])
    {
        if (self.discountMoney) {
            return [NSString stringWithFormat:@"微信支付(代金券%.1f)",self.discountMoney];
        }
        else
        {
           return @"微信支付";
        }
    }
    else
    {
      return @"货到付款";
    }
}

-(void)setOrderInfoString:(NSString *)string
{
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray* pArr = [NSMutableArray array];
    for (NSDictionary* dic in arr)
    {
        ShopProductData* product = [[ShopProductData alloc]init];
        product.count = [dic[@"count"] intValue];
        self.countOfProduct += product.count;
        product.pName = dic[@"name"];
        product.pUrl = dic[@"pic_url"];
        product.price = [dic[@"price"] floatValue]/100;
        [pArr addObject:product];
    }
    
    self.productArr = pArr;
}


-(void)setOrderStatueWithString:(NSString *)statue
{
    switch ([statue intValue]) {
        case 0:
            self.orderStatue = @"订单确认";
            break;
        case 1:
            self.orderStatue = @"配送中";
            break;
        case 2:
            self.orderStatue = @"用户取消";
            break;
        case 3:
            self.orderStatue = @"商家取消";
            break;
        case 4:
            self.orderStatue = @"确认收货";
            break;
        case 5:
            self.orderStatue = @"客服取消";
            break;

        default:
            break;
    }
    NSLog(@"self.orderStatue %@",self.orderStatue);

}


@end
