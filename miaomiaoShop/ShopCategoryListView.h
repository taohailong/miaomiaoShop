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

-(void)didSelectCategoryIndexWith:(NSString*)categoryID WithName:(NSString*)name;

@end
@interface ShopCategoryListView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
     UITableView* _table;
    NSMutableArray* _dataArr;
}
@property(nonatomic,weak)IBOutlet id<ShopCategoryProtocol>delegate;
//@property(nonatomic,strong)NSMutableArray* dataArr;
-(void)setDataArrAndSelectOneRow:(NSMutableArray *)dataArr;
-(void)initNetData;
@end
