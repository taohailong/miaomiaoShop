//
//  BusinessCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessCell : UITableViewCell
-(void)setTitleLabelText:(NSString*)str;
-(void)setCountOrderStr:(NSString*)str;
-(void)setTotalMoney:(NSString*)str;
//-(void)setPayStatueStr:(NSString*)str;
//-(void)setPayStatueImage:(UIImage*)image;
//@property(nonatomic,weak)IBOutlet UILabel* payStatueLabel;
@end
