//
//  ShopInfoSubCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoSubCell : UITableViewCell
{
    UILabel* _leftLabel;
    UILabel* _rightLabel;
    
    UILabel* _leftTitle;
    UILabel* _rightTitle;
    
    UIView* _separateView;
}
-(void)setLeftLabelStr:(NSString*)str;
-(void)setRightLabelStr:(NSString*)str;
@end
