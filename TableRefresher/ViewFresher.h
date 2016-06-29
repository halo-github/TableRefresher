//
//  ViewFresher.h
//  TableRefresher
//
//  Created by Fenix on 16/6/20.
//  Copyright © 2016年 Fenix. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^refreshBlock)(UIScrollView *scrl);
@interface ViewFresher : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrlVW;
@property (nonatomic, strong) UIView *TopView;
@property (nonatomic, strong) UIView *BottomView;
@property (nonatomic, copy) refreshBlock topBlk;
@property (nonatomic, copy) refreshBlock bottomBlk;

-(void)initTopView:(UIView *)view onScrollView:(UIScrollView*)scrollVW usingRefreshBlock:(refreshBlock)blk;

-(void)initBottomViewWith:(UIView *)view onScrollView:(UIScrollView*)scrollVW usingRefreshBlock:(refreshBlock)blk;
@end
