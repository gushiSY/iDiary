//
//  GDiaryListTableViewController.h
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/24.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDiaryListTableViewController;
@protocol GDiaryListTableViewControllerDelegate <NSObject>

@optional
-(void)diaryListTableViewControllerBack:(GDiaryListTableViewController*)diaryListTableViewController;
@end

@interface GDiaryListTableViewController : UITableViewController
@property (nonatomic,copy) NSString* accountName;
@property (nonatomic,weak)id<GDiaryListTableViewControllerDelegate>delegate;
@end
