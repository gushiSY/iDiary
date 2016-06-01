//
//  GRegisterTableViewController.h
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/24.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GRegisterTableViewController;
@protocol GRegisterTableViewControllerDelegate <NSObject>

@optional
-(void)registerTableViewControllerBackToLoginTableViewController:(GRegisterTableViewController*)registerTableViewController;
@end
@interface GRegisterTableViewController : UITableViewController
@property (nonatomic, weak) id<GRegisterTableViewControllerDelegate>delegate;

@end
