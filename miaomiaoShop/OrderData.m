//
//  OrderData.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-1.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderData.h"
#import "ShopProductData.h"
#import "DateFormateManager.h"
@implementation OrderData
@synthesize orderAddress,orderID,orderStatue,orderTime,telPhone,messageStr,mobilePhone,payWay,productArr,shopName,discountMoney,totalMoney,countOfProduct,orderNu,orderTakeOver,deadTime;
@synthesize isNew;

-(NSString*)getPayMethod
{
//    [self.payWay isEqualToString:@"wx"]||[self.payWay isEqualToString:@"zfb"]
    
    if (![self.payWay isEqualToString:@""])
    {
        if (self.discountMoney) {
            return [NSString stringWithFormat:@"在线支付(代金券%.2f)",self.discountMoney/100];
        }
        else
        {
           return @"在线支付";
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
            [self setDeadTimeThroughStatus];
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

-(void)setDeadTimeThroughStatus
{
    DateFormateManager* formate = [DateFormateManager shareDateFormateManager];
    [formate setDateStyleString:@"YY-MM-dd HH:mm"];
    NSDate* date = [formate getDateFromString:self.orderTime];
    date = [date dateByAddingTimeInterval:86400.0];
    
    self.deadTime = [formate formateDateToString:date];
}

@end
