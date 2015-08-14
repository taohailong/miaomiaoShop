//
//  ManageMainCateList.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCategoryData.h"

@class ManageMainCateList;
@protocol ManageMainCateListProtocol <NSObject>

-(void)selectMainCateReturnSubClass:(NSMutableArray*)arr cateGoryID:(NSString*)str;

@end
@interface ManageMainCateList : UIView<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger _currentIndex;
    UITableView* _table;
    NSMutableArray *_dataArr;
}
@property(nonatomic,weak)id<ManageMainCateListProtocol> delegate;
-(void)initNetData;
-(void)setProductEditStyle:(BOOL)flag;
-(ShopCategoryData*)getSelectCategory;
@end
