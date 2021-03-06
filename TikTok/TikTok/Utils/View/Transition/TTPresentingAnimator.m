//
//  TTPresentingAnimator.m
//  TikTok
//
//  Created by FaceBook on 2019/1/24.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "TTPresentingAnimator.h"
#import "TTMineViewController.h"
#import "TTHomeViewController.h"
#import "TTProfileCollectionViewCell.h"
#import "TTRootViewController.h"
#import "TTBaseNavigationViewController.h"
@implementation TTPresentingAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    
    }
    return self;
}

//MARK: 动画时长
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

///MARK: 切换的上下文信息
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    ///:获取跳转VC
    TTHomeViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    ///MARK:当前RootVC
    TTBaseNavigationViewController *rootVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ///MARK:获取当前VC
    TTMineViewController *fromVC = rootVC.viewControllers.firstObject;
    
    ///MARK: 获取当前选中的Cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:fromVC.selectIndex inSection:0];
    TTProfileCollectionViewCell *selectCell = (TTProfileCollectionViewCell *)[fromVC.listCollectionView cellForItemAtIndexPath:indexPath];

    ///MARK:添加跳转VC到transitionContext
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];

    ///MARK:获取当前CollectionView的Cell的 Frame
    CGRect initialFrame = [fromVC.listCollectionView convertRect:selectCell.frame toView:[fromVC.listCollectionView superview]];

    ///MARK:跳转VC 的frame
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    
    ///MARK:获取z跳转视图中心
    toVC.view.center = CGPointMake(initialFrame.origin.x + initialFrame.size.width/2, initialFrame.origin.y + initialFrame.size.height/2);

    ///MARK:添加转场动画
    toVC.view.transform = CGAffineTransformMakeScale(initialFrame.size.width/finalFrame.size.width, initialFrame.size.height/finalFrame.size.height);

    [UIView animateWithDuration:duration
                          delay:0
         usingSpringWithDamping:0.7 /// 弹簧效果
          initialSpringVelocity:1.0 ///数值越大，开始的越快
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{
                         toVC.view.center = CGPointMake(finalFrame.origin.x + finalFrame.size.width/2, finalFrame.origin.y + finalFrame.size.height/2);
                         toVC.view.transform = CGAffineTransformMakeScale(1, 1);
                     } completion:^(BOOL finished) {
                         ///MARK: 切换过程的信息都在transitionContext中，并且记得在切换完成后调用
                         [transitionContext completeTransition:YES];
                     }];
    
}

@end
