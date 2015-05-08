//
//  BusinessCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-5-4.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "BusinessCell.h"
@interface BusinessCell()
{
    IBOutlet UILabel* _titleLabel;
    IBOutlet UILabel* _countOrder;
    IBOutlet UILabel* _totalMoney;
    
    IBOutlet UIImageView* _payStatueImageV;
//    IBOutlet UILabel* _payStatueLabel;
}

@end
@implementation BusinessCell
@synthesize payStatueLabel;
-(void)setTitleLabelText:(NSString*)str
{
    _titleLabel.text = str;
}


-(void)setCountOrderStr:(NSString*)str
{
    _countOrder.text = str;
}


-(void)setTotalMoney:(NSString*)str
{
    _totalMoney.text = str;
}

//-(void)setPayStatueStr:(NSString*)str
//{
//    _payStatueLabel.text = str;
//}

-(void)setPayStatueImage:(UIImage*)image
{
    _payStatueImageV.image = image;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
