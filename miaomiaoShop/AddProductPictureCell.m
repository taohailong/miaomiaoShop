//
//  AddProductPictureCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductPictureCell.h"
#import "UIButton+WebCache.h"
@implementation AddProductPictureCell

-(void)setPhotoBlock:(setUpPhotoGraph)photoGraphBlock
{
    _photoGraphBlock = photoGraphBlock;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _pBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _pBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_pBt];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_pBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pBt)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_pBt]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pBt)]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_pBt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_pBt attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0]];
    
    
    [_pBt setImage:[UIImage imageNamed:@"addProduct_pic"] forState:UIControlStateNormal];
    [_pBt addTarget:self action:@selector(setUpPhoto:) forControlEvents:UIControlEventTouchUpInside];
   
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    return self;

}

-(void)setProductImage:(UIImage *)image
{
//    _pBt.image = image;

}

-(UIImage*)getProductImage
{
    return _pBt.currentImage;
}
-(void)setUpPhoto:(UIButton*)bt
{
    if (_photoGraphBlock) {
        _photoGraphBlock();
    }
}

-(void)setProductImageWithUrl:(NSString *)url
{
    [_pBt setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal];
}

@end
