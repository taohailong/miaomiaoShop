//
//  CashDebitData.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-27.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <Foundation/Foundation.h>

//    {"cash_type":0,"create_time":1432627143000,"id":1,"operate_time":1432627143000,"price":100,"shop_id":1,"status":0}

typedef enum _CashDebitStatus{
    CashSpread,
    CashExpend,
    CashIncome,
    CashComplete,
    CashProcess
}CashDebitStatus;
@interface CashDebitData : NSObject

@property(nonatomic,strong)NSString* debitTime;
@property(nonatomic,strong)NSString* debitMoney;
@property(nonatomic,assign)CashDebitStatus debitStatus;
@property(nonatomic,assign)CashDebitStatus debitType;
@property(nonatomic,assign)float spreadMoney;
-(NSString*)cashCellContentStr;
-(NSAttributedString*)cashCellDetailStr;
//view data


@end
