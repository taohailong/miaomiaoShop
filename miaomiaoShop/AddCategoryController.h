//
//  AddCategoryController.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCategoryData.h"
#import "ShopObjectApi.h"
#import "THActivityView.h"
@class AddCategoryController;
@protocol AddCategoryProtocol <NSObject>

-(void)modifyCategoryComplete:(CategoryType)type;

@end


@interface AddCategoryController : UIViewController
{
    NSArray* _dataArr;
    UILabel* _titleLabel;
    UIView* _backView;
    NSString* _currentCate;
}
@property(nonatomic,weak)id<AddCategoryProtocol>delegate;
-(id)initWithCategory:(NSString*)category title:(NSString*)text;
-(void)receiveData:(NSArray*)arr;
-(void)getNetData;
-(void)saveAction;
@end
