//
//  GDiaryModel.m
//  Diary
//
//  Created by 郭晓龙 on 16/3/26.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GDiaryModel.h"

@implementation GDiaryModel

+(instancetype)diaryModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary*)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
