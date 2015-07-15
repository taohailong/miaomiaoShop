//
//  PCollectionCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ProductCell.h"
typedef void (^CollectionPChanged)(int count);
@interface PCollectionCell : UICollectionViewCell
{
    UIImageView* _productImageView;
    UILabel* _titleL;
    UILabel* _priceL;
    UIButton* _addBt;
    UILabel* _countLabel;
   CollectionPChanged _countBk;
}
-(void)setCountText:(int)count;
-(void)setCountBk:(CollectionPChanged)completeBk;
-(void)setPicUrl:(NSString *)url;
-(void)setPriceStr:(NSString *)price;
-(void)setTitleStr:(NSString *)title;

-(UIImageView*)getImageView;
@end
