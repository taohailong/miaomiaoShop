//
//  TwoLabelCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoLabelCell : UITableViewCell
{
    UILabel* _firstLabel;
    UILabel* _secondLabel;
}
-(void)setLayout;
-(UILabel*)getFirstLabel;
-(UILabel*)getSecondLabel;
@end
