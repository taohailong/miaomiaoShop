//
//  FourLabelCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ThreeLabelCell.h"

@interface FourLabelCell : ThreeLabelCell
{
    UILabel* _fourthLabel;
}
-(UILabel*)getFourthLabel;
@end
