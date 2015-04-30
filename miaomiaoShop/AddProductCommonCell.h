//
//  AddProductCommonCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProductCommonCell : UITableViewCell
{
    IBOutlet UILabel* _titleL;
    IBOutlet UITextField* _contentField;
}
-(void)setTextField:(NSString*)fieldStr;
@end
