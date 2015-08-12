//
//  ManageCateSubList.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ManageSubCateList : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray* _dataArr;
    UITableView* _table;
}
-(void)setDataArrReloadTable:(NSMutableArray *)dataArr;
-(void)setProductEditStyle:(BOOL)flag;
@end
