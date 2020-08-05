
/*
 基文件
 */

#define KEYWINDOW [UIApplication sharedApplication].delegate.window
#import "HBaseViewController.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>
#import <AFNetworking.h>
#import "WCustomNavigationController.h"
@interface HBaseViewController ()
@end
@implementation HBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//#pragma mark 弹窗
-(void) alert:(NSString*)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self topViewController] presentViewController:alertController animated:YES completion:nil];
    });
}
#pragma mark 返回window上面的顶级视图
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:self.view.window.rootViewController];
}
//获取window上面的顶级视图
- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
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
