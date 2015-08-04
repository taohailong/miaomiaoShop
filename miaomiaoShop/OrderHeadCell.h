//
//  OrderHeadCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15-5-18.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderHeadCell : UITableViewCell
-(void)setTitleImage:(UIImage*)image;
-(UILabel*)getTitleLabel;
-(UILabel*)getStatusLabel;
@end
