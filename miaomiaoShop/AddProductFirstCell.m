//
//  AddFirstCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductFirstCell.h"
@interface AddProductFirstCell()<UITextFieldDelegate>
{

}
@end
@implementation AddProductFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithBlock:(CellBtBlock)bk WithFieldBk:(TextFieldBk)fieldBk
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.textLabel.text = @"条形码:";
    self.textLabel.font = [UIFont systemFontOfSize:14];

    _bk =bk;
    _fieldBk = fieldBk;
    
    _scanBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _scanBt.frame = CGRectMake(0, 0, 45, 45) ;
    [_scanBt setTitle:@"查一查" forState:UIControlStateNormal];
//    [_scanBt setImage:[UIImage imageNamed:@"ProductEditScan"] forState:UIControlStateNormal];
//    _scanBt.backgroundColor = [UIColor redColor];
    _scanBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [_scanBt addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView = _scanBt;

    _contentField = [[UITextField alloc]initWithFrame:CGRectMake(63, 15, 190, 30)];
    _contentField.delegate= self;
    _contentField.font = [UIFont systemFontOfSize:15];
     _contentField.center = CGPointMake(SCREENWIDTH/2, 30);
    _contentField.keyboardType = UIKeyboardTypeNumberPad;
    _contentField.returnKeyType = UIReturnKeyDone;
    _contentField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:_contentField];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

-(void)setTextField:(NSString*)fieldStr
{
    _contentField.text  = fieldStr;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (_fieldBk) {
        
        NSString* subStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        _fieldBk(subStr);
    }
    
    return YES;
}


-(void)btAction
{
    if (_bk) {
       _bk();
    }
   
}
@end
