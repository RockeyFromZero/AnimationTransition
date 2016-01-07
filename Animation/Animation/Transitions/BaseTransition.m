//
//  BaseAnimationTransition.m
//  MVVM
//
//  Created by Rockey on 15/12/25.
//  Copyright © 2015年 Rockey. All rights reserved.
//

#import "BaseAnimationTransition.h"

@interface BaseAnimationTransition ()

@end

@implementation BaseAnimationTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext { }

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.2f;
}

- (void)animationEnded:(BOOL)transitionCompleted { }

@end
