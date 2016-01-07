//
//  ShuttleAnimation.m
//  MVVM
//
//  Created by Rockey on 16/1/6.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ShuttleAnimation.h"

@implementation ShuttleAnimation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [container addSubview:toView];
    
    UIView *snapFrom = [fromView snapshotViewAfterScreenUpdates:NO];
    [container addSubview:snapFrom];
    [fromView removeFromSuperview];
    
    CATransform3D endTransform = CATransform3DIdentity;
    endTransform.m34 = -1.0/500;
    endTransform = CATransform3DTranslate(endTransform, 0, 0, -250);
    endTransform = CATransform3DRotate(endTransform, M_PI_4, 0, 1, 0);
    
    CATransform3D toOrignalTransform = endTransform;
    toOrignalTransform = CATransform3DTranslate(toOrignalTransform, 0, 0, -250);
    toOrignalTransform = CATransform3DRotate(toOrignalTransform, M_PI*0.31, 0, 1, 0);
    toView.layer.transform = toOrignalTransform;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.1 animations:^{
            snapFrom.layer.transform = endTransform;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.4 animations:^{
            snapFrom.layer.transform = CATransform3DTranslate(snapFrom.layer.transform, 0, 0, -250);
            snapFrom.layer.transform = CATransform3DRotate(snapFrom.layer.transform, M_PI*0.31, 0, 1, 0);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
            toView.layer.transform = endTransform;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            toView.layer.transform = CATransform3DIdentity;
        }];
        
    } completion:^(BOOL finished) {
        [snapFrom removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.2f;
}

@end
