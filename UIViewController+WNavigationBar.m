//
//  UIViewController+WNavigationBar.m
//  WProjectForNative
//
//  Created by James on 16/9/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import "UIViewController+WNavigationBar.h"
#import <objc/runtime.h>
#import "NSObject+Swizzling.h"
#import "UIViewController+TopViewController.h"
#import "WCustomNavigationController.h"
#import <ReactiveCocoa.h>
#import "UIView+Layout.h"
@interface UIViewController()
@property (nonatomic, strong, readwrite) WNavigationBar *navigationBar;
@property (nonatomic, assign) BOOL hiddenBar;
@end

@implementation UIViewController (WNavigationBar)

+ (void)load {
    if (![[self class]isSubclassOfClass:[UINavigationController class]]) {
        [self swizzlingWithOriginalSEL:@selector(viewWillAppear:)
                                newSEL:@selector(afterViewWillAppear:)];
        //        [self swizzlingWithOriginalSEL:@selector(setTitle:)
        //                                newSEL:@selector(setNewTitle:)];
    }
}

//- (void)setNewTitle:(NSString *)title {
//    [self setNewTitle:title];
//    if (title.length > 0 && self.navigationController && !self.hiddenBar) {
//        self.navigationBar.title = title?:@"";
//    }
//}

- (void)afterViewWillAppear:(BOOL)a {
    [self afterViewWillAppear:a];
    if (self.title.length > 0 && self.navigationController && !self.hiddenBar) {
        self.navigationBar.title = self.title;
        if ([self.navigationController isKindOfClass:[WCustomNavigationController class]] &&
            self.navigationController.viewControllers.count==1) {
            self.navigationBar.backButton.hidden = YES;
        }else {
            self.navigationBar.backButton.hidden = NO;
        }
    }
}

- (void)hidesNavigationBar:(BOOL)hidden {
    self.hiddenBar = hidden;
    self.navigationBar.hidden = hidden;
}

- (WNavigationBar *)navigationBar {
    WNavigationBar *bar = objc_getAssociatedObject(self, @selector(navigationBar));
    if (!bar) {
        bar = [[WNavigationBar alloc]init];
        [[UIApplication sharedApplication].windows enumerateObjectsUsingBlock:^(__kindof UIWindow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIWindow class]] &&
                [obj.rootViewController isKindOfClass:[UINavigationController class]] &&
                [((UINavigationController *)obj.rootViewController).viewControllers firstObject] == self) {
                bar.backButton.hidden = YES;
                *stop = YES;
            }
        }];
        if (self.navigationController.navigationBar.hidden) {
            [self.view addSubview:bar];
        }
        @weakify(self);
        [[bar.backButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
            @strongify(self);
            if ([(id<MNavigationBarBackProtocol>)self respondsToSelector:@selector(backButtonEventTouchUpIndside)]) {
                [(id<MNavigationBarBackProtocol>)self backButtonEventTouchUpIndside];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        objc_setAssociatedObject(self, @selector(navigationBar), bar, OBJC_ASSOCIATION_RETAIN);
        
    }
    return bar;
}

- (void)setHiddenBar:(BOOL)hiddenBar {
    objc_setAssociatedObject(self, @selector(hiddenBar), @(hiddenBar), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)hiddenBar {
    return objc_getAssociatedObject(self, @selector(hiddenBar));
}
@end
