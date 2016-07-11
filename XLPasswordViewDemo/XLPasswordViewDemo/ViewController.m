//
//  ViewController.m
//  XLPasswordView
//
//  Created by Liushannoon on 16/6/29.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "ViewController.h"
#import "XLPasswordView.h"

@interface ViewController () <XLPasswordViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(100, 100, 200, 50);
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"点击展示XLPasswordView" forState:UIControlStateNormal];
    [button sizeToFit];
    [button addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)show
{
    XLPasswordView *passwordView = [XLPasswordView passwordView];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark    -   XLPasswordViewDelegate

/**
 *  输入密码位数已满时调用
 */
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
    NSLog(@"输入密码位数已满,在这里做一些事情,例如自动校验密码");
}

/**
 *  用户输入密码时调用
 *
 *  @param passwordView 视图
 *  @param password     输入的密码文本
 */
- (void)passwordView:(XLPasswordView *)passwordView passwordTextDidChange:(NSString *)password
{
    NSLog(@"%@",password);
}

/**
 *  点击了忘记密码时调用
 */
- (void)passwordViewClickForgetPassword:(XLPasswordView *)passwordView
{
    NSLog(@"点击了忘记密码,在这里做一些事情");
}

@end
