//
//  ShopInfoTimeSetCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoTimeSetCell : UITableViewCell
{
    UILabel* _titleLabel;
    UILabel* _accessLabel;
}
-(void)setAccessLabelStr:(NSString*)str;
@end
