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
}
@end
@implementation BusinessCell

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
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
