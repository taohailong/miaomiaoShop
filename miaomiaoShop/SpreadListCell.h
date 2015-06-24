//
//  SpreadListCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "BusinessSpreadSummarCell.h"

//@interface SpreadTableHeadView : UITableViewHeaderFooterView
//{
//    UILabel* _label;
//}
//@end

@interface SpreadListCell : BusinessSpreadSummarCell
{
    UILabel* _fourthLabel;
}
-(UILabel*)getFourthLabel;
@end
