//
//  BaseAnimationTransition.h
//  MVVM
//
//  Created by Rockey on 15/12/25.
//  Copyright © 2015年 Rockey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AnimationType) {

    AnimationTypePresent,
    AnimationTypeDismiss
};

@interface BaseAnimationTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimationType type;

@end
