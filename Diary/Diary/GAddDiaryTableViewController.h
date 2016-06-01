//
//  GAddDiaryTableViewController.h
//  Diary
//
//  Created by 郭晓龙 on 16/3/26.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDiaryModel.h"
@class GAddDiaryTableViewController;
@protocol GAddDiaryTableViewControllerDelegate <NSObject>

@optional
-(void)addDiaryTableViewControllerBack:(GAddDiaryTableViewController*)addDiaryTableViewController;
-(void)addDiaryTableViewControllerBack:(GAddDiaryTableViewController*)addDiaryTableViewController withDiaryModel:(GDiaryModel*)diaryModel;
@end

@interface GAddDiaryTableViewController : UITableViewController
@property (nonatomic, weak) id<GAddDiaryTableViewControllerDelegate>delegate;
@end
