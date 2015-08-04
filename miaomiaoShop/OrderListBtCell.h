//
//  OrderFootCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-18.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderListCell.h"
typedef enum _OrderBtSelect
{
  OrderBtFirst,
  OrderBtSecond,
  OrderBtThird,
  OrderBtFourth
}OrderBtSelect;
typedef void (^BtTargetAction)(OrderBtSelect status);
@interface OrderListBtCell : OrderListCell
{
    UIButton* _firstBt;
    UIButton* _secondBt;
    UIButton* _thirdBt;
    UIButton* _fourthBt;

    BtTargetAction _completeBk;
}
-(UIButton*)getBtWithType:(OrderBtSelect)type;
-(void)setSubLayout;
-(void)setHiddenBtWithType:(OrderBtSelect)type;
-(void)setOrderBk:(BtTargetAction)bk;
@end
