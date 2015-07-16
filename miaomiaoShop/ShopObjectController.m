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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (IOS_VERSION(7.0)) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    _productView = [[ShopProductListView alloc]init];
    _productView.backgroundColor = [UIColor greenColor];
    _productView.translatesAutoresizingMaskIntoConstraints = NO;
    _productView.delegate = self;
    [self.view addSubview:_productView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_productView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_productView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.7 constant:0]];
    
    
    if (IOS_VERSION(7.0)) {
        
       [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];    }
    else
    {
       [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_productView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
    }
    
    
    
    _categoryView = [[ShopCategoryListView alloc]init];
    _categoryView.translatesAutoresizingMaskIntoConstraints = NO;
    _categoryView.delegate = self;
    [self.view addSubview:_categoryView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_categoryView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_categoryView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_categoryView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0]];
    
    
    if (IOS_VERSION(7.0)) {
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_categoryView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_categoryView)]];    }
    else
    {
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_categoryView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_categoryView)]];
    }

    
    
    
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
    [categoryReq shopGetCategoryWithCallBack:^(NSMutableArray* backDic, NetWorkStatus status) {
        
        [loadV removeFromSuperview];
        if (status != NetWorkStatusSuccess) {
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
