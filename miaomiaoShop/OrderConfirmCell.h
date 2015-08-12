//
//  BusinessInfoCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderConfirmCell : UITableViewCell
{
    UIView* _headSeparateV;
    UIImageView* _imageV;
    UIView* _separateV;
    UILabel* _firstL;
    UILabel* _secondL;
    UILabel* _thirdL;
    UILabel* _fourthL;
}
-(void)setImageViewImageName:(NSString*)name;
-(void)setTitleLabelText:(NSString*)text;
-(void)setSecondLAttribute:(NSAttributedString*)text;
-(void)setThirdLAttribute:(NSAttributedString*)text;
-(void)setFourthAttribute:(NSAttributedString*)text;
-(void)setLayout;
@end
