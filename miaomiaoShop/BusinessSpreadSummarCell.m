//
//  BusinessSpreadSummarCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/6/24.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "BusinessSpreadSummarCell.h"
@interface BusinessSpreadSummarCell()
{
  
}
@end
@implementation BusinessSpreadSummarCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
//    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    _firstLabel = [[UILabel alloc]init];
    _firstLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _firstLabel.font = [UIFont systemFontOfSize:15];
    _firstLabel.textColor = FUNCTCOLOR(153, 153, 153);
    [self.contentView addSubview:_firstLabel];
    

    
    
    
    _secondLabel = [[UILabel alloc]init];
    _secondLabel.font = [UIFont systemFontOfSize:15];
    _secondLabel.textColor = _firstLabel.textColor;
    _secondLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_secondLabel];
    
 
    
    _thirdLabel = [[UILabel alloc]init];
    _thirdLabel.font = [UIFont systemFontOfSize:15];
    _thirdLabel.textColor = _firstLabel.textColor;
    _thirdLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_thirdLabel];
    
    [self setLayout];
    return self;
}

-(void)setLayout
{

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_firstLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel)]];
 
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_firstLabel]-6-[_secondLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_firstLabel,_secondLabel)]];

    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_thirdLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_thirdLabel)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_secondLabel]-6-[_thirdLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_secondLabel,_thirdLabel)]];

}


-(UILabel*)getFirstLabel
{
    return _firstLabel;
}

-(UILabel*)getSecondLabel
{
    return _secondLabel;
}

-(UILabel*)getThirdLabel
{
    return _thirdLabel;
}






@end
