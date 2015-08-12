//
//  OneImageOneLabelCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneImageOneLabelCell : UITableViewCell
{
    UILabel* _cellLabel;
    UIImageView* _cellImageView;
}
-(UILabel*)getCellLabel;
-(UIImageView*)getCellImageView;
-(void)setLayout;
@end
