//
//  GDiaryTool.m
//  Diary
//
//  Created by 郭晓龙 on 16/3/30.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GDiaryTool.h"

@implementation GDiaryTool

+(NSString*)dataPathWithAccount:(NSString*)account{//返回account账户的数据，例如aaa_diary.json,bbb_diary.json
    return [NSString stringWithFormat:@"%@/Documents/%@_diary.json",NSHomeDirectory(),account];
}

/**
 将account账户里的所有日记模型返回
 */
+(NSMutableArray *)allDiaryWithAccount:(NSString *)account{
    
    //1.从文件中读取JSON数据
    NSData* data = [NSData dataWithContentsOfFile:[self dataPathWithAccount:account]];
    
    if (data==nil) {
        return [NSMutableArray array];
    }
    
    //2.JSON数据反序列化为OC中德数据
    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    //3.将数组中的字典转模型
    NSMutableArray* arr2 = [NSMutableArray array];
    for (NSDictionary* dict in arr) {
        GDiaryModel* model = [GDiaryModel diaryModelWithDictionary:dict];
        [arr2 addObject:model];
    }

    //4.返回模型数组
    return arr2;
}


/**
 保存account账户中的所有日记
 */
+(void)saveAllDiary:(NSArray *)diaryArray withAccount:(NSString *)account{
    
    //1.将模型数组中的模型转字典，JSON只能存字典，数组，OC类型
    NSMutableArray* arr = [NSMutableArray array];
    for (GDiaryModel* model in diaryArray) {
        //模型转字典，小技巧：返回的是字典dictionary开头
    NSDictionary* dict = [model dictionaryWithValuesForKeys:@[@"time",@"title",@"text"]];
        [arr addObject:dict];
    }
    
    //2.将数组序列为JSON数据，小技巧：返回的是数据data，以data开头
    NSData* data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:NULL];
    //3.将JSON数据保存在文件中
    [data writeToFile:[self dataPathWithAccount:account] atomically:YES];
}
@end
















