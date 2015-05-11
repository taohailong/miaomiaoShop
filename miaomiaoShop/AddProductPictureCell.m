//
//  AddProductPictureCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-25.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddProductPictureCell.h"
#import "UIImageView+WebCache.h"
@implementation AddProductPictureCell

-(void)setPhotoBlock:(setUpPhotoGraph)photoGraphBlock
{
    _photoGraphBlock = photoGraphBlock;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.textLabel.text = @"照片:";
    self.textLabel.font = [UIFont systemFontOfSize:14];
    
    
    _pBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _pBt.frame = CGRectMake(0, 0, 45, 60);
//    [_pBt setTitle:@"拍照" forState:UIControlStateNormal];
    [_pBt setImage:[UIImage imageNamed:@"ProductEditPhoto"] forState:UIControlStateNormal];

    [_pBt addTarget:self action:@selector(setUpPhoto:) forControlEvents:UIControlEventTouchUpInside];
    self.accessoryView = _pBt;
    
    _pImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.contentView addSubview:_pImageView];
    _pImageView.center = CGPointMake(SCREENWIDTH/2, 60);
//    _pImageView.backgroundColor = [UIColor redColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    return self;

}

-(void)setProductImage:(UIImage *)image
{
    _pImageView.image = image;

}

-(UIImage*)getProductImage
{
    return _pImageView.image;
}
-(void)setUpPhoto:(UIButton*)bt
{
    _photoGraphBlock();
}

-(void)setProductImageWithUrl:(NSString *)url
{
    [_pImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFAULTIMAGE];
}

@end
