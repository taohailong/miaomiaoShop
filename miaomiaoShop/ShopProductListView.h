//
//  ShopProductListView.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopProductListView,ShopProductData;
@protocol ShopProductListProtocol <NSObject>

-(void)didSelectProductIndex:(ShopProductData*)product;
//-(void)loadMoreProductDataWithIndex:(int)nu;

@end
@interface ShopProductListView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* _table;
}
@property(nonatomic,weak)IBOutlet id<ShopProductListProtocol>delegate;
-(void)setCategoryIDToGetData:(NSString*)categoryID;
-(void)reloadTable;
//-(void)setDataArrReloadTable:(NSMutableArray *)dataArr;
//-(void)addDataArr:(NSMutableArray*)da;
@end
