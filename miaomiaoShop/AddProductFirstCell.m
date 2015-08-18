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
    UILabel* _titleLabel;
}
@end
@implementation AddProductFirstCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
   
    _titleLabel = [[UILabel alloc]init];
//    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_titleLabel];
    [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_titleLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];

    
    
    _scanBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanBt.translatesAutoresizingMaskIntoConstraints = NO ;
    [self.contentView addSubview:_scanBt];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_scanBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_scanBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scanBt)]];

    [_scanBt setImage:[UIImage imageNamed:@"addProduct_scan"] forState:UIControlStateNormal];
    [_scanBt addTarget:self action:@selector(btAction) forControlEvents:UIControlEventTouchUpInside];
   

    _contentField = [[UITextField alloc]init];
    _contentField.textColor = FUNCTCOLOR(153, 153, 153);
    _contentField.font = [UIFont systemFontOfSize:15.0];

    _contentField.textAlignment = NSTextAlignmentRight;
    _contentField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_contentField];
    _contentField.delegate= self;
    
     [_contentField setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_contentField]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentField)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_titleLabel]-5-[_contentField]-48-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,_contentField,_scanBt)]];
    
    _contentField.font = [UIFont systemFontOfSize:14];
    _contentField.returnKeyType = UIReturnKeyDone;
    _contentField.borderStyle = UITextBorderStyleNone;

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

-(UITextField*)getTextField
{
    return _contentField;

}

-(UILabel*)getTitleLabel
{
    return _titleLabel;
}

-(void)setSearchBk:(TextFieldSearchBk)bk
{
    _searchBk = bk;

}
-(void)setTextFieldBk:(TextFieldBk)bk
{
    _fieldBk = bk;
}

-(void)setCellBtBk:(CellBtBlock)bk
{
    _bk = bk;
}


-(void)setTextField:(NSString*)fieldStr
{
    _contentField.text  = fieldStr;
}

#pragma mark- textFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length==0) {
        return YES;
    }
    
    if (_searchBk) {
        _searchBk(textField.text);
    }
    return YES;
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
