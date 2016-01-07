//
//  RevolveDoorAnimation.m
//  MVVM
//
//  Created by Rockey on 16/1/6.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "RevolveDoorAnimation.h"

@implementation RevolveDoorAnimation

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *container = [transitionContext containerView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [container addSubview:toView];
    
    UIView *snapFromView = [fromView snapshotViewAfterScreenUpdates:NO];
    [container addSubview:snapFromView];
    [fromView removeFromSuperview];
    
    CATransform3D toViewTransform = toView.layer.transform;
    toViewTransform = CATransform3DRotate(toViewTransform, M_PI_2, 0, 1, 0);
    toViewTransform = CATransform3DScale(toViewTransform, 0.8, 0.8, 0.8);
    toView.layer.transform = toViewTransform;
    
    [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5f animations:^{
            CATransform3D snapTransform = snapFromView.layer.transform;
            snapTransform = CATransform3DMakeScale(0.8, 0.8, 0.8);
            snapTransform = CATransform3DRotate(snapTransform, M_PI_2, 0, -1.0, 0);
            snapFromView.layer.transform = snapTransform;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5f animations:^{
            toView.layer.transform = CATransform3DIdentity;
        }];
    } completion:^(BOOL finished) {
        [snapFromView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.6f;
}

@end
