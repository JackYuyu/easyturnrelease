//
//  HttpTool.m
//  网络请求封装
//
//  Created by apple on 15-8-20.
//  Copyright (c) 2015年 jackyu
//

#import "HttpTool.h"
#import "AFNetworking.h"
//#import "NSDictionary+MD5.h"
//#import "StringConvert.h"
#import "AppDelegate.h"

@implementation HttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 2.发送GET请求
    [mgr GET:[NSString stringWithFormat:@"%@/%@", devHost_Http_App, url] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if ([responseObject[@"code"] isEqualToString:@"110"]) {
                NSLog(@"-------------------%@",url);
            }else if ([responseObject[@"code"] isEqualToString:@"111"]){
                [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil];
                [[ACToastView toastView]showInfoWithStatus:@"该账户已在其他设备上登录,请重新登录"];
            }
            success(responseObject);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    //    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:devHost_Http_App]];
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [AFHTTPSessionManager manager];
        
        mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/plain", @"text/javascript", nil];
        mgr.requestSerializer.timeoutInterval = 10;
    });
    [mgr.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];

    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //secret
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:params];
    [newdic setValue:[NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
    
    // 2.发送POST请求
    [mgr POST:[NSString stringWithFormat:@"%@/%@", devHost_Http_App, url] parameters:newdic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            
            if ([responseObject[@"result"] isEqualToString:@"0"]) {
                success(responseObject);
            }
            if ([responseObject[@"code"] isEqualToString:@"111"]){
                [[NSNotificationCenter defaultCenter]postNotificationName:LOGINOFFSELECTCENTERINDEX object:nil];
                [[ACToastView toastView]showInfoWithStatus:@"该账户已在其他设备上登录,请重新登录"];
            }
            
            if ([responseObject[@"errcode"] isEqualToString:@"100024"] || [responseObject[@"errcode"] isEqualToString:@"100025"]) {
                
                [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    }];
}

+ (void)put:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", devHost_Http_App, url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    // 设置请求头
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager PUT:[NSString stringWithFormat:@"%@/%@", devHost_Http_App, url] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
//参数放在body里面
+ (void)postWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@", url];
    //这一行是测试
//    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", devHost_Http_App, url];

    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"token"];
    // 设置body
    [request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            success(responseObject);
            if (show) {
            }
            
        } else {
            failure(error);
        }
    }] resume];
}

+ (void)putWithUrl:(NSString *)url body:(NSData *)body showLoading:(BOOL)show success:(void(^)(NSDictionary *response))success failure:(void(^)(NSError *error))failure
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", devHost_Http_App, url];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PUT" URLString:requestUrl parameters:nil error:nil];
    request.timeoutInterval= 10;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:token forHTTPHeaderField:@"token"];

    // 设置body
    [request setHTTPBody:body];
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;

    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            success(responseObject);
            if (show) {
            }
            
        } else {
            failure(error);
        }
    }] resume];
}
+ (void)delete:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    NSString *requestUrl = [NSString stringWithFormat:@"%@/%@", devHost_Http_App, url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/javascript",@"text/json",@"text/plain", nil];
    
    // 设置请求头
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [manager DELETE:[NSString stringWithFormat:@"%@/%@", devHost_Http_App, url] parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success) {
//            success(responseObject);
//        }
        //请求成功的操作
        if (success) {
            NSDictionary *dict = [NSJSONSerialization  JSONObjectWithData:responseObject options:0 error:NULL];
            if(dict){
                success(dict);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
