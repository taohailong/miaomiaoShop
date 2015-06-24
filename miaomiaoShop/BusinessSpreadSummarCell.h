//
//  BusinessSpreadSummarCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessSpreadSummarCell : UITableViewCell
{
    UILabel* _firstLabel;
    UILabel* _secondLabel;
    UILabel* _thirdLabel;
}
-(UILabel*)getFirstLabel;
-(UILabel*)getSecondLabel;
-(UILabel*)getThirdLabel;
-(void)setLayout;
@end
