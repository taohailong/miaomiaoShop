//
//  AddProductCommonCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductCommonCell.h"
@interface AddProductCommonCell()
{
    UILabel* _textLabel;

}
@end
@implementation AddProductCommonCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier WithFieldBk:(TextFieldBk)bk
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    _fieldBk = bk;

    
    _textLabel = [[UILabel alloc]init];
    _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_textLabel];
    _textLabel.font= [UIFont systemFontOfSize:14];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[_textLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel)]];

    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
     [_textLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    
    
    _contentField = [[UITextField alloc]init];
    _contentField.font = [UIFont systemFontOfSize:14.0];
    _contentField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextFieldTextDidChangeNotification object:_contentField];
    
    _contentField.borderStyle = UITextBorderStyleRoundedRect;
    _contentField.returnKeyType = UIReturnKeyDone;
    
    [self.contentView addSubview:_contentField];
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_textLabel]-5-[_contentField]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel,_contentField)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [_contentField setContentCompressionResistancePriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];

    self.selectionStyle = UITableViewCellSelectionStyleNone;

    return self;
}
-(NSString*)getTextFieldString
{
    NSLog(@"text %@",_contentField.text);
    return _contentField.text;
}

-(void)setTextField:(NSString*)fieldStr
{
    _contentField.text  = fieldStr;
}
-(void)setFieldKeyboardStyle:(UIKeyboardType)style
{
    _contentField.keyboardType = style;
}

-(void)setTextTitleLabel:(NSString*)text
{
    _textLabel.text= text;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    if (_fieldBk) {
        
      NSString* subStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSLog(@"text %@ %@",textField.text,subStr);
      _fieldBk(subStr);
    }
    
    return YES;
}
-(void)registeFirstRespond
{
    [_contentField resignFirstResponder];
}


-(void)textChanged:(NSNotification*)notic
{
    if (notic.object!=_contentField) {
        return;
    }
    if (_fieldBk) {
        
        _fieldBk(_contentField.text);
    }

   NSLog(@"field is %@ ",_contentField.text);
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSLog(@"text %@",textField.text);
//}
//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    NSLog(@"text %@",textField.text);
//}
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
// NSLog(@"text %@",textField.text);
//    return YES;
//}
@end
