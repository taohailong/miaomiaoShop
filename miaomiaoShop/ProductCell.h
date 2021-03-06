//
//  ProductCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum _ProductCellAction{
    ProductCellDelect,
    ProductCellUp
}ProductCellAction;
typedef void (^ProductAction)(ProductCellAction type);


@interface ProductCell : UITableViewCell
-(void)setPicUrl:(NSString*)url;
-(void)setTitleStr:(NSString*)title;
-(void)setPriceStr:(NSString*)price;
-(void)setProductOnOff:(BOOL)flag;
-(void)setProductBk:(ProductAction)bk;
@end
