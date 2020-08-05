//
//  UIViewController+TopViewController.m
//  WProjectForNative
//
//  Created by James on 16/9/9.
//  Copyright © 2016年 James. All rights reserved.
//

#import "UIViewController+TopViewController.h"

@implementation UIViewController (TopViewController)

+ (UIViewController*)topViewController {

    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if ([window isKindOfClass:[UIWindow class]] &&
            ([window.rootViewController isKindOfClass:NSClassFromString(@"ViewController")] ||
             [window.rootViewController isKindOfClass:NSClassFromString(@"WCustomNavigationController")])) {
                return [self topViewControllerWithRootViewController:window.rootViewController];
            }
    }
    return nil;
}
+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
@end
