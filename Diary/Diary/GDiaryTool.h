//
//  GDiaryTool.h
//  Diary
//
//  Created by 郭晓龙 on 16/3/30.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDiaryModel.h"
@interface GDiaryTool : NSObject

/**
 将account账户里的所有日记模型返回
 */
+(NSMutableArray*)allDiaryWithAccount:(NSString*)account;


/**
 保存account账户中的所有日记
 */
+(void)saveAllDiary:(NSArray*)diaryArray withAccount:(NSString*)account;
@end
