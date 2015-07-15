//
//  PosterScorllView.m
//  yiwugou
//
//  Created by yiwugou on 13-8-13.
//  Copyright (c) 2013年 yiwugou. All rights reserved.
//

#import "PosterScorllView.h"
#import "UIImageView+WebCache.h"

@interface PosterScorllView()
{
    NSTimer* _timer;
}
@end
@implementation PosterScorllView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        imageArr = [[NSMutableArray alloc]initWithCapacity:0];
        
        scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        scroll.delegate = self;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        _timer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(changeSrcollView) userInfo:nil repeats:YES];
        
        page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 15*dataArr.count, 20)];
        page.pageIndicatorTintColor = [UIColor whiteColor] ;
//        page.currentPageIndicatorTintColor = NAVAGATIONCOLOR ;

        [self addSubview:scroll];
        [self addSubview:page];

    }
    return self;
}


-(void)creatSubView
{
  

}

-(void)loadImageViewsWithData:(NSArray*)arr
{
    if (dataArr) {
        return;
    }
    dataArr = arr;
    scroll.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*dataArr.count,CGRectGetHeight(scroll.frame));
    
    int tag = 0;
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(scroll.frame), CGRectGetHeight(self.frame));
   
    for (int i =0 ;i<dataArr.count;i++)
    {
        UIImageView* imageView = [[UIImageView alloc]initWithFrame:frame];
//        imageView.backgroundColor = [UIColor redColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImageWithURL:[NSURL URLWithString:dataArr[i]] placeholderImage:[UIImage imageNamed:@"Default_Image"]];
        imageView.userInteractionEnabled = YES;
        [scroll addSubview:imageView];
        [imageArr addObject:imageView];
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [imageView addGestureRecognizer:tap];
       
        imageView.tag = tag;
        tag++;
        frame.origin.x = frame.origin.x + frame.size.width;
    }
    
    page.frame = CGRectMake((CGRectGetWidth(self.frame)-15*dataArr.count)/2, CGRectGetHeight(self.frame)-20, 15*dataArr.count, 20);
   
    page.numberOfPages = dataArr.count;

}


-(void)tapView:(UITapGestureRecognizer*)tapGes
{
    if (!dataArr) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(posterViewDidSelectAtIndex:WithData:)]) {
        
        id dic = dataArr[tapGes.view.tag];
        [self.delegate posterViewDidSelectAtIndex:tapGes.view.tag WithData:dic];
    }
    
}

-(void)changeSrcollView
{
    int nu = scroll.contentOffset.x/scroll.bounds.size.width;
    
    nu++;
    CGPoint setPoint = scroll.contentOffset;
    if (nu<dataArr.count)
    {
         page.currentPage = nu;
        setPoint.x =  scroll.bounds.size.width*nu;
    }
    else
    {
        page.currentPage = 0;
        setPoint.x = 0;
    }
    [scroll setContentOffset:setPoint animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int nu = scrollView.contentOffset.x/scrollView.frame.size.width;
    page.currentPage = nu;
}


-(void)invalidTimer
{
    [_timer invalidate];
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
