//
//  ProductCell.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15-4-23.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "ProductCell.h"
#import "UIImageView+WebCache.h"
@interface ProductCell()
{
    UIImageView* _productImageView;
    UILabel* _titleL;
    UILabel* _priceL;
    UILabel* _statueLabel;
    UIButton* _delectBt;
    UIButton* _upBt;
    ProductAction _bk;
}

@end
@implementation ProductCell
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self creatSubViews];
    return self;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self creatSubViews];
    return self;
}

-(void)creatSubViews
{
    _productImageView = [[UIImageView alloc]init];
    _productImageView.contentMode = UIViewContentModeScaleAspectFit;
    _productImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_productImageView];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[_productImageView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[_productImageView]-2-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_productImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_productImageView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
    
    _titleL = [[UILabel alloc]init];
    _titleL.font = DEFAULTFONT(14);
    _titleL.textColor = FUNCTCOLOR(153, 153, 153);
    _titleL.translatesAutoresizingMaskIntoConstraints = NO;

    _titleL.numberOfLines = 0;
    _titleL.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_titleL];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_productImageView]-5-[_titleL]-3-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView,_titleL)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_titleL(<=50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleL)]];
    
    
    
    _priceL = [[UILabel alloc]init];
    _priceL.font = _titleL.font;
    _priceL.textColor = _titleL.textColor;
    _priceL.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_priceL];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_productImageView]-5-[_priceL]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_productImageView,_priceL)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_priceL]-3-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_priceL)]];
    
    _statueLabel = [[UILabel alloc]init];
    _statueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_statueLabel];
    _statueLabel.backgroundColor = DEFAULTNAVCOLOR;
    _statueLabel.textColor = [UIColor whiteColor];
    _statueLabel.text = @"下架";
    _statueLabel.font = [UIFont boldSystemFontOfSize:10.0];
    _statueLabel.transform = CGAffineTransformMakeRotation(M_PI_4);
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_statueLabel(25)]-(-31)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statueLabel)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_statueLabel(15)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_statueLabel)]];
   
    
    _delectBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _delectBt.hidden = YES;
    [_delectBt setImage:[UIImage imageNamed:@"product_delect"] forState:UIControlStateNormal];
    [_delectBt addTarget:self action:@selector(productAction:) forControlEvents:UIControlEventTouchUpInside];
    _delectBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_delectBt];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_delectBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_delectBt)]];
    
     [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_delectBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_delectBt)]];
    
    
    _upBt = [UIButton buttonWithType:UIButtonTypeCustom];
    _upBt.tag = 1;
    _upBt.hidden = YES;
    [_upBt setImage:[UIImage imageNamed:@"product_up"] forState:UIControlStateNormal];
    [_upBt addTarget:self action:@selector(productAction:) forControlEvents:UIControlEventTouchUpInside];
    _upBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_upBt];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_upBt]-15-[_delectBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_upBt,_delectBt)]];
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_upBt attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_delectBt attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
 }

-(void)setProductOnOff:(BOOL)flag
{
    _statueLabel.hidden = flag;
}

-(void)setPicUrl:(NSString *)url
{
    [_productImageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFAULTIMAGE];
}

-(void)setTitleStr:(NSString *)title
{
    _titleL.text = title;
}

-(void)setPriceStr:(NSString *)price
{
    _priceL.text = [NSString stringWithFormat:@"¥%@",price];
}

-(void)setProductBk:(ProductAction)bk
{
    _bk = bk;
}

-(void)productAction:(UIButton*)bt
{
    if (bt.tag == 0) {
        if (_bk) {
            _bk(ProductCellDelect);
        }
    }
    else
    {
        if (_bk) {
            _bk(ProductCellUp);
        }
    }
    
}


-(void)willTransitionToState:(UITableViewCellStateMask)state
{
    [super willTransitionToState:state];

    if ((state&UITableViewCellStateShowingEditControlMask) == 1)
    {
        _delectBt.hidden = NO;
        _upBt.hidden = NO;
    }
    else
    {
        _delectBt.hidden = YES;
        _upBt.hidden = YES;
    }
    
}


@end
