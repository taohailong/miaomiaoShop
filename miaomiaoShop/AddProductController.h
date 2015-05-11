//
//  AddProductController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProductFirstCell.h"
#import "AddProductSwithCell.h"
#import "AddProductCommonCell.h"
#import "AddProductPictureCell.h"
@class ShopProductData;
typedef void (^AddEditProduct)(void);
@interface AddProductController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AddEditProduct _completeBk;
    ShopProductData* _productData;
    UITableView* _table;
    UIImage* _thumbImage;
}

@property(nonatomic,assign)BOOL infoChange;
-(void)commitProductInfo;
-(void)setCompleteBk:(AddEditProduct)bk;
-(void)commitCompleteBack;
-(void)setUpPhoto;
-(void)postUpImageWithImage:(UIImage*)image WithBk:(void(^)(NSString * url))complete;
//-(void)checkDifference;
@end
