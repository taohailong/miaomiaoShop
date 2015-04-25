//
//  ShopInfoController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ShopInfoController.h"
#import "NetWorkRequest.h"
#import "UserManager.h"
#import "ShopCategoryData.h"
#import "AddProductController.h"

@interface ShopInfoController ()<ShopCategoryProtocol,ShopProductListProtocol>
{
    NSMutableDictionary* _allProductDic;
    NSString* _currentCategoryID;
     
}
@end
@implementation ShopInfoController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initNetData];
    
    UIBarButtonItem* rightBar = [[UIBarButtonItem alloc]initWithTitle:@"添加商品" style:UIBarButtonItemStylePlain target:self action:@selector(addProductAction)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(void)addProductAction
{
    AddProductController* addProduct = [self.storyboard instantiateViewControllerWithIdentifier:@"AddProductController"];
    addProduct.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:addProduct animated:YES];
}


-(void)initNetData
{
    UserManager* manager = [UserManager shareUserManager];
    
    NetWorkRequest* categoryReq = [[NetWorkRequest alloc]init];
    [categoryReq shopGetCategoryWith:manager.shopID WithCallBack:^(NSMutableArray* backDic, NSError *error) {
        
        [_categoryView setDataArr:backDic];
        
        if (backDic.count) {
            ShopCategoryData* firstData = backDic[0];
            [_productView setCategoryIDToGetData:firstData.categoryID];
        }
    }];
    [categoryReq startAsynchronous];
    
}


-(void)didSelectCategoryIndexWith:(NSString *)categoryID
{
    _currentCategoryID = categoryID;
    [_productView setCategoryIDToGetData:categoryID];
}

-(void)didSelectProductIndex:(NSString *)productID
{

}
@end
