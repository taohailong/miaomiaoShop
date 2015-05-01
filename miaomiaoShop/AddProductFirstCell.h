//
//  AddFirstCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void  (^CellBtBlock)();
typedef void (^TextFieldBk)(NSString*text);
@interface AddProductFirstCell : UITableViewCell
{
    IBOutlet UILabel* _titleL;
    IBOutlet UITextField* _contentField;
    IBOutlet UIButton* _scanBt;
    TextFieldBk _fieldBk;
    CellBtBlock _bk;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithBlock:(CellBtBlock)bk WithFieldBk:(TextFieldBk)bk;
-(void)setTextField:(NSString*)fieldStr;
@end
