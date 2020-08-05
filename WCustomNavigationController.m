//
//  WCustomNavigationController.m
//  WProjectForNative
//
//  Created by James on 16/9/9.
//  Copyright © 2016年 James. All rights reserved.
//

#import "WCustomNavigationController.h"
#import "UIImage+Color.h"
#import "UtilsMacro.h"
@interface WCustomNavigationController ()

@end

@implementation WCustomNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    [UINavigationBar appearance].tintColor = RGB(255, 255, 255);
    [UINavigationBar appearance].barTintColor = kNavBlueColor;
    
    [UINavigationBar appearance].shadowImage = [[UIImage alloc] init];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                         NSFontAttributeName:[UIFont systemFontOfSize:18]};
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithSolidColor:kNavBlueColor size:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(BOOL)shouldAutorotate{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
