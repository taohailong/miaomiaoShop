//
//  ManageCateSubList.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCategoryData.h"
@interface ManageSubCateList : UIView<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _currentIndex;
    NSMutableArray* _dataArr;
    UITableView* _table;
}
-(void)setDataArrReloadTable:(NSMutableArray *)dataArr;
-(void)setProductEditStyle:(BOOL)flag;
-(ShopCategoryData*)getCurrentCategory;
@end
