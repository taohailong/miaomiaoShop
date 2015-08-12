//
//  OneImageThreeLabelCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OneImageTwoLabelCell.h"

@interface OneImageThreeLabelCell : OneImageTwoLabelCell
{
    UILabel* _secondLabel;
}
-(UILabel*)getSecondLabel;
@end
