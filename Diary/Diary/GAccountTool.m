//
//  GAccountTool.m
//  Diary
//
//  Created by 郭晓龙 on 16/3/30.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GAccountTool.h"
#import "KVNProgress.h"
@implementation GAccountTool

+(NSString*)dataPath{
    return [NSString stringWithFormat:@"%@/Documents/account.json",NSHomeDirectory()];
}

#pragma mark - 判断账号是否存在
+(BOOL)isExistAccount:(NSString *)account{
    NSData* data = [NSData dataWithContentsOfFile:[self dataPath]];
    if (data==nil) {
        return NO;
    }
    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    for (NSDictionary* dict in arr) {
        if ([account isEqualToString:dict[@"account"]]) {
            return YES;
        }
    }
    return NO;
    
}

#pragma mark - 判断指定账号密码是否正确
+(BOOL)isExistAccount:(NSString *)account password:(NSString *)password{
    NSData* data = [NSData dataWithContentsOfFile:[self dataPath]];
    if (data==nil) {
        return NO;
    }
    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    for (NSDictionary* dict in arr) {
        if ([account isEqualToString:dict[@"account"]]&&[password isEqualToString:dict[@"password"]]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - 添加一个账号
+(BOOL)addAccount:(NSString *)account password:(NSString *)password{
    //如果账户存在，添加失败
    if ([self isExistAccount:account password:password]) {
        return NO;
    }
    
    NSMutableArray* arr;
    NSData* data = [NSData dataWithContentsOfFile:[self dataPath]];
    if (data==nil) {
        arr = [NSMutableArray array];
    }
    else{
        NSArray* arr2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        arr = [arr2 mutableCopy];
    }
    [arr addObject:@{@"account":account,@"password":password}];
    
    data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:NULL];
    [data writeToFile:[self dataPath] atomically:YES];
    
    
    
    return YES;
}
@end
















