//
//  AddCategoryController.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/8/13.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "AddCategoryController.h"
@interface AddCategoryController()
{
    NSString* _titleStr;
}
@end
@implementation AddCategoryController
@synthesize delegate;
-(id)initWithCategory:(NSString*)category title:(NSString*)text
{
   self = [super init];
    _currentCate = category;
    _titleStr = text;
    return self;
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"选择分类";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_titleLabel];
    _titleLabel.font = DEFAULTFONT(14);
    _titleLabel.backgroundColor = FUNCTCOLOR(237, 237, 237);
    _titleLabel.textColor = FUNCTCOLOR(180, 180, 180);
    _titleLabel.text = [NSString stringWithFormat:@"   %@",_titleStr];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_titleLabel]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[_titleLabel(35)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel)]];
    
    
    _backView = [[UIView alloc]init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_backView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_backView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_backView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_titleLabel]-0-[_backView]-55-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLabel,_backView)]];
    
    
    
    UIButton* rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setTitle:@"保存" forState:UIControlStateNormal];
    [rightBt addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    
    rightBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:rightBt];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0 constant:CGRectGetWidth(self.view.frame)/2]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:rightBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rightBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(rightBt)]];
    
    [rightBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedBack"] forState:UIControlStateNormal];
    
    
    
    
    
    UIButton* leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBt setTitle:@"取消" forState:UIControlStateNormal];
    [leftBt addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    leftBt.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:leftBt];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:leftBt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[leftBt]-0-[rightBt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt,rightBt)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[leftBt]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(leftBt)]];
    
    [leftBt setBackgroundImage:[UIImage imageNamed:@"ButtonRedLighter"] forState:UIControlStateNormal];
    
    [self getNetData];
}


-(void)typesetButtons
{
    CGRect frame = CGRectMake(10, 10, 0, 0);
    
    
    for (int i=0;i<_dataArr.count;i++) {
        
        ShopCategoryData* sub = _dataArr[i];
        UIButton* bt = [self creatBtWithName:sub.categoryName];
        bt.tag = i;
        bt.selected = sub.select;
        if (bt.selected == NO) {
            bt.backgroundColor = [UIColor whiteColor];
        }
        else
        {
            bt.backgroundColor = DEFAULTNAVCOLOR;
        }
        
        if (bt.frame.size.width + frame.origin.x +10 >SCREENWIDTH)
        {
            frame.origin.y += bt.frame.size.height+10;
            frame.origin.x = 10;
        }
        frame.size.width = bt.frame.size.width;
        frame.size.height = bt.frame.size.height;
        bt.frame = frame;
        [_backView addSubview:bt];
        
        
        frame.origin.x += frame.size.width +10;
        
     }
}



-(UIButton*)creatBtWithName:(NSString*)name
{
    CGSize size = [name sizeWithAttributes:@{NSFontAttributeName:DEFAULTFONT(15)}];
    
    UIButton* bt = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [bt setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 25)];
    
    [bt setImageEdgeInsets:UIEdgeInsetsMake(0, size.width+10, 0, 0)];

    
    size.width += 33;
    size.height += 10;
    bt.layer.masksToBounds = YES;
    bt.layer.borderColor = DEFAULTNAVCOLOR.CGColor;
    bt.layer.borderWidth = 1;
    bt.layer.cornerRadius = 4;
    [bt setTitle:name forState:UIControlStateNormal];
    bt.titleLabel.font = DEFAULTFONT(15);
    
    [bt setTitleColor:FUNCTCOLOR(102, 102, 102) forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor whiteColor]  forState:UIControlStateSelected];
    bt.frame = CGRectMake(0, 0, size.width, size.height);
    [bt setImage:[UIImage imageNamed:@"addCategory_disSelect"] forState:UIControlStateNormal];
    [bt setImage:[UIImage imageNamed:@"addCategory_select"] forState:UIControlStateSelected];
    
    [bt addTarget:self action:@selector(selectCategory:) forControlEvents:UIControlEventTouchUpInside];
    
    return bt;
}

-(void)selectCategory:(UIButton*)bt
{
    bt.selected = !bt.selected;
    ShopCategoryData* cate = _dataArr[bt.tag];
    cate.select = bt.selected;
    if (bt.selected == YES) {
        bt.backgroundColor = DEFAULTNAVCOLOR;
    }
    else
    {
        bt.backgroundColor = [UIColor whiteColor];
    }
}




-(void)getNetData
{

}

-(void)receiveData:(NSArray*)arr
{
    _dataArr = arr;
    [self typesetButtons];
}







-(void)cancelAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveAction
{


}
@end
