//
//  GViewDiaryTableViewController.m
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/28.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GViewDiaryTableViewController.h"

@interface GViewDiaryTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;

@end

@implementation GViewDiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    [self setUpNavigationBar];
    NSLog(@"%@",self.textTextView.text);//------------*^%*&^%*&
}

-(void)setUpSubViews{
    self.timeTextField.text = self.diaryModel.time;
    self.titleTextField.text = self.diaryModel.title;
    self.textTextView.text = self.diaryModel.text;
}

-(void)setUpNavigationBar{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAndBackToListBarButtonItemClicked)];
}
-(void)backBarButtonItemClicked{
    NSLog(@"%@",self.textTextView.text);//-----------(^%*&^%*&)&
    if (self.delegete&&[self.delegete respondsToSelector:@selector(viewDiaryTableViewControllerBackToList:)]) {
        [self.delegete viewDiaryTableViewControllerBackToList:self];
    }
}
-(void)saveAndBackToListBarButtonItemClicked{
    if (self.delegete&&[self.delegete respondsToSelector:@selector(viewDiaryTableViewControllerBackTolist:withDiaryModel:)]) {
        
        GDiaryModel * model = [[GDiaryModel alloc]init];
        model.time = self.timeTextField.text;
        model.title = self.titleTextField.text;
        model.text = self.textTextView.text;
        
        [self.delegete viewDiaryTableViewControllerBackTolist:self withDiaryModel:model];
    }
}




@end













