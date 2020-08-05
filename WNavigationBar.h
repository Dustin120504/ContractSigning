//
//  WNavigationBar.h
//  WProjectForNative
//
//  Created by James on 16/9/11.
//  Copyright © 2016年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WNavigationBar : UINavigationBar
@property(nonatomic, strong)UIView *rightCustomView;
@property(nonatomic, strong)UIView *leftCustomView;
@property(nonatomic, strong)UIView *centerCustomView;
@property(nonatomic, strong)UIButton *backButton;
@property(nonatomic, copy)NSString *title;
@end
