//
//  ViewFresher.m
//  TableRefresher
//
//  Created by Fenix on 16/6/20.
//  Copyright © 2016年 Fenix. All rights reserved.
//

#import "ViewFresher.h"
#import <objc/runtime.h>
@interface ViewFresher()
{
    IMP _topIMP;
    IMP _bottomIMP;
}
@end
@implementation ViewFresher

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)initTopView:(UIView *)view onScrollView:(UIScrollView*)scrollVW usingRefreshBlock:(refreshBlock)blk
{
//    下拉时顶部视图
    _scrlVW = scrollVW;
    _TopView = view;
        scrollVW.delegate = self;
//    _topIMP = imp_implementationWithBlock(blk);
    _topBlk = blk;
}

-(void)initBottomViewWith:(UIView *)view onScrollView:(UIScrollView*)scrollVW usingRefreshBlock:(refreshBlock)blk
{
//    _bottomIMP = imp_implementationWithBlock(blk);
    _scrlVW = scrollVW;
    _BottomView = view;
    _bottomBlk = blk;
}
-(void)addTopView
{
    if (_TopView == nil) {
        UILabel *topLab = [[UILabel alloc] initWithFrame:CGRectMake(0, -44, _scrlVW.bounds.size.width, 44)];
        topLab.text = @"释放开始刷新......";
        topLab.textAlignment = NSTextAlignmentCenter;
        [_scrlVW addSubview:topLab];
    } else {
        CGFloat viewHeight = _TopView.bounds.size.height;
        _TopView.frame = CGRectMake(0, -viewHeight, _scrlVW.bounds.size.width, viewHeight);
        [_scrlVW addSubview:_TopView];
    }
}

-(void)addBottomView
{
    if (!_BottomView) {
        UILabel *bottomLab = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrlVW.contentSize.height, _scrlVW.bounds.size.width, 44)];
        bottomLab.text = @"释放开始刷新......";
        bottomLab.textAlignment = NSTextAlignmentCenter;
        [_scrlVW addSubview:bottomLab];
    } else {
        CGFloat viewHeight = _BottomView.bounds.size.height;
        _BottomView.frame = CGRectMake(0, _scrlVW.contentSize.height, _scrlVW.bounds.size.width, viewHeight);
        [_scrlVW addSubview:_BottomView];
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    }
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat topViewHeight = _TopView ? _TopView.bounds.size.height  : 44 ;
    if (scrollView.contentOffset.y < -0.2*topViewHeight){
        _topBlk(scrollView);
    }
    if (scrollView.contentOffset.y > scrollView.contentSize.height + 0.1*topViewHeight - scrollView.bounds.size.height) {
        _bottomBlk(scrollView);
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"contentOffset.y = %f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 20) {
        static dispatch_once_t onceToken1;
        dispatch_once(&onceToken1, ^{
            [self addTopView];
        });
    }
    if (scrollView.contentOffset.y + 20 >scrollView.contentSize.height - scrollView.bounds.size.height ) {
        static dispatch_once_t onceToken2;
        dispatch_once(&onceToken2, ^{
            [self addBottomView];
        });
    }
}


@end
