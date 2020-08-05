//
//  HAPIManager.h
//  HDemoProject
//
//  Created by James on 2019/3/5.
//  Copyright © 2019年 JamesWu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>
#import "HApiPort.h"
#define HAPINetErrorCode 9999999
@interface HAPIManager : AFHTTPSessionManager
/**
 *  API 单例
 *
 *  @return 单例
 */
+ (instancetype)sharedManager;

//思图大礼包
- (RACSignal *)facePackage:(NSString *)faceImg;
//思图人脸对比
- (RACSignal *)faceCompare:(NSString *)faceImg idCardImg:(NSString *)idCardImg;
@end

