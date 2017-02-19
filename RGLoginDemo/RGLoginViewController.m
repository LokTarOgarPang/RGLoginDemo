//
//  RGLoginViewController.m
//  RGLoginDemo
//
//  Created by 泥红 on 2017/2/19.
//  Copyright © 2017年 RoyGao. All rights reserved.
//

#import "RGLoginViewController.h"
#import "RGSignInView.h"
#import "RGSignInViewModel.h"
#import "Configuration.h"
@interface RGLoginViewController ()<RGSignInViewDelegate>{
    NSString *resetPassWordString;
}


@property (nonatomic,strong)RGSignInViewModel *signInViewModel;
@property (nonatomic,strong)RGSignInView *signInView;
@end

@implementation RGLoginViewController

#pragma mark 懒加载
-(RGSignInViewModel *)signInViewModel
{
    if (!_signInViewModel ) {
        _signInViewModel = [[RGSignInViewModel alloc]init];
    }
    return _signInViewModel;
}

-(RGSignInView *)signInView
{
    if (!_signInView) {
        _signInView = [[RGSignInView alloc]init];
        _signInView.signInDelegate = self;
    }
    return _signInView;
}

#pragma mark
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view = self.signInView;
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:kUsername];
    self.signInView.emailTextField.text = userName? userName:nil;
    
    
    NSString *passWord = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    self.signInView.passwordTextField.text = passWord? passWord:nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SignInDelegate
//返回上界面
-(void)signInViewTurnBackBtnClicked:(RGSignInView *)signIn
{
     [self dismissViewControllerAnimated:YES completion:nil];
}
//寻找密码
-(void)signInViewFindPasswordBtnClicked:(RGSignInView *)signIn
{
    __weak typeof(self) weakSelf = self;
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"enter_registered_email", nil)
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"email", nil);
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
     [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        NSArray * textfields = alertController.textFields;
        UITextField * emailField = textfields[0];
        resetPassWordString = emailField.text;
        //需要先在本地判断输入的内容是否符合邮箱格式
        NSString *emailTip  = [weakSelf.signInViewModel tipOfTestEmail:emailField.text];
        if (emailTip) {
            [weakSelf presentViewController:[weakSelf.signInViewModel tipWithTitle:NSLocalizedString(@"email", nil) text:emailTip] animated:YES completion:nil];
            
        }else{

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@"向服务器发送请求，传入用户输入的邮箱地址 %@",emailField.text);
            });
            
        }
        
    }]];
    
   
    [self presentViewController:alertController animated:YES completion:nil];

}
//登陆
-(void)signInViewSignInBtnClicked:(RGSignInView *)signIn
{
    [signIn.passwordTextField endEditing:YES];
    
    NSString *emailTip = [self.signInViewModel tipOfTestEmail:signIn.emailTextField.text];
    if (emailTip) {
        [self presentViewController:[self.signInViewModel tipWithTitle:NSLocalizedString(@"email", nil) text:emailTip] animated:YES completion:nil];
        return;
    }
    
    NSString *passwordTip = [self.signInViewModel tipOfTestPassword:signIn.passwordTextField.text];
    if (passwordTip) {
        [self presentViewController:[self.signInViewModel tipWithTitle:NSLocalizedString(@"password", nil) text:passwordTip] animated:YES completion:nil];
        return;
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"向服务器发送请求，传入用户输入的用户名：%@ 密码：%@",signIn.emailTextField.text,signIn.passwordTextField.text);
    });
    //假设用户名与密码向匹配
    //实际开发中不能明文存储密码，需要加密处理，本处省略了。而且
    [[NSUserDefaults standardUserDefaults]setObject:signIn.emailTextField.text forKey:kUsername];
    [[NSUserDefaults standardUserDefaults]setObject:signIn.passwordTextField.text forKey:kPassword];

}
//注册
-(void)signInViewSignUpBtnClicked:(RGSignInView *)signIn
{
    
}
//FaceBook第三方登录
-(void)signInViewFacebookBtnClicked:(RGSignInView *)signIn
{
    
}
//Wechat 第三方登录
-(void)signInViewWeChatBtnClicked:(RGSignInView *)signIn
{
    
}

@end
