//
//  AddProductSwithCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductSwithCell.h"

@implementation AddProductSwithCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    self.textLabel.text = @"条形码:";
    self.textLabel.font = [UIFont systemFontOfSize:14];
    //
    _contentSwitch = [[TSwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH-60, 10, 45, 25)];
//    _contentSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0, 0, 45, 30)];
//    _contentSwitch.onImage = [UIImage imageNamed:@"float_about"];
    _contentSwitch.onTintColor = DEFAULTNAVCOLOR;
//    _contentSwitch.thumbTintColor = [UIColor redColor];
//    _contentSwitch.tintColor = [UIColor redColor];
    [_contentSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
//    self.accessoryView = _contentSwitch;
    
    [self.contentView addSubview:_contentSwitch];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

       return self;
}
-(void)setSwitchBlock:(switchActionBack)bk
{
    _block = bk;
}

-(void)switchAction
{
    if (_block) {
         _block(_contentSwitch.on);
    }
   
}
-(void)setSWitchStatue:(int)statue
{
    if (statue) {
        _contentSwitch.on = YES;
    }
    else
    {
        _contentSwitch.on = NO;
    }
   
}
@end
