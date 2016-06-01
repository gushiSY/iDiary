//
//  GRegisterTableViewController.m
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/24.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GRegisterTableViewController.h"
#import "KVNProgress.h"
#import "GAccountTool.h"

@interface GRegisterTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmTextField;

@end

@implementation GRegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setUpNavigationBar];
 
}

-(void)setUpNavigationBar{
    self.passwordTextField.secureTextEntry = YES;
    self.confirmTextField.secureTextEntry = YES;
    self.navigationItem.title = @"注册";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerBarButtonClicked)];
}

-(void)backBarButtonClicked{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(registerTableViewControllerBackToLoginTableViewController:)]) {
        [self.delegate registerTableViewControllerBackToLoginTableViewController:self];
    }
}

-(void)registerBarButtonClicked{

    if (self.accountTextField.text==nil||self.accountTextField.text.length<=0||
        self.passwordTextField.text==nil||self.passwordTextField.text.length<=0||
        self.confirmTextField.text==nil||self.confirmTextField.text.length<=0
        ) {
        [KVNProgress showErrorWithStatus:@"请输入注册需要的信息"];
        [self.view endEditing:YES];
        return;
    }
    if (![self.passwordTextField.text isEqualToString:self.confirmTextField.text]) {
        [KVNProgress showErrorWithStatus:@"两次输入的密码不一致，请重新输入"];
        [self.view endEditing:YES];
        return;
    }
    
    if ([GAccountTool isExistAccount:self.accountTextField.text]) {
        [KVNProgress showErrorWithStatus:@"该账户已存在"];
        return;
    }
    [GAccountTool addAccount:self.accountTextField.text password:self.passwordTextField.text];

    
//    //取出沙盒中的路径
//    NSString* path = [NSString stringWithFormat:@"%@/Documents/account.json",NSHomeDirectory()];
//    //转为NSData对象
//    NSData* data = [NSData dataWithContentsOfFile:path];
//    NSMutableArray* arr ;
//    if (data==nil) {//没有这个文件
//        arr = [NSMutableArray array];
//    }
//    else{//json解析成数组
//        NSArray* arr2 = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//        for (NSDictionary* dict in arr2) {
//            if ([self.accountTextField.text isEqualToString:dict[@"account"]]) {
//                [KVNProgress showErrorWithStatus:@"该用户名已经存在"];
//                return;
//            }
//        }
//        arr = [arr2 mutableCopy];
//    }
//    //存储的数据添加到可变数组
//    [arr addObject:@{@"account":self.accountTextField.text,@"password":self.passwordTextField.text}];
//    //保存为json
//    data = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:NULL];
//    [data writeToFile:path atomically:YES];
    
    //跳转
    [KVNProgress showWithStatus:@"注册成功"];
    [self.view endEditing:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KVNProgress dismissWithCompletion:^{
        
            if (self.delegate&&[self.delegate respondsToSelector:@selector(registerTableViewControllerBackToLoginTableViewController:)]) {
                
                [self.delegate registerTableViewControllerBackToLoginTableViewController:self];
            }
        }];
    });
}

@end


















