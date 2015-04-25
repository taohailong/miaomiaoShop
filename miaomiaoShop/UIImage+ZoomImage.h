//
//  UIImage+ZoomImage.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZoomImage)
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize  and:(UIImage*)Image;

@end
