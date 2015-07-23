//
//  AddProductSwithCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSwitch.h"
typedef void (^switchActionBack)(BOOL statue);
@interface AddProductSwithCell : UITableViewCell
{
     UILabel* _titleL;
     TSwitch * _contentSwitch;
    switchActionBack _block;
}
-(void)setSwitchBlock:(switchActionBack)bk;
-(void)setSWitchStatue:(int)statue;
@end
