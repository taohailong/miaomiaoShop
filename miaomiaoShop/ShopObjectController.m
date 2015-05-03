//
//  ShopInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopObjectController.h"
#import "NetWorkRequest.h"
#import "UserManager.h"
#import "ShopCategoryData.h"
#import "AddProductController.h"
#import "ProductEditController.h"
@interface ShopObjectController ()<ShopCategoryProtocol,ShopProductListProtocol>
{
    NSMutableDictionary* _allProductDic;
//    NSString* _currentCategoryID;
    ShopCategoryData* _currentCategory;
    
}
@end
@implementation ShopObjectController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNetData];
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(addProductAction)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
}

-(void)addProductAction
{
    __weak ShopProductListView* wProductV = _productView;
    __weak NSString* wCategoryID = _currentCategory.categoryID;
//    AddProductController* addProduct = [self.storyboard instantiateViewControllerWithIdentifier:@"AddProductController"];
    AddProductController* addProduct = [[AddProductController alloc]init];
    [addProduct setCompleteBk:^{
        [wProductV  setCategoryIDToGetData:wCategoryID];
    }];
    addProduct.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:addProduct animated:YES];
}


-(void)initNetData
{
    NetWorkRequest* categoryReq = [[NetWorkRequest alloc]init];
    [categoryReq shopGetCategoryWithCallBack:^(NSMutableArray* backDic, NSError *error) {
        
        [_categoryView setDataArrAndSelectOneRow :backDic];
        
        if (backDic.count) {
            ShopCategoryData* firstData = backDic[0];
            _currentCategory = firstData;
            [_productView setCategoryIDToGetData:firstData.categoryID];
        }
    }];
    [categoryReq startAsynchronous];
    
}


-(void)didSelectCategoryIndexWith:(NSString *)categoryID WithName:(NSString *)name
{
    _currentCategory.categoryID = categoryID;
    _currentCategory.categoryName = name;
    [_productView setCategoryIDToGetData:categoryID];
}

-(void)didSelectProductIndex:(ShopProductData*)product
{
    __weak ShopProductListView* wProductV = _productView;
    __weak NSString* wCategoryID = _currentCategory.categoryID;
    
    product.categoryName = _currentCategory.categoryName;
    ProductEditController* editController = [[ProductEditController alloc]initWithProductData:product];
    editController.hidesBottomBarWhenPushed = YES;
    [editController setCompleteBk:^{
        [wProductV  setCategoryIDToGetData:wCategoryID];

    }];
    [self.navigationController pushViewController:editController animated:YES];
}
@end
