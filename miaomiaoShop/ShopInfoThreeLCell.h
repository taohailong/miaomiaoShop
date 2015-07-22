//
//  ShopInfoThreeLCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoThreeLCell : UITableViewCell
{
    UILabel* _firstLabel;
    UILabel* _secondLabel;
    UILabel* _thirdLabel;
}
-(void)setFirstLabelStr:(NSString*)str;
-(void)setSecondLabelStr:(NSString*)str;
-(void)setThirdLabelStr:(NSString*)str;
@end
