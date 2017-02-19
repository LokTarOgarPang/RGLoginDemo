//
//  ViewController.m
//  RGLoginDemo
//
//  Created by 泥红 on 2017/2/19.
//  Copyright © 2017年 RoyGao. All rights reserved.
//

#import "ViewController.h"
#import "RGLoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton * loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame =  CGRectMake(0, 0, 150, 50);
    loginBtn.center  = self.view.center;
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor blackColor]];
    [loginBtn addTarget:self action:@selector(loginBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loginBtnClicked
{
    RGLoginViewController *loginViewController = [[RGLoginViewController alloc]init];
    [self presentViewController:loginViewController animated:YES completion:^{
        
    }];
}


@end
