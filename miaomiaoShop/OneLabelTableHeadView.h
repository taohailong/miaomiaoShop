//
//  OneLabelTableHeadView.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/7.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TableHeadBk)(void);
@interface OneLabelTableHeadView : UITableViewHeaderFooterView
{
    TableHeadBk _bk;
    UILabel* _firstLabel;
}
-(UILabel*)getFirstLabel;
-(void)setSelectBk:(TableHeadBk)bk;
@end
