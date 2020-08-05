//
//  WNavigationBar.m
//  WProjectForNative
//
//  Created by HuangZhen on 16/9/11.
//  Copyright © 2016年 HuangZhen. All rights reserved.
//

#import "WNavigationBar.h"
#import "UIImage+Color.h"
#import "UIViewController+TopViewController.h"
#import "UtilsMacro.h"
#import <ReactiveCocoa.h>
#import "UIView+Layout.h"
@interface WNavigationBar()
@property (nonatomic, strong) UILabel *titleLable;
@end
@implementation WNavigationBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, NavBarHeight)];
    if (self) {
        self.translucent = NO;
        self.tintColor = [UIColor whiteColor];
        self.shadowImage = [[UIImage alloc] init];
        self.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                     NSFontAttributeName:[UIFont fontWithName:PingFangSCRegular size:kRealValue(18)]};
        //设置导航栏背景色
        [self setBackgroundImage:[UIImage imageWithSolidColor:kNavWhiteColor size:CGSizeMake(1, 1)]
                   forBarMetrics:UIBarMetricsDefault];
        //        [self setBackgroundImage:[UIImage imageNamed:@"TopNav@3x"] forBarMetrics:UIBarMetricsDefault];
        [self addSubview:self.backButton];
    }
    return self;
}
#if __IPHONE_11_0
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subview in self.subviews) {
        if ([NSStringFromClass([subview class]) containsString:@"_UIBarBackground"]) {
            CGRect subViewFrame = subview.frame;
            subViewFrame.size.height = NavBarHeight;
            [subview setFrame: subViewFrame];
        }
        if ([NSStringFromClass([subview class]) containsString:@"_UINavigationBarContentView"]) {
            CGRect subViewFrame = subview.frame;
            CGFloat originY = iPhoneXDevice?44:20;
            subViewFrame.origin.y = originY;
            [subview setFrame: subViewFrame];
        }
    }
}
#endif
- (void)setTitle:(NSString *)title {
    _title = title;
    UINavigationItem * titleItem = [[UINavigationItem alloc]initWithTitle:title];
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    lv.hidden = YES;
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:lv];
    UIView *rv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    rv.hidden = YES;
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rv];
    titleItem.leftBarButtonItems = @[left];
    titleItem.rightBarButtonItems = @[right];
    self.items = @[titleItem];
}
- (void)setCenterCustomView:(UIView *)customView {
    _centerCustomView = customView;
    [self addSubview:customView];
    customView.centerX = ScreenWidth/2;
    CGFloat centerY = iPhoneXDevice?NavBarHeight/2 + kRealValue(10)+ kRealValue(12):NavBarHeight/2 + kRealValue(10);
    customView.centerY = centerY;
}
- (void)setRightCustomView:(UIView *)rightCustomView {
    _rightCustomView = rightCustomView;
    [self addSubview:rightCustomView];
    CGFloat centerY = iPhoneXDevice?NavBarHeight/2+10+12:NavBarHeight/2+10;
    rightCustomView.centerY = centerY;
    rightCustomView.left = ScreenWidth - rightCustomView.width;
}
-(void)setLeftCustomView:(UIView *)leftCustomView {
    _leftCustomView = leftCustomView;
    if (leftCustomView) {
        self.backButton.hidden = YES;
    }else {
        self.backButton.hidden = NO;
    }
    
    [self addSubview:leftCustomView];
    CGFloat centerY = iPhoneXDevice?NavBarHeight/2+10+12:NavBarHeight/2+10;
    leftCustomView.centerY = centerY;
    leftCustomView.left = 0;
}
- (UIButton *)backButton {
    if (!_backButton) {
        CGFloat top = iPhoneXDevice?44:20;
        _backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, top, kRealValue(44), kRealValue(44))];
        [_backButton setImage:[UIImage imageNamed:@"top_icon_return01"] forState:UIControlStateNormal];
    }
    return _backButton;
}

@end
