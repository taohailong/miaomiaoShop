//
//  ShopCategoryList.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShopCategoryListView;

@protocol ShopCategoryProtocol <NSObject>

-(void)didSelectCategoryIndexWith:(NSString*)categoryID;

@end
@interface ShopCategoryListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
     UITableView* _table;
    NSArray* _dataArr;
}
@property(nonatomic,weak)IBOutlet id<ShopCategoryProtocol>delegate;
//@property(nonatomic,strong)NSMutableArray* dataArr;
-(void)setDataArr:(NSArray *)dataArr;
@end
