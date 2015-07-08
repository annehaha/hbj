//
//  myNetworking.m
//  hbj_app
//
//  Created by eidision on 14/12/8.
//  Copyright (c) 2014年 zhangchao. All rights reserved.
//

#import "myNetworking.h"

static NSString * const HuijinAPIBaseURLString = @"http://192.168.0.123:8080/MServer/rest/";
static NSString * const baseurlstring = @"http://112.64.16.223:8081/restfulServer/rest/";

@implementation myNetworking

+ (instancetype)sharedClient {
    static myNetworking *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[myNetworking alloc] initWithBaseURL:[NSURL URLWithString:HuijinAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
        //_sharedClient.responseSerializer.stringEncoding=NSUTF8StringEncoding;
    });
    
    return _sharedClient;
}

+ (instancetype)sharedClient1 {
    static myNetworking *_sharedClient1 = nil;
    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
        _sharedClient1 = [[myNetworking alloc] initWithBaseURL:[NSURL URLWithString:baseurlstring]];
        _sharedClient1.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient1.securityPolicy.allowInvalidCertificates = YES;
        //_sharedClient.responseSerializer.stringEncoding=NSUTF8StringEncoding;
    });
    
    return _sharedClient1;
}

@end
