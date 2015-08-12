//
//  CateTableHeadView.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/12.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "OneLabelTableHeadView.h"

@interface CateTableHeadView : OneLabelTableHeadView
{
    UIImageView* _accessoryImage;
    UIView* _headAccessView;
    UIView* _horizeSeparate;
    NSString* _normalImage;
    NSString* _selectImage;
}
-(void)setSelectView;
-(void)disSelectView;
-(void)setAccessImage:(NSString*)image selectImage:(NSString*)selectImage;
@end
