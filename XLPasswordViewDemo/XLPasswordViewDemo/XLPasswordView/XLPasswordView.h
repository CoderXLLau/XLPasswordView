//
//  XLPasswordView.h
//  XLPasswordView
//
//  Created by Liushannoon on 16/6/29.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLPasswordView;

@protocol XLPasswordViewDelegate <NSObject>

/**
 *  用户输入密码时调用
 *
 *  @param passwordView 视图
 *  @param password     输入的密码文本
 */
- (void)passwordView:(XLPasswordView *)passwordView passwordTextDidChange:(NSString *)password;
/**
 *  输入密码位数已满时调用
 */
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password;

@optional
/**
 *  点击了忘记密码时调用
 */
- (void)passwordViewClickForgetPassword:(XLPasswordView *)passwordView;

@end

@interface XLPasswordView : UIView

/**
 *  delegate
 */
@property (nonatomic , weak) id <XLPasswordViewDelegate>delegate;

/**
 *  快速创建方法
 */
+ (instancetype)passwordView;
/**
 *  展示
 *
 *  @param view 添加到的目的视图,如果为空就添加到窗口上面
 */
- (void)showPasswordInView:(UIView *)view;

/**
 *  隐藏
 */
- (void)hidePasswordView;
/**
 *  清除
 */
- (void)clearPassword;

@end
