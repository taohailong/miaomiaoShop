//
//  SpreadListCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OrderConfirmCell.h"


@interface SpreadListCell : OrderConfirmCell
{
    UIView* _bottomSeparate;
}
-(UILabel*)getFourthLabel;
-(UILabel*)getSecondLabel;
-(UILabel*)getThirdLabel;
@end
