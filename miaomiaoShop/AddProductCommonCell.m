//
//  AddProductCommonCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductCommonCell.h"

@implementation AddProductCommonCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    self.textLabel.text = @"条形码:";
    self.textLabel.font = [UIFont systemFontOfSize:14];
    //
    //
    
    //
    //
    //
    _contentField = [[UITextField alloc]initWithFrame:CGRectMake(63, 15, 190, 30)];
    _contentField.center = CGPointMake(SCREENWIDTH/2, 30);
    NSLog(@"center is %@",NSStringFromCGPoint(_contentField.center));
    _contentField.borderStyle = UITextBorderStyleRoundedRect;
    [self.contentView addSubview:_contentField];
    
//    _contentField.keyboardType = UIKeyboardTypeNumberPad;
    _contentField.returnKeyType = UIReturnKeyDone;
    //
    //    _contentField = [[UITextField alloc]init];
    //    _contentField.translatesAutoresizingMaskIntoConstraints = NO;
    //    _contentField.borderStyle = UITextBorderStyleRoundedRect;
    //    [self.contentView addSubview:_contentField];
    //
    //       [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_contentField]-5-[_scanBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentField,_scanBt)]];
    //
    //    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[_contentField(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentField)]];
    
    return self;
}
-(void)setTextField:(NSString*)fieldStr
{
    _contentField.text  = fieldStr;
}

@end
