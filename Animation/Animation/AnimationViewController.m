//
//  AnimationViewController.m
//  MVVM
//
//  Created by Rockey on 15/12/24.
//  Copyright © 2015年 Rockey. All rights reserved.
//

#import "AnimationViewController.h"
#import "RevolveAnimationTransition.h"
#import "ScaleRevolveAnimationTransition.h"

@interface AnimationViewController ()<UIViewControllerTransitioningDelegate, UINavigationControllerDelegate>

@end

@implementation AnimationViewController

- (void)leftBarItem {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"animation";
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(leftBarItem)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.delegate = self;
    
    UIButton *style = [[UIButton alloc] init];
    [self setviewStyle:style];
    [style setTitle:@"style" forState:UIControlStateNormal];
    [style setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [style addTarget:self action:@selector(style) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:style];
    [style makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.height.equalTo(@40);
        make.left.equalTo(self.view).offset(-20);
        make.right.equalTo(self.view).offset(20);
    }];
}

- (void)style {
    NSLog(@"stype\n");
}

- (void)setviewStyle:(UIView *)view {

    view.layer.cornerRadius = 3.0f;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = .5f;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {

    self.navigationController.delegate = nil;
    ScaleRevolveAnimationTransition *scaleRevolve = [[ScaleRevolveAnimationTransition alloc] init];
    if ([toVC isKindOfClass:NSClassFromString(@"ViewController")]) {
        scaleRevolve.type = (UINavigationControllerOperationPush==operation)?AnimationTypePresent:AnimationTypeDismiss;
        return scaleRevolve;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
