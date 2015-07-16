//
//  RootDetailCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/16.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootDetailCell : UICollectionViewCell
{
    UILabel* _titleLabel;
    UILabel* _conentLabel;
}
-(void)setTitleLabelStr:(NSString*)str;
-(void)setContentLabelStr:(NSString*)str;
@end
