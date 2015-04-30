//
//  THActivityVIew.m
//  xiuba
//
//  Created by 陶海龙 on 14-5-29.
//  Copyright (c) 2014年 hongnuo. All rights reserved.
//

#import "THActivityView.h"

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

-(id)initWithRose
{

//    self = [super initWithFrame:[UIScreen mainScreen].bounds];
//    if (self)
//    {
//        NSArray* frameArr = @[@"{{20,47},{90,110}}",@"{{125,0},{90,110}}",@"{{230,52},{90,110}}",@"{{118,100},{90,110}}",@"{{15,155},{90,110}}",@"{{224,155},{90,110}}",@"{{115,205},{90,110}}",@"{{230,257},{90,110}}",@"{{15,257},{90,110}}",@"{{125,291},{90,110}}",@"{{224,349},{90,110}}",@"{{77,361},{90,110}}"];
//        
//        for (NSString* frameStr in frameArr)
//        {
//            UIImageView* subImage = [[UIImageView alloc]initWithFrame:CGRectFromString(frameStr)];
//            subImage.image = [UIImage imageNamed:@"living_roseOnwindow.png"];
//            [self addSubview:subImage];
//        }
//        
//    }
    self=[super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        UIImageView *roseImageView=[[UIImageView alloc]init];
        roseImageView.image=[UIImage imageNamed:@"living_roseOnwindow.png"];
        roseImageView.bounds=CGRectMake(self.center.x, self.center.y, 90, 112);
        roseImageView.center=CGPointMake(self.center.x, self.center.y);
        [self addSubview:roseImageView];
    }

    return self;

}

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
    self = [self initLoadingWithStr:@"请稍后..."];
    
    self.center = superView.center;
    [superView addSubview:self];
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
//    self = [super init];
    
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
    UIWindow* window =  [UIApplication sharedApplication].keyWindow;
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
