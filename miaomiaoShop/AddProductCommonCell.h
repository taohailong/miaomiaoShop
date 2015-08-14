//
//  AddProductCommonCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TextFieldBk)(NSString*text);
@interface AddProductCommonCell : UITableViewCell
{
    IBOutlet UILabel* _titleL;
    IBOutlet UITextField* _contentField;
    TextFieldBk _fieldBk;
}
-(void)setTextFieldBk:(TextFieldBk)bk;
-(UITextField*)getTextField;
-(void)registeFirstRespond;
-(void)setTextField:(NSString*)fieldStr;
-(void)setFieldKeyboardStyle:(UIKeyboardType)style;
-(void)setTextTitleLabel:(NSString*)text;
-(NSString*)getTextFieldString;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithFieldBk:(TextFieldBk)bk;
@end
