//
//  ScaleRevolveAnimationTransition.m
//  MVVM
//
//  Created by Rockey on 16/1/4.
//  Copyright © 2016年 Rockey. All rights reserved.
//

#import "ScaleRevolveAnimationTransition.h"

@implementation ScaleRevolveAnimationTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *container = [transitionContext containerView];
    if (AnimationTypePresent == self.type) {
        
    } else if (AnimationTypeDismiss == self.type) {
    
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        UIView *snapFromView = [fromView snapshotViewAfterScreenUpdates:NO];
        [container addSubview:snapFromView];
        [container bringSubviewToFront:snapFromView];
        [fromView removeFromSuperview];
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [container insertSubview:toView belowSubview:snapFromView];
        
        [UIView animateWithDuration:0.5f animations:^{
            snapFromView.transform = CGAffineTransformScale(snapFromView.transform, 0.5, 0.5);
        } completion:^(BOOL finished) {

            CGRect snapFrame = snapFromView.frame;
            snapFromView.layer.anchorPoint = CGPointMake(0.0, 1.0f);
            snapFromView.frame = snapFrame;
            
            NSInteger number = 4;
            [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0 options:0 animations:^{
                [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:1.0/number animations:^{
                    snapFromView.transform = CGAffineTransformRotate(snapFromView.transform, M_PI_2);
                }];
                [UIView addKeyframeWithRelativeStartTime:1.0/number relativeDuration:1.0/number animations:^{
                    snapFromView.transform = CGAffineTransformRotate(snapFromView.transform, M_PI*0.7);
                    snapFromView.alpha = 3.0/number;
                }];
                [UIView addKeyframeWithRelativeStartTime:2.0/number relativeDuration:1.0/number animations:^{
                    snapFromView.transform = CGAffineTransformRotate(snapFromView.transform, -M_PI*0.4);
                    snapFromView.alpha = 2.0/number;
                }];
                CGPoint snapOrignal = snapFromView.frame.origin;
                snapOrignal = [snapFromView convertPoint:snapOrignal toView:container];
                [UIView addKeyframeWithRelativeStartTime:3.0/number relativeDuration:1.0/number animations:^{
                    snapFromView.transform = CGAffineTransformRotate(snapFromView.transform, M_PI*0.1);
                    snapFromView.transform = CGAffineTransformTranslate(snapFromView.transform, -snapOrignal.x, -snapOrignal.y);
                    snapFromView.alpha = 0.0f;
                }];
            } completion:^(BOOL finished) {
                [snapFromView removeFromSuperview];
                [transitionContext completeTransition:YES];
            }];
        }];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    return 2.0f;
}

@end
