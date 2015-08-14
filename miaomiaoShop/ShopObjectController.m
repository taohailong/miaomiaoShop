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
    NSLayoutConstraint* _btSpaceLayout;
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
        
       [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_productView]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];    }
    else
    {
       [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_productView]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productView)]];
    }
    
    
    
    _categoryView = [[ShopCategoryListView alloc]init];
    _categoryView.translatesAutoresizingMaskIntoConstraints = NO;
    _categoryView.delegate = self;
    [self.view addSubview:_categoryView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_categoryView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_categoryView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_categoryView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.3 constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_categoryView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_productView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
   
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_categoryView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_productView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    
    
    
    UIButton* rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setTitle:@"添加商品" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(addProductAction) forControlEvents:UIControlEventTouchUpInside];
    
    rightBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rightBt];
    
    _btSpaceLayout = [NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:CGRectGetWidth(self.view.frame)/2];
    [self.view addConstraint:_btSpaceLayout];

    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_productView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    
    [rightBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
    
    
    
    
    
    UIButton* leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setTitle:@"编辑商品" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(editProductInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    leftBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:leftBt];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_productView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBt]-0-[rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt,rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt)]];
    
    [leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLight"] forState:UIControlStateNormal];
}

-(void)addProductAction
{
    __weak ShopProductListView* wProductV = _productView;
    __weak NSString* wCategoryID = _currentCategoryID;
//     __weak NSString* wCateName = _currentCateName;
    AddProductController* addProduct = [[AddProductController alloc]init];
    [addProduct setCompleteBk:^{
//        [wProductV setMainCategoryName:wCateName];
        [wProductV  setCategoryIDToGetData:wCategoryID];
    }];
    addProduct.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:addProduct animated:YES];
}


-(void)editProductInfo:(UIButton*)bt
{
    bt.tag = !bt.tag;
    if (bt.tag == 1) {
        _btSpaceLayout.constant = 0;
       [_productView setProductEditStyle:YES];
       [bt setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        [bt setTitle:@"编辑产品" forState:UIControlStateNormal];
        _btSpaceLayout.constant = CGRectGetWidth(self.view.frame)/2;
       [_productView setProductEditStyle:NO];
    }
   
}






#pragma mark -mainCategoryDelegate

-(void)didSelectSubCategory:(NSString *)categoryID WithName:(NSString *)name
{
    _currentCategoryID = categoryID;
    [_productView setCategoryIDToGetData:categoryID];
}

-(void)didSelectMainCategory:(NSString *)categoryID WithName:(NSString *)name
{
    _currentCateName = name;
    [_productView setMainCategoryName:name];
}


#pragma mark-ProductSelectDelegate

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
