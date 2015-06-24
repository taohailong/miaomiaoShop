//
//  THActivityVIew.m
//  xiuba
//
//  Created by 陶海龙 on 14-5-29.
//  Copyright (c) 2014年 hongnuo. All rights reserved.
//

#import "THActivityView.h"
#import "YFGIFImageView.h"
@implementation THActivityView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(id)initViewOnWindow
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activity.center = self.center;
    [self addSubview:activity];
    [activity startAnimating];
    return self;
}

-(void)loadViewAddOnWindow
{
    UIWindow* win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:self];
}

#pragma mark-------------------------


//-(void)activityRoseOnWindow
//{
//    UIWindow* win = [UIApplication sharedApplication].keyWindow;
//    [win addSubview:self];
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        [self removeFromSuperview];
//    });
//}

- (void)popOutsideWithDuration:(NSTimeInterval)duration
{
    UIWindow* win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(2.5, 2.5);
    __weak typeof(self) weakSelf = self;
	[UIView animateKeyframesWithDuration:duration delay:0 options:0 animations: ^{
	    [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 /4.0 animations: ^{
            typeof(self) strongSelf = weakSelf;
	        strongSelf.transform = CGAffineTransformMakeScale(0.0, 0.0);
		}];
	} completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    

}



-(id)initActivityView
{
    self = [self initLoadingWithStr:@"请稍后..."];
    return self;
}

-(id)initActivityViewWithSuperView:(UIView*)superView
{
//    self = [self initWithLoadGif];
    
    self = [self initLoadingWithStr:@"请稍后..."];
    
    self.center = superView.center;
    [superView addSubview:self];
    return self;

}


#pragma mark---------------fullLoadingView-----------------
-(id)initFullViewTransparentWithSuperView:(UIView *)superView
{
    self = [super init];
//    self.backgroundColor = [UIColor redColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:self];
    
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];

    return self;

}


//-(void)layoutSubviews
//{
//    self.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
//    [self.superview addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY  relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
//
//}
-(id)initLoadingWithStr:(NSString*)str
{
    self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activity.center = self.center;
        [self addSubview:activity];
        [activity startAnimating];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8;
        
        UILabel* titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 100, 20)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = str;
        [self addSubview:titleLabel];
    }
    return self;
}

-(id)initWithLoadGif
{
    self = [super initWithFrame:CGRectMake(0, 0, 190, 140)];
    
    if (self)
    {
        YFGIFImageView* imageV = [[YFGIFImageView alloc]initWithFrame:self.frame];
        imageV.gifPath = [[NSBundle mainBundle] pathForResource:@"LoadingGif" ofType:@"gif"];
        [imageV startGIF];
        [self addSubview:imageV];
    }
    return self;

}


-(id)initWithNetErrorWithSuperView:(UIView*)su
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [su addSubview:self];
    self.backgroundColor = [UIColor whiteColor];
    [su addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    [su addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
    
    
    
    UIImageView* imageV = [[UIImageView alloc]init];
    imageV.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:imageV];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageV attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:imageV attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:10]];
    
    imageV.image = [UIImage imageNamed:@"LoadingErr"];
//    imageV.backgroundColor = [UIColor redColor];
    
    UILabel* nameL = [[UILabel alloc]init];
    nameL.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:nameL];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:nameL attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:60]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:nameL attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-50]];
    nameL.text = @"没有网络...";
//    nameL.backgroundColor = [UIColor greenColor];
    nameL.textColor = DEFAULTNAVCOLOR;
    
    
    
    UIButton* bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.translatesAutoresizingMaskIntoConstraints = NO;
    bt.layer.borderWidth = 1.0;
    bt.layer.masksToBounds = YES;
    bt.layer.cornerRadius = 6;
    bt.layer.borderColor = DEFAULTNAVCOLOR.CGColor;
    [self addSubview:bt];
    [bt addTarget:self action:@selector(performReloadAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageV]-20-[bt]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(imageV,bt)]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[bt(150)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bt)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:bt attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [bt setTitleColor:DEFAULTNAVCOLOR forState:UIControlStateNormal];
    [bt setTitle:@"重新加载" forState:UIControlStateNormal];
    return self;
}

-(void)setErrorBk:(void(^)(void))completeBk
{
    _errorBk = completeBk;
}

-(void)performReloadAction
{
    [self removeFromSuperview];

    if (_errorBk) {
       _errorBk();
        _errorBk = nil;
    }
    
}



-(id)initWithFailView
{
    self = [super initWithFrame:CGRectMake(0, 0, 250, 60)];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 60)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"未能连接到服务器";
        [self addSubview:label];
        
    }
    return self;
}

-(void)show
{
    UIWindow* window =  [UIApplication sharedApplication].delegate.window;
    self.center = CGPointMake(window.center.x, window.center.y-20);
    [window addSubview:self];
    
    [UIView animateWithDuration:1.7 animations:^{
        self.alpha = 0.99;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        // [self release];
    }];
    
}

-(id)initWithString:(NSString*)str
{
    CGSize size = [str sizeWithFont:[UIFont boldSystemFontOfSize:17]];
    
    
    
    if(size.width>[UIScreen mainScreen].bounds.size.width)
    {
        size.width = [UIScreen mainScreen].bounds.size.width;
    }
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height+15)];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        
        UILabel* label = [[UILabel alloc]initWithFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.adjustsFontSizeToFitWidth = YES;
        label.text = str;
        [self addSubview:label];
        
    }
    return self;
    
}
-(void)dealloc
{

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
