//
//  FloatView.m
//  miaomiaoShop
//
//  Created by 陶海龙 on 15/7/15.
//  Copyright (c) 2015年 miaomiao. All rights reserved.
//

#import "FloatView.h"
@interface FloatView()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    UITableView* _table;
    UIView* _backView;
    CGPoint _startPanPoint;
    CGPoint _lastPanPoint;
    float _backViewWidth;
}
@end
@implementation FloatView
@synthesize delegate;


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    
    [self creatBackView];
    return self;
}

//-(UIView*)creatTabelHeadView
//{
//    UIView* head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_table.frame), 55)];
//    
//    
//    
//    return  head;
//}

-(void)creatBackView
{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(-255, 0, 255, CGRectGetHeight(self.frame))];
    _backViewWidth = 255;
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    
    UIPanGestureRecognizer* pin = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pin.delegate = self;
    [_backView addGestureRecognizer:pin];
    
    
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 255, CGRectGetHeight(_backView.frame)-50)];
    [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _table.dataSource = self;
    _table.delegate = self;
    [_backView addSubview:_table];
    
    
    
    UIButton* logOutBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [logOutBt setTitle:@"退出登录" forState:UIControlStateNormal];
    logOutBt.translatesAutoresizingMaskIntoConstraints = NO;
    [_backView addSubview:logOutBt];
    [logOutBt addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[logOutBt]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logOutBt)]];
    [_backView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[logOutBt]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(logOutBt)]];
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 ) {
        return 55;
    }
    return 45;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell= [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    UIImage* cellImage = nil;
    if (indexPath.row == 0) {
        
        cell.textLabel.text = @"888";
        cellImage = [UIImage imageNamed:@""];
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"意见反馈";
        cellImage = [UIImage imageNamed:@""];
    }
    else if (indexPath.row==2)
    {
        cell.textLabel.text = @"联系喵喵";
        cellImage = [UIImage imageNamed:@""];
    }
    else
    {
        cell.textLabel.text = @"关于喵喵";
        cellImage = [UIImage imageNamed:@""];
    }

    cell.imageView.image = cellImage;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(floatViewSelectStyle:)]) {
        
        int  action =0;
        
        switch (indexPath.row) {
            case 1:
                action = FloatActionSuggestion;
                break;
            case 2:
                action = FloatActionAbout;
                break;
            default:
                break;
        }
        
        [self.delegate floatViewSelectStyle:action];
    }
}

-(void)logOutAction:(UIButton*)bt
{
    if ([self.delegate respondsToSelector:@selector(floatViewSelectStyle:)]) {
        [self.delegate floatViewSelectStyle:FloatActionLogOut];
    }
}


#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer.view == self) {
        return YES;
    }
// Check for horizontal pan gesture
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:_backView];
    
        if ([panGesture velocityInView:_backView].x < 600 && ABS(translation.x)/ABS(translation.y)>1) {
            return YES;
        }
        return NO;
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    [self hidFloatView];
}

- (void)pan:(UIPanGestureRecognizer*)pan
{
    if (pan.state==UIGestureRecognizerStateBegan)
    {
        _startPanPoint=_backView.frame.origin;
        if (_backView.frame.origin.x==0)
        {
            //            [self showShadow:_showBoundsShadow];
        }
        CGPoint velocity=[pan velocityInView:_backView];
        if(velocity.x>0)
        {
            if (_backView.frame.origin.x>=0)
            {
//                [self willShowLeftViewController];
            }
        }else if (velocity.x<0)
        {
//            [self willShowRightViewController];
        }
        return;
    }
    
    
    BOOL left_direction = YES;
    CGPoint currentPostion = [pan translationInView:_backView];
    CGFloat xoffset = _startPanPoint.x + currentPostion.x;
    if (xoffset>0)
    {//向右滑
        NSLog(@"right %@",NSStringFromCGPoint(currentPostion));
//        xoffset = xoffset>_backViewWidth?_backViewWidth:xoffset;;
        xoffset = 0;
        left_direction = NO;
    }
    else if(xoffset<0)
    {//向左滑
        NSLog(@"left %@",NSStringFromCGPoint(currentPostion));

        xoffset = xoffset<-_backViewWidth?-_backViewWidth:xoffset;
    }
//    NSLog(@"xoffset %f",xoffset);
    if (xoffset!=_backView.frame.origin.x)
    {
        [self layoutCurrentViewWithOffset:xoffset];
    }
    
    if (pan.state==UIGestureRecognizerStateEnded)
    {
        _lastPanPoint = CGPointZero;
        if (left_direction) {
            [self hidFloatView];
        }
        else
        {
            [self showFloatView];
        }
    }
    else
    {
        CGPoint velocity = [pan velocityInView:_backView];
        NSLog(@"velocity is %f",velocity);
        if (velocity.x>0) {
//            _panMovingRightOrLeft = true;
        }else if(velocity.x<0){
//            _panMovingRightOrLeft = false;
        }
    }
}

-(void)showFloatView
{
    [UIView animateWithDuration:0.2 animations:^{
       [self layoutCurrentViewWithOffset:0];
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)hidFloatView
{
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutCurrentViewWithOffset:-255];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

    
}




- (void)layoutCurrentViewWithOffset:(CGFloat)xoffset{
   
//    if (self.rootViewMoveBlock) {//如果有自定义动画，使用自定义的效果
//        self.rootViewMoveBlock(_currentView,_baseView.bounds,xoffset);
//        return;
//    }
    /*平移的动画*/
     [_backView setFrame:CGRectMake(xoffset, _backView.bounds.origin.y, _backView.frame.size.width, _backView.frame.size.height)];
     return;
    
    //    /*平移带缩放效果的动画
//    static CGFloat h2w = 0;
//    if (h2w==0) {
//        h2w = _baseView.frame.size.height/_baseView.frame.size.width;
//    }
//    CGFloat scale = ABS(1400 - ABS(xoffset)) / 1400;
//    //    scale = MAX(0.75, scale);
//    
//    _currentView.transform = CGAffineTransformMakeScale(scale, scale);
//    
//    CGFloat totalWidth=_baseView.frame.size.width;
//    CGFloat totalHeight=_baseView.frame.size.height;
//    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
//        totalHeight=_baseView.frame.size.width;
//        totalWidth=_baseView.frame.size.height;
//    }
//    
//    if (xoffset>0) {//向右滑的
//        [_currentView setFrame:CGRectMake(xoffset, _baseView.bounds.origin.y + (totalHeight * (1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
//    }else{//向左滑的
//        [_currentView setFrame:CGRectMake(_baseView.frame.size.width * (1 - scale) + xoffset, _baseView.bounds.origin.y + (totalHeight*(1 - scale) / 2), totalWidth * scale, totalHeight * scale)];
//    }
    //*/
}



@end
