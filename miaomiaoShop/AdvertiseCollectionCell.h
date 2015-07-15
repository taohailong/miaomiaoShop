//
//  AdvertiseCollectionCell.h
//  miaomiaoClient
//
//  Created by 陶海龙 on 15/6/30.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PosterScorllView.h"
@interface AdvertiseCollectionCell : UICollectionViewCell<PosterProtocol>
@property(nonatomic,weak)id <PosterProtocol>delegate;
-(void)setImageDataArr:(NSArray*)arr;
@end
