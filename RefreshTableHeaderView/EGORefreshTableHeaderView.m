//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"


#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f
//#define PUSHLENTH -75.0

@interface EGORefreshTableHeaderView (Private)
- (void)setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView
//@synthesize scrollEdge;
//@synthesize delegate=_delegate;

-(void)setScrollEdge:(UIEdgeInsets)scrollEdge
{
    _scrollEdge = scrollEdge;
//    OFFY = OFFY+scrollEdge.top;
//    PUSHLENTH = PUSHLENTH-scrollEdge.top;
}

-(UIEdgeInsets)scrollEdge
{
    return _scrollEdge;
}

-(void)setRefreshStyle:(RefreshStyle)style
{
    switch (style) {
        case RefreshInset64:
            OFFY = 64.0;
            PUSHLENTH =-139.0;
            break;
        case RefreshInsetNormal:
            OFFY = 0;
            PUSHLENTH =-65.0;
            break;
        default:
            break;
    }
}

-(void)setDelegate:(id<EGORefreshTableHeaderDelegate>)delegate
{
    
    _delegate = delegate;
}

-(id<EGORefreshTableHeaderDelegate>)delegate
{
    return _delegate;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
		
        OFFY = 0.0;
        PUSHLENTH =-65.0;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont systemFontOfSize:12.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_lastUpdatedLabel=label;
		
		
		label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.font = [UIFont boldSystemFontOfSize:13.0f];
		label.textColor = TEXT_COLOR;
		label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		label.shadowOffset = CGSizeMake(0.0f, 1.0f);
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentCenter;
		[self addSubview:label];
		_statusLabel=label;
		
		
		CALayer *layer = [CALayer layer];
		layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
		layer.contentsGravity = kCAGravityResizeAspect;
		layer.contents = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			layer.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:layer];
		_arrowImage=layer;
		
		UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
		[self addSubview:view];
		_activityView = view;
		
		[self setState:EGOOPullRefreshNormal];
		
    }
	
    return self;
	
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate
{
	
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {
		
		NSDate *date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"AM"];
		[formatter setPMSymbol:@"PM"];
		[formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
//		_lastUpdatedLabel.text = [NSString stringWithFormat:@"%@:%@", NSLocalizedString(@"Last Updated", nil),[formatter stringFromDate:date]];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间:%@",[formatter stringFromDate:date]];
        
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		
	} else {
		
		NSDate *date = [NSDate date];
		
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setAMSymbol:@"AM"];
		[formatter setPMSymbol:@"PM"];
		[formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
		_lastUpdatedLabel.text = [NSString stringWithFormat:@"上次更新时间:%@",[formatter stringFromDate:date]];
		[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
	}

}

- (void)setState:(EGOPullRefreshState)aState{
	
	switch (aState) {
		case EGOOPullRefreshPulling:
			
//			_statusLabel.text = NSLocalizedString(@"Release to refresh...",nil);
            _statusLabel.text = @"释放加载...";
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
			
			if (_state == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			
//			_statusLabel.text = NSLocalizedString(@"Pull down to refresh...", nil);
            _statusLabel.text = @"下拉刷新...";
			[_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			
			[self refreshLastUpdatedDate];
			
			break;
		case EGOOPullRefreshLoading:
			
            
//			_statusLabel.text = NSLocalizedString(@"Loading...", @"加载...");
            _statusLabel.text = @"加载...";
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
			_arrowImage.hidden = YES;
			[CATransaction commit];
			
			break;
		default:
			break;
	}
	
	_state = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {	
	
	if (_state == EGOOPullRefreshLoading) {
		
		CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
		offset = MIN(offset, 60);
//		scrollView.contentInset = UIEdgeInsetsMake(offset+OFFY, 0.0f, 48.0f, 0.0f);
        scrollView.contentInset = UIEdgeInsetsMake(self.scrollEdge.top+offset, scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
		
	} else if (scrollView.isDragging)
    {
		
		BOOL _loading = NO;
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
			_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
		}
		
		if (_state == EGOOPullRefreshPulling && scrollView.contentOffset.y > PUSHLENTH && scrollView.contentOffset.y < 0.0f && !_loading) {
			[self setState:EGOOPullRefreshNormal];
		} else if (_state == EGOOPullRefreshNormal && scrollView.contentOffset.y < PUSHLENTH && !_loading) {
			[self setState:EGOOPullRefreshPulling];
		}
		
//		if (scrollView.contentInset.top != 0) {
//            scrollView.contentInset = UIEdgeInsetsMake(self.scrollEdge.top, scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
//
//		}
		
	}
	
}

- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL _loading = NO;
	if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
		_loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
	}
    NSLog(@"y %f %f",scrollView.contentOffset.y,PUSHLENTH);
	if (scrollView.contentOffset.y <= PUSHLENTH && !_loading)
    {
		
		if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)])
        {
			[_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
		}
		
		
		[UIView beginAnimations:nil context:NULL];
        [self setState:EGOOPullRefreshLoading];
		[UIView setAnimationDuration:.2];

        
        scrollView.contentInset = UIEdgeInsetsMake(self.scrollEdge.top+60, scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
		[UIView commitAnimations];
		
	}
	
}


-(void)egoRefreshScrollViewDataSourceDidBeginLoading:(UIScrollView *)scrollView
{
    [self setState:EGOOPullRefreshLoading];//放在动画前面
    [UIView animateWithDuration:.2 animations:^{
        scrollView.contentInset = UIEdgeInsetsMake(-PUSHLENTH, 0, 0, 0);
        [scrollView setContentOffset:CGPointMake(-0.0f, PUSHLENTH)];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {	
//	NSLog(@"content is %@",NSStringFromUIEdgeInsets(scrollView.contentInset));
    [self setState:EGOOPullRefreshNormal];//放在动画前面
    [UIView animateWithDuration:.3 animations:^{
         scrollView.contentInset = self.scrollEdge;
    } completion:^(BOOL finished) {
//       NSLog(@"content is %@ original %@",NSStringFromUIEdgeInsets(scrollView.contentInset),NSStringFromUIEdgeInsets(self.scrollEdge));
    }];
//	[UIView beginAnimations:nil context:NULL];
//	[UIView setAnimationDuration:.3];
//    scrollView.contentInset = self.scrollEdge;
//	[UIView commitAnimations];
   
	

}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
}


@end
