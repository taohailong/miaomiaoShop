//
//  AddProductCommonCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductCommonCell.h"
@interface AddProductCommonCell()<UITextFieldDelegate>
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
    


    
//   _contentField = [[UITextField alloc]initWithFrame:CGRectMake(63, 15, 190, 30)];
//    _contentField.center = CGPointMake(SCREENWIDTH/2, 30);
//    NSLog(@"center is %@",NSStringFromCGPoint(_contentField.center));
//    _contentField.borderStyle = UITextBorderStyleRoundedRect;
//    [self.contentView addSubview:_contentField];
//    
    
    _contentField = [[UITextField alloc]init];
    _contentField.font = [UIFont systemFontOfSize:14.0];
    _contentField.translatesAutoresizingMaskIntoConstraints = NO;
    _contentField.borderStyle = UITextBorderStyleRoundedRect;
    _contentField.returnKeyType = UIReturnKeyDone;
    _contentField.delegate = self;
    [self.contentView addSubview:_contentField];
    //
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_textLabel]-5-[_contentField]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textLabel,_contentField)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_contentField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:.6 constant:0]];

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
