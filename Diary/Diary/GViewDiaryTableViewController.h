//
//  GViewDiaryTableViewController.h
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/28.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDiaryModel.h"
@class GViewDiaryTableViewController;
@protocol GViewDiaryTableViewControllerDelegate <NSObject>
@optional
-(void)viewDiaryTableViewControllerBackToList:(GViewDiaryTableViewController*) viewDiaryTableViewController;
-(void)viewDiaryTableViewControllerBackTolist:(GViewDiaryTableViewController*)viewDiaryTableViewController withDiaryModel:(GDiaryModel*)diaryModel;
@end
@interface GViewDiaryTableViewController : UITableViewController
@property (nonatomic, strong) GDiaryModel* diaryModel;
@property (nonatomic, weak) id<GViewDiaryTableViewControllerDelegate>delegete;
@end
