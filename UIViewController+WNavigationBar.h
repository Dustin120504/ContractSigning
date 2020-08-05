//
//  UIViewController+WNavigationBar.h
//  WProjectForNative
//
//  Created by James on 16/9/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNavigationBar.h"
@protocol MNavigationBarBackProtocol <NSObject>
@optional
- (void)backButtonEventTouchUpIndside;
@end
@interface UIViewController (WNavigationBar)
@property(nonatomic, strong, readonly)WNavigationBar *navigationBar;
- (void)hidesNavigationBar:(BOOL)hidden;


@end
