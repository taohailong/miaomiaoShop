//
//  RootIndicateCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/22.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "PCollectionCell.h"

@interface RootIndicateCell : PCollectionCell
{
    UIImageView* _indicateView;
}
-(void)setIndicateImage:(NSString*)imageName;
@end
