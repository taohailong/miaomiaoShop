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
typedef void (^TextFieldSearchBk)(NSString* text);
@interface AddProductFirstCell : UITableViewCell
{
    UITextField* _contentField;
    UIButton* _scanBt;
    TextFieldBk _fieldBk;
    CellBtBlock _bk;
    TextFieldSearchBk _searchBk;
}
-(UITextField*)getTextField;
-(UILabel*)getTitleLabel;
-(void)setTextFieldBk:(TextFieldBk)bk;
-(void)setCellBtBk:(CellBtBlock)bk;
-(void)setSearchBk:(TextFieldSearchBk)bk;
//-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithBlock:(CellBtBlock)bk WithFieldBk:(TextFieldBk)bk;
-(void)setTextField:(NSString*)fieldStr;
@end
