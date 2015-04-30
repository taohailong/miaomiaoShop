//
//  AddProductSwithCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^switchActionBack)();
@interface AddProductSwithCell : UITableViewCell
{
    IBOutlet UILabel* _titleL;
    IBOutlet UISwitch* _contentSwitch;
    switchActionBack _block;
}
-(void)setSwitchBlock:(switchActionBack)bk;
-(void)setSWitchStatue:(int)statue;
@end
