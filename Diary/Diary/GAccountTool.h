//
//  GAccountTool.h
//  Diary
//
//  Created by 郭晓龙 on 16/3/30.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAccountTool : NSObject

//判断一个账号是否存在
+(BOOL)isExistAccount:(NSString*)account;

//判断指定账户密码是否正确
+(BOOL)isExistAccount:(NSString*)account password:(NSString*)password;

//添加一个账户
+(BOOL)addAccount:(NSString*)account password:(NSString*)password;



@end
