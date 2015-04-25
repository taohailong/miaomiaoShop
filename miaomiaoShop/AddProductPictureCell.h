//
//  AddProductPictureCell.h
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^setUpPhotoGraph)();
@interface AddProductPictureCell : UITableViewCell
{
//    UILabel* _label;
    UIImageView*_pImageView;
    UIButton* _pBt;
    setUpPhotoGraph _photoGraphBlock;
}
-(void)setProductImage:(UIImage*)image;
//-(void)setPhotoBlock:(void(^)())upSetPhotoGraph;
-(void)setPhotoBlock:(setUpPhotoGraph)photoGraphBlock;
@end
