//
//  GDiaryModel.h
//  Diary
//
//  Created by 郭晓龙 on 16/3/26.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDiaryModel : NSObject


@property (nonatomic ,copy) NSString* time;
@property (nonatomic ,copy) NSString* title;
@property (nonatomic, copy) NSString* text;

+(instancetype)diaryModelWithDictionary:(NSDictionary*)dict;
@end
