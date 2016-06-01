//
//  GAddDiaryTableViewController.m
//  Diary
//
//  Created by 郭晓龙 on 16/3/26.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GAddDiaryTableViewController.h"
#import "GDiaryModel.h"
#import "KVNProgress.h"

@interface GAddDiaryTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UITextView *textTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) UIDatePicker* datePicker;
@end

@implementation GAddDiaryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigationBar];
    [self setUpSubViews];
  
}
-(void)setUpSubViews{
    
    
    UIDatePicker* datePicker = [[UIDatePicker alloc]init];
    self.timeTextField.inputView = datePicker;
    self.datePicker = datePicker;
    
    UIBarButtonItem* item1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* item2 = [[UIBarButtonItem alloc]initWithTitle:@"选择" style:UIBarButtonItemStylePlain target:self action:@selector(selectToolBarButtonItemClicked)];
    
    UIToolbar* toolBar = [[UIToolbar alloc]init];
    toolBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 49);
    toolBar.items = @[item1,item2];
    self.timeTextField.inputAccessoryView = toolBar;
    
}
-(void)selectToolBarButtonItemClicked{
    self.timeTextField.text = [self.datePicker.date descriptionWithLocale:[NSLocale systemLocale]];
    [self.timeTextField resignFirstResponder];
}


-(void)setUpNavigationBar{
    self.navigationItem.title = @"添加日记";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBarButtonItemClicked)];
    
}
#pragma mark - 写日记返回按钮实现
-(void)backBarButtonItemClicked{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addDiaryTableViewControllerBack:)]) {
        [self.delegate addDiaryTableViewControllerBack:self];
    }
}
#pragma mark - 写日记DONE按钮实现
-(void)doneBarButtonItemClicked{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(addDiaryTableViewControllerBack:withDiaryModel:)]) {
        
        if (self.timeTextField.text==nil||self.timeTextField.text.length<=0||self.titleTextField.text==nil||self.titleTextField.text.length<=0||self.textTextView.text==nil||self.textTextView.text.length<=0) {
            [KVNProgress showErrorWithStatus:@"请将您的日记填写完整"];
            [self.view endEditing:YES];
            return;
        }
        
        [KVNProgress showWithStatus:@"保存日记中..."];
        [self.view endEditing:YES];
        
        
        GDiaryModel* model = [[GDiaryModel alloc]init];
        model.time = self.timeTextField.text;
        model.title = self.titleTextField.text;
        model.text = self.textTextView.text;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress dismissWithCompletion:^{
                [self.delegate addDiaryTableViewControllerBack:self withDiaryModel:model];
            }];
            
        });
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end















