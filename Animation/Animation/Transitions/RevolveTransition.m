//
//  RevolveTransition.m
//  MVVM
//
//  Created by Rockey on 15/12/25.
//  Copyright © 2015年 Rockey. All rights reserved.
//

#import "r"

@implementation RevolveAnimationTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    debugLog(@"animate transition");
    UIView *containerView = [transitionContext containerView];
    
    if (self.type == AnimationTypePresent) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:toView];
        
        CGRect toFrame = toView.frame;
        toView.layer.anchorPoint = CGPointZero;
        toView.frame = toFrame;
        toView.transform = CGAffineTransformRotate(toView.transform, M_PI_2);

        [UIView animateKeyframesWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            toView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } 
    else if (AnimationTypeDismiss == self.type) {
        
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [self setAnchorPoint:CGPointMake(1.0, 0.5) view:toView];
        [self setAnchorPoint:CGPointMake(0.0, 0.5) view:fromView];
        [containerView insertSubview:toView aboveSubview:fromView];
        containerView.backgroundColor = [UIColor whiteColor];
        
        CATransform3D t = CATransform3DMakeRotation(M_PI_2, 0.2, 1.0, 0);
        toView.layer.transform = t;
        
        toView.layer.zPosition = 1.0f;
        fromView.layer.zPosition = 2.0f;
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromView.layer.transform = t;
            toView.layer.transform = CATransform3DIdentity;
        } completion:^(BOOL finished) {
            toView.layer.zPosition = 0.0f;
            fromView.layer.zPosition = 0.0f;
            [fromView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {

    return 0.8f;
}

- (void)setAnchorPoint:(CGPoint)anchorPoint view:(UIView *)view {
//    CGRect oldFrame = view.frame;
//    view.layer.anchorPoint = anchorPoint;
//    view.frame = oldFrame;
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = oldOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

@end
