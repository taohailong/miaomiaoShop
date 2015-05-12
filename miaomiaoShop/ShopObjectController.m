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
#import "THActivityView.h"
@interface ShopObjectController ()<ShopCategoryProtocol,ShopProductListProtocol>
{
    NSMutableDictionary* _allProductDic;
    NSString* _currentCategoryID;
    NSString* _currentCateName;
//    ShopCategoryData* _currentCategory;
    
}
@end
@implementation ShopObjectController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNetData];
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(addProductAction)];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initNetData) name:SHOPIDCHANGED object:nil];
}

-(void)addProductAction
{
    __weak ShopProductListView* wProductV = _productView;
    __weak NSString* wCategoryID = _currentCategoryID;

    AddProductController* addProduct = [[AddProductController alloc]init];
    [addProduct setCompleteBk:^{
        [wProductV  setCategoryIDToGetData:wCategoryID];
    }];
    addProduct.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:addProduct animated:YES];
}


-(void)initNetData
{
    __weak ShopObjectController* wself = self;
    THActivityView* loadV = [[THActivityView alloc]initActivityViewWithSuperView:self.view];
    NetWorkRequest* categoryReq = [[NetWorkRequest alloc]init];
    [categoryReq shopGetCategoryWithCallBack:^(NSMutableArray* backDic, NSError *error) {
        
        [loadV removeFromSuperview];
        if (error) {
            THActivityView* loadView = [[THActivityView alloc]initWithNetErrorWithSuperView:wself.view];
            
            [loadView setErrorBk:^{
                [wself initNetData];
            }];
            return ;
        }
        
        [_categoryView setDataArrAndSelectOneRow :backDic];
        
        if (backDic.count) {
            ShopCategoryData* firstData = backDic[0];
            _currentCateName = firstData.categoryName;
            _currentCategoryID = firstData.categoryID;
            [_productView setCategoryIDToGetData:firstData.categoryID];
        }
    }];
    [categoryReq startAsynchronous];
    
}


-(void)didSelectCategoryIndexWith:(NSString *)categoryID WithName:(NSString *)name
{
    _currentCategoryID = categoryID;
    _currentCateName = name;
    [_productView setCategoryIDToGetData:categoryID];
}

-(void)didSelectProductIndex:(ShopProductData*)product
{
    __weak ShopProductListView* wProductV = _productView;
    
    product.categoryName = _currentCateName;
    ProductEditController* editController = [[ProductEditController alloc]initWithProductData:product];
    editController.hidesBottomBarWhenPushed = YES;
    [editController setCompleteBk:^{
        [wProductV  reloadTable];

    }];
    [self.navigationController pushViewController:editController animated:YES];
}
@end
