//
//  HBaseViewController.h
//  NursingManages
//
//  Created by HuangZhen on 2017/5/31.
//  Copyright © 2017年 huangzhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WNavigationBar.h"
#import "UIViewController+WNavigationBar.h"
@interface HBaseViewController : UIViewController
typedef void (^Blocks) (NSDictionary *tempData,NSInteger state);
-(void) alert:(NSString*)msg ;//callbackFn: (void(^)())callback;
-(void) alertview:(NSString*)msg
         callback:(void(^)())callback;

- (void)ManagerPost:(NSString *)URLString
         parameters:(id)parameters
             header:(NSString *)header
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

- (void)ManagerGET:(NSString *)URLString
         parameters:(id)parameters
             header:(NSString *)header
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;

//POST请求
- (void)ManagerPost:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure;


- (void)receivePOSTWithTokenURLString:(NSString *)string
                          method:(NSString *)method
                            body:(NSString *)body
                               Token:(NSString *)Token
                          Blocks:(Blocks)blocks;


@property (nonatomic, strong) UIButton *coverBtn;


- (void)clickedCoverBtnAction:(UIButton*)sender;

//字典转字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic;
//字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转成key-value格式
-  (NSString *)sortedDictnoryByKey:(NSDictionary *)dict;
//url  UTF8转码
- (NSString *)urlUTF8:(NSString *)url;
//url 编译
- (NSString *)URLEncodedString;
//判断数字是否为整形
- (BOOL)isPureInt:(NSString*)string;

- (UIImage *)fixOrientation:(UIImage *)aImage;
//获取当前时间的前后时间
-(NSString *)getNDay:(NSInteger)n;
//获取前一周的日期
-(NSMutableArray *)latelySevenTime;
//获取当前的月份
- (NSString *)getThisMonth;
//获取上个月的月份
- (NSString *)setupRequestMonth;
//MD5加密
-(NSString *) md5:(NSString *)string;
//获取请求时的参数ParamDic
- (NSDictionary *)paramDic:(NSDictionary *)dic;
//当登录完成后，刷新界面
- (void)reload;
- (void)Outreload;
//压缩图片
- (NSData *)zipNSDataWithImage:(UIImage *)sourceImage;
//弹出设置窗口
- (void)loadAlertView:(NSString *)title
           contentStr:(NSString *)content
               btnNum:(NSInteger)num
            btnStrArr:(NSArray *)array
                 type:(NSInteger)typeStr;
@property (nonatomic, copy) NSString *routeName;
//字符串前面加[]
-(NSString *)addstringWithString:(NSString *)string;
//UIview转image
- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size;
//将image加入相册中
- (void)loadImageFinished:(UIImage *)image;
//根据url生成二维码
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;
//返回需要展示的二维码
- (CIImage *)getImage;
@end


