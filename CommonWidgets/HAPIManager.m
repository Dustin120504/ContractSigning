//
//  HAPIManager.m
//  HDemoProject
//
//  Created by James on 2019/3/5.
//  Copyright © 2019年 JamesWu. All rights reserved.
//

#import "HAPIManager.h"
#import <CommonCrypto/CommonDigest.h>
#define POSTMethod @"POST"
#define GETMethod @"GET"
#define HAPIManagerErrorDomain @"HAPIManagerErrorDomain"
#define kErrorWithCode(errorCode,msg) [[NSError alloc] initWithDomain:HAPIManagerErrorDomain code:errorCode userInfo:@{@"msg":msg}]
@interface HAPIManager()

@end

@implementation HAPIManager
+ (instancetype)sharedManager {
//    static dispatch_once_t onceToken;
    static HAPIManager *instance;
//    dispatch_once(&onceToken, ^{
        instance = [self manager];
        instance.requestSerializer = [[AFHTTPRequestSerializer alloc]init];
        instance.securityPolicy.allowInvalidCertificates = YES;
        instance.requestSerializer.timeoutInterval = 30;
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"application/x-www-form-urlencoded", @"image/*", nil];
        [instance.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [instance.requestSerializer setValue:F(@"Bearer %@",[[TMCache sharedCache]objectForKey:@"token"]) forHTTPHeaderField:@"authorization"];
        [instance.requestSerializer setValue:@"ios" forHTTPHeaderField:@"platform"];
    
        //配置默认证书的Https请求
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.allowInvalidCertificates = YES;
        securityPolicy.validatesDomainName = NO;
        instance.securityPolicy = securityPolicy;
//    });
    
    return instance;
}

- (instancetype)init {
    return [[self class] sharedManager];
}


#pragma mark -- requestMethod
- (RACSignal *)requestPrivateParameter:(NSDictionary *)privateParameter
                            apiPortUrl:(NSString *)apiPortUrl
                                method:(NSString *)method
                                   key:(NSString *)key
                               pageKey:(NSString *)pageKey {
    @weakify(self);
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSURLSessionDataTask *task;
        NSDictionary *parameter = privateParameter;
        id success = ^(NSURLSessionDataTask *task, id responseObject) {
            @strongify(self);
            id result = [self parseResultWithValue:responseObject];
            if ([result isKindOfClass:[NSError class]]) {
                [subscriber sendError:result];
            }else{
                NSString *msg = @"";
                if (responseObject && responseObject[@"msg"]) {
                    msg = responseObject[@"msg"];
                }
                [subscriber sendNext:[RACTuple tupleWithObjects:result,msg,responseObject, nil]];
            }
            [subscriber sendCompleted];
        };
        
        id failure = ^(NSURLSessionDataTask *task, NSError *error) {
            NSError *er = [[NSError alloc]initWithDomain:HAPIManagerErrorDomain
                                                    code:HAPINetErrorCode
                                                userInfo:@{@"msg:%@":error}];
            [subscriber sendError:er];
            [subscriber sendCompleted];
        };
        
        if ([method isEqualToString:POSTMethod]) {
            [self POST:apiPortUrl
            parameters:parameter
               success:success
               failure:failure];
        }else if ([method isEqualToString:GETMethod]) {
            [self GET:apiPortUrl
           parameters:parameter
              success:success
              failure:failure];
        }
    
        return [RACDisposable disposableWithBlock:^{
            [task cancel];
        }];
    }];
}

- (id)parseResultWithValue:(id)value {
    NSError *error = [self parseResponseError:value];
    if (error) {
        return error;
    }
    if (value && [value valueForKeyPath:@"data"]) {
        value = [value valueForKeyPath:@"data"];
    }else{
        return value;
    }
    return value;
}

- (NSError *)parseResponseError:(NSDictionary *)response {
    if ([response.allKeys containsObject:@"status"]) {
        if (![response[@"status"] isEqualToString:@"0"]) {
            NSInteger code = [response[@"status"] integerValue];
            NSString *errorInfo = response[@"msg"];
            return kErrorWithCode(code, errorInfo);
        }
    }
    return nil;
}
//思图大礼包
- (RACSignal *)facePackage:(NSString *)faceImg {
    NSDictionary *paramDic = @{@"faceImg":faceImg};
    return [self requestPrivateParameter:paramDic
                              apiPortUrl:Malling_package
                                  method:POSTMethod
                                     key:nil
                                 pageKey:nil];
}
// 思图人脸对比
- (RACSignal *)faceCompare:(NSString *)faceImg idCardImg:(NSString *)idCardImg {
    NSDictionary *paramDic = @{@"faceImg":faceImg,
                               @"idCardImg":idCardImg};
    return [self requestPrivateParameter:paramDic
                              apiPortUrl:Malling_compare
                                  method:POSTMethod
                                     key:nil
                                 pageKey:nil];
}
@end
