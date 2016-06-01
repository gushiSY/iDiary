//
//  GLoginTableViewController.m
//  Diary
//
//  Created by guoxiaolong8866 on 16/3/24.
//  Copyright © 2016年 guoxiaolong8866. All rights reserved.
//

#import "GLoginTableViewController.h"
#import "KVNProgress.h"
#import "GDiaryListTableViewController.h"
#import "GRegisterTableViewController.h"
#import "GAccountTool.h"

#define GLoginTableViewControllerRmemberPasswordSwitchKey @"rememberPassWordSwitchKey"
#define GLoginTableViewControllerAutomaticallyLoginSwitchKey @"automaticallyLoginSwitchKey"
#define GLoginTableViewControllerAccountKey @"accountKey"
#define GLoginTableViewControllerpasswordKey @"passwordKey"

@interface GLoginTableViewController ()<UITextFieldDelegate,GDiaryListTableViewControllerDelegate,GRegisterTableViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPassWordsSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *automaticallyLoginSwitch;


@end

@implementation GLoginTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLoginTableView];
    [self setUpSubViews];
}

-(void)setLoginTableView{
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSLog(@"**********************");
}

-(void)setUpSubViews{
    self.passWordTextField.secureTextEntry = YES;
    self.accountTextField.delegate = self;
    self.passWordTextField.delegate = self;
    
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
    BOOL rememberPasswordSwitchOn = [ud boolForKey:GLoginTableViewControllerRmemberPasswordSwitchKey];
    self.rememberPassWordsSwitch.on = rememberPasswordSwitchOn;
    
    BOOL automaticallyLoginSwitchOn = [ud boolForKey:GLoginTableViewControllerAutomaticallyLoginSwitchKey];
    self.automaticallyLoginSwitch.on = automaticallyLoginSwitchOn;
    
    self.accountTextField.text = [ud objectForKey:GLoginTableViewControllerAccountKey];
    self.passWordTextField.text = [ud objectForKey:GLoginTableViewControllerpasswordKey];
    
    if (self.automaticallyLoginSwitch.isOn) {
        [self loginButtonClicked:nil];
    }
}
#pragma mark - 登陆点击
- (IBAction)loginButtonClicked:(UIButton *)sender {
    
    if (self.accountTextField.text==nil||self.accountTextField.text.length<=0||self.passWordTextField.text==nil||self.passWordTextField.text.length<=0) {
        [KVNProgress showErrorWithStatus:@"请输入账户及密码"];
        return;
    }
    
    if (![GAccountTool isExistAccount:self.accountTextField.text]) {
        [KVNProgress showErrorWithStatus:@"该用户未注册"];
        [self.view endEditing:YES];
        return;
    }
    if (![GAccountTool isExistAccount:self.accountTextField.text password:self.passWordTextField.text]) {
        [KVNProgress showErrorWithStatus:@"用户或密码错误"];
        [self.view endEditing:YES];
        return;
    }
    else{
        [KVNProgress showWithStatus:@"验证成功，正在加载数据....."];
        [self.view endEditing:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [KVNProgress dismissWithCompletion:^{
                
                [self performSegueWithIdentifier:@"login2List" sender:nil];
                if (!self.rememberPassWordsSwitch.isOn) {
                    self.passWordTextField.text = @"";
                }
                //利用偏好设置对象存账号密码
                [[NSUserDefaults standardUserDefaults]setObject:self.accountTextField.text forKey:GLoginTableViewControllerAccountKey];
                [[NSUserDefaults standardUserDefaults]setObject:self.passWordTextField.text forKey:GLoginTableViewControllerpasswordKey];
            }];
        });
    }
//    //将所有用户都取出来
//    NSString* path = [NSString stringWithFormat:@"%@/Documents/account.json",NSHomeDirectory()];
//    NSData* data = [NSData dataWithContentsOfFile:path];
//    if (data==nil) {
//        [KVNProgress showErrorWithStatus:@"用户不存在"];
//        return;
//    }
//    NSArray* arr = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//    //遍历数组
//    for (NSDictionary* dict in arr) {
//        if ([self.accountTextField.text isEqualToString:dict[@"account"]]&&[self.passWordTextField.text isEqualToString:dict[@"password"]]) {
//            [KVNProgress showWithStatus:@"验证成功，正在加载数据....."];
//            [self.view endEditing:YES];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [KVNProgress dismissWithCompletion:^{
//                    
//                    [self performSegueWithIdentifier:@"login2List" sender:nil];
//                    if (!self.rememberPassWordsSwitch.isOn) {
//                        self.passWordTextField.text = @"";
//                    }
//                    //利用偏好设置对象存账号密码
//                    [[NSUserDefaults standardUserDefaults]setObject:self.accountTextField.text forKey:GLoginTableViewControllerAccountKey];
//                    [[NSUserDefaults standardUserDefaults]setObject:self.passWordTextField.text forKey:GLoginTableViewControllerpasswordKey];
//                }];
//            });
//            return;
//        }
//        [KVNProgress showErrorWithStatus:@"用户名或密码错误"];
//    }
    
}

#pragma mark - prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"login2List"]) {
        GDiaryListTableViewController* vc = segue.destinationViewController;
        vc.delegate = self;
        vc.accountName = self.accountTextField.text;
    }
    else if ([segue.identifier isEqualToString:@"login2Register"]){
        GRegisterTableViewController* vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

#pragma mark - 注册点击
- (IBAction)registerButtonClicked:(UIButton *)sender {
    [self performSegueWithIdentifier:@"login2Register" sender:nil];
}

#pragma mark - switch的操作
- (IBAction)rememberPasswordSwitchClicked:(UISwitch *)sender {
    if (!self.rememberPassWordsSwitch.isOn) {
        [self.automaticallyLoginSwitch setOn:NO animated:YES];
    }
    //获得偏好设置的对象（单例）
    NSUserDefaults* userDefoult = [NSUserDefaults standardUserDefaults];
    //储存偏好设置
    [userDefoult setBool:self.automaticallyLoginSwitch.isOn forKey:GLoginTableViewControllerAutomaticallyLoginSwitchKey];
    [userDefoult setBool:self.rememberPassWordsSwitch.isOn forKey:GLoginTableViewControllerRmemberPasswordSwitchKey];
}
- (IBAction)autoLoginSwitchClicked:(id)sender {
    if (self.automaticallyLoginSwitch.isOn) {
        [self.rememberPassWordsSwitch setOn:YES animated:YES];
    }
    //获得偏好设置的对象（单例）
    NSUserDefaults* userDefault = [NSUserDefaults standardUserDefaults];
    //储存偏好设置
    [userDefault setBool:self.automaticallyLoginSwitch.isOn forKey:GLoginTableViewControllerAutomaticallyLoginSwitchKey];
    [userDefault setBool:self.rememberPassWordsSwitch.isOn forKey:GLoginTableViewControllerRmemberPasswordSwitchKey];
}

#pragma mark - testField代理方法实现，点击return输入框光标换行，收回键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField==self.accountTextField) {
        [self.passWordTextField becomeFirstResponder];//成为第一响应者，获得键盘焦点
    }
    else{
        [self.accountTextField resignFirstResponder];
        [self.passWordTextField resignFirstResponder];
    }
    return YES;
}

#pragma mark - diaryListTableViewControllerBack代理方法实现
-(void)diaryListTableViewControllerBack:(GDiaryListTableViewController *)diaryListTableViewController{
    [self.navigationController popToViewController:self animated:YES];
}
#pragma mark - registerTableViewControllerBackToLoginTableViewController代理方法实现
-(void)registerTableViewControllerBackToLoginTableViewController:(GRegisterTableViewController *)registerTableViewController{
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
















