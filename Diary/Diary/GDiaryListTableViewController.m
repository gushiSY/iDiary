//
//  GDiaryListTableViewController.m
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/24.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GDiaryListTableViewController.h"
#import "GAddDiaryTableViewController.h"
#import "GDiaryModel.h"
#import "GViewDiaryTableViewController.h"
#import "GDiaryTool.h"
#import "GViewDiaryTableViewController.h"

@interface GDiaryListTableViewController ()<GAddDiaryTableViewControllerDelegate,GViewDiaryTableViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray* diaryArray;

@end

@implementation GDiaryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationBar];
}

-(NSMutableArray *)diaryArray{
    if (_diaryArray==nil) {
        _diaryArray = [GDiaryTool allDiaryWithAccount:self.accountName];
        
        
        //从网络上下载
        
        
    }
    return _diaryArray;
}
#pragma mark - 列表页面navigationBar按钮设置（注销，添加，删除）
-(void)setUpNavigationBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOffBarButtonClicked)];
    self.navigationItem.title = self.accountName;
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBarButtonItemClicked)];
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(trashBarButtonItemClicked)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
}
#pragma mark - 列表页面添加按钮实现
-(void)addBarButtonItemClicked{
    [self performSegueWithIdentifier:@"list2Add" sender:nil];
}

#pragma mark - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"list2Add"]) {
        GAddDiaryTableViewController* addTVC = segue.destinationViewController;
        addTVC.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"list2View"]) {
        GViewDiaryTableViewController* vc = segue.destinationViewController;
        vc.delegete = self;
        vc.diaryModel = self.diaryArray[self.tableView.indexPathForSelectedRow.row];
    }
}

#pragma mark - 列表页面删除按钮实现
-(void)trashBarButtonItemClicked{
    NSLog(@"trash");
    [self.tableView setEditing:!self.tableView.isEditing animated:YES];
}
#pragma mark - 删除按钮的编辑状态取消
-(void)cancelTrashBarButtonItemIsEditing{
    if (self.tableView.isEditing) {
        [self trashBarButtonItemClicked];
    }
}

#pragma mark - 编辑状态代理方法实现（删除）
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.diaryArray removeObjectAtIndex:indexPath.row];
    [GDiaryTool saveAllDiary:self.diaryArray withAccount:self.accountName];
    [self.tableView reloadData];
}
#pragma mark - 注销按钮点击
-(void)logOffBarButtonClicked{
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:@"确定注销？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* a1 = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(diaryListTableViewControllerBack:)]) {
            [self.delegate diaryListTableViewControllerBack:self];
        }
        
    }];
    UIAlertAction* a2 = [UIAlertAction actionWithTitle:@"点错了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:a1];
    [ac addAction:a2];
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark - addDiaryTableViewController代理方法实现
-(void)addDiaryTableViewControllerBack:(GAddDiaryTableViewController *)addDiaryTableViewController{
    [self.navigationController popToViewController:self animated:YES];
}

-(void)addDiaryTableViewControllerBack:(GAddDiaryTableViewController *)addDiaryTableViewController withDiaryModel:(GDiaryModel *)diaryModel{
    
    [self.diaryArray addObject:diaryModel];
    // 往数组中添加日记，意味着数组发生变化，需要重新保存。(模型数组发生变化，就保存)
    [GDiaryTool saveAllDiary:self.diaryArray withAccount:self.accountName];
    
    
    [self.tableView reloadData];//这样写还不够，显示不出来，需要实现tableView数据源代理
    [self.navigationController popToViewController:self animated:YES];
    [self cancelTrashBarButtonItemIsEditing];
    //what what what what what what what what......
}

#pragma mark - viewDiaryTableViewController代理方法实现(返回，编辑后保存返回列表)
-(void)viewDiaryTableViewControllerBackToList:(GViewDiaryTableViewController *)viewDiaryTableViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDiaryTableViewControllerBackTolist:(GViewDiaryTableViewController *)viewDiaryTableViewController withDiaryModel:(GDiaryModel *)diaryModel{
    [self.diaryArray replaceObjectAtIndex:self.tableView.indexPathForSelectedRow.row withObject:diaryModel];
    [GDiaryTool saveAllDiary:self.diaryArray withAccount:self.accountName];
    [self.tableView reloadData];
    [self.navigationController popToViewController:self animated:YES];
}

#pragma mark - table view date source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.diaryArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"diaryCell"];
    GDiaryModel* model = self.diaryArray[indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.time;
    return cell;
}
#pragma mark - 点击cell跳转查看页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"list2View" sender:nil];
}
@end
















