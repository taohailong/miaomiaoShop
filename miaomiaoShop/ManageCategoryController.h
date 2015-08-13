//
//  ManagerCategoryController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManageSubCateList.h"
#import "ManageMainCateList.h"
#import "AddCategoryController.h"
@interface ManageCategoryController : UIViewController<ManageMainCateListProtocol,AddCategoryProtocol>
{
    NSLayoutConstraint* _btSpaceLayout;
    ManageMainCateList* _mainCate;
    ManageSubCateList* _subCate;
    UIButton* _rightBt;
    UIButton* _leftBt;
    
    NSString* _selectID;
}
@end
