//
//  CashDebitData.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-27.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "CashDebitData.h"
#import <UIKit/UIKit.h>
@interface CashDebitData()
{

}
@end
@implementation CashDebitData
@synthesize debitMoney,debitType,debitStatus,debitTime;
@synthesize spreadMoney;
#pragma mark----------cashDebitController--------

-(NSString*)cashCellContentStr
{
   return [NSString stringWithFormat:@"%@%@元",self.debitType==CashIncome?@"订单收入 +":@"提现 -", self.debitMoney];
}

-(NSAttributedString*)cashCellDetailStr
{
    if(self.debitType==CashIncome)
    {

        NSAttributedString* str = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"推广收入：%.1f元",self.spreadMoney] attributes:@{NSForegroundColorAttributeName:DEFAULTNAVCOLOR}];
        
        return str;

    }
   
    else
    {
        if (self.debitStatus==CashComplete) {
            return [[NSAttributedString alloc]initWithString:@"打款状态：打款完成"] ;
        }
        else
        {
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"打款状态：打款中"];
    
            [str addAttribute:NSForegroundColorAttributeName value:DEFAULTNAVCOLOR range:NSMakeRange(5, 3)];
            
            return str;
        }
    }
}


@end
