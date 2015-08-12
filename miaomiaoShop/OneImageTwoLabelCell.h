//
//  OneImageTwoLabelCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneImageOneLabelCell.h"
@interface OneImageTwoLabelCell : OneImageOneLabelCell
{
    UILabel* _firstLabel;
}
-(UILabel*)getFirstLabel;

@end
