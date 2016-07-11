//
//  XLPasswordView.m
//  XLPasswordView
//
//  Created by Liushannoon on 16/6/29.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "XLPasswordView.h"

#import "XLPasswordInputView.h"
#import "XLRandomKeyboard.h"
#import "UIView+XLPasswordView.h"
#import "UIImage+XLPasswordView.h"
#import "UIColor+XLPasswordView.h"

#define kPasswordLenght 6

@interface XLPasswordView () <XLRandomKeyboardDelegate , XLPasswordInputViewDelegate , UIAlertViewDelegate>

/**
 *  背景视图
 */
@property (nonatomic , strong) UIView *backgroundView;
/**
 *  密码输入视图容器视图
 */
@property (nonatomic , strong) UIView  *inputContainerView;
/**
 *  密码输入视图
 */
@property (nonatomic , strong) XLPasswordInputView  *passwordInputView;
/**
 *  随机键盘
 */
@property (nonatomic , strong) XLRandomKeyboard  *randomKeyboard;
/**
 *  输入的密码
 */
@property (nonatomic , strong) NSString  *password;
/**
 *  密码数组
 */
@property (nonatomic , strong) NSMutableArray  *passwordNumberS;
/**
 *  忘记密码label
 */
@property (nonatomic , weak) UILabel *forgetPasswordLabel;

@end

@implementation XLPasswordView

#pragma mark    -   set / get

/**
 *  懒加载成员属性
 */
- (NSMutableArray *)passwordNumberS
{
    if (_passwordNumberS == nil) {
        _passwordNumberS = [NSMutableArray array];
    }
    
    return _passwordNumberS;
}

#pragma mark    -   initial

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initial];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initial];
    }
    return self;
}

/**
 *  初始化
 */
- (void)initial
{
    self.password = [NSString string];
    self.backgroundView = ({
        UIView *tempView = [[UIView alloc] init];
        tempView.backgroundColor = [UIColor blackColor];
        tempView.alpha = 0.0;
        [self addSubview:tempView];
        [tempView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCloseButton)]];
        tempView;
    });
    
    self.inputContainerView = ({
        UIView *tempView = [[UIView alloc] init];
        tempView.backgroundColor = [UIColor colorWithHexString:@"f3f3f5"];
        [self addSubview:tempView];
        tempView.frame = CGRectMake(0, XLScreenH, XLScreenW, XLScreenW * 0.6 + 224 * xl_autoSizeScaleY);
        tempView;
    });
    
    UILabel *titleLabel = ({
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.text = @"输入密码";
        tempLabel.numberOfLines = 1;
        tempLabel.textColor = [UIColor blackColor];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.font = [UIFont systemFontOfSize:18];
        [tempLabel sizeToFit];
        tempLabel.xl_centerX = XLScreenW * 0.5;
        tempLabel.xl_centerY = 45 * xl_autoSizeScaleY * 0.5;
        tempLabel;
    });
    [self.inputContainerView addSubview:titleLabel];
    
    UIView *separateView = ({
        UIView *tempView = [[UIView alloc] init];
        tempView.backgroundColor = [UIColor clearColor];
        tempView.frame = CGRectMake(0, 45 * xl_autoSizeScaleY, XLScreenW, 0.5);
        tempView.backgroundColor = [UIColor colorWithHexString:@"ccccce"];
        tempView;
    });
    [self.inputContainerView addSubview:separateView];
    
    UIButton *closeButton = ({
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"XLPasswordView.bundle/payment_shutdown"] forState:UIControlStateNormal];
        button.xl_x = 0;
        button.xl_y = 0;
        button.xl_width = 50;
        button.xl_height = 45 * xl_autoSizeScaleY;
        [button addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
        button;
    });
    [self.inputContainerView addSubview:closeButton];

    self.passwordInputView = ({
        XLPasswordInputView *passwordInputView = [XLPasswordInputView passwordInputViewWithPasswordLength:kPasswordLenght];
        passwordInputView.userInteractionEnabled = NO;
        passwordInputView.gridLineColor = [UIColor colorWithHexString:@"ccccce"];
        passwordInputView.gridLineWidth = 1;
        passwordInputView.dotColor = [UIColor colorWithHexString:@"ccccce"];
        passwordInputView.dotWidth = 12;
        CGFloat gridWidth = 54 * xl_autoSizeScaleX;
        passwordInputView.xl_width = kPasswordLenght * gridWidth;
        passwordInputView.xl_height = gridWidth;
        passwordInputView.xl_centerX = XLScreenW * 0.5;
        passwordInputView.xl_y = 72 * xl_autoSizeScaleY;
        passwordInputView;
    });
    [self.inputContainerView addSubview:self.passwordInputView];
    
    UILabel *forgetPasswordLabel = ({
        UILabel *tempLabel = [[UILabel alloc] init];
        tempLabel.backgroundColor = [UIColor clearColor];
        tempLabel.text = @"忘记密码?";
        tempLabel.userInteractionEnabled = YES;
        tempLabel.numberOfLines = 1;
        tempLabel.textColor = [UIColor colorWithHexString:@"55d5fa"];
        tempLabel.textAlignment = NSTextAlignmentCenter;
        tempLabel.font = [UIFont systemFontOfSize:13];
        tempLabel.xl_height = 40;
        tempLabel.xl_width = 96;
    
        tempLabel.xl_y = CGRectGetMaxY(self.passwordInputView.frame) + 3;
        tempLabel.xl_x = XLScreenW - tempLabel.xl_width;
        [tempLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickForgetPasswordLabel)]];
        tempLabel;
    });
    self.forgetPasswordLabel = forgetPasswordLabel;
    [self.inputContainerView addSubview:forgetPasswordLabel];
    
    self.randomKeyboard = ({
        XLRandomKeyboard *randomKeyboard = [[XLRandomKeyboard alloc] init];
        randomKeyboard.delegate = self;
        randomKeyboard.xl_width = XLScreenW;
        randomKeyboard.xl_height = XLScreenW * 0.6;
        randomKeyboard.xl_x = 0;
        randomKeyboard.xl_y = 224 * xl_autoSizeScaleY;
        [self.inputContainerView addSubview:randomKeyboard];
        randomKeyboard;
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
}

#pragma mark    -   private method

/**
 *  退出
 */
- (void)clickCloseButton
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"是否确定退出" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    [alertView show];
}

/**
 *  点击忘记密码
 */
- (void)clickForgetPasswordLabel
{
    if ([self.delegate respondsToSelector:@selector(passwordViewClickForgetPassword:)]) {
        [self.delegate passwordViewClickForgetPassword:self];
    }
}

#pragma mark    -   XLRandomKeyboardDelegate method

/** 数字按钮点击 */
- (void)randomKeyboard:(XLRandomKeyboard *)keyboard clickButtonNumber:(NSString *)number
{
    if (self.passwordNumberS.count < kPasswordLenght) {
        [self.passwordNumberS addObject:number];
        NSMutableString *password = [NSMutableString string];
        for ( int i = 0 ; i < self.passwordNumberS.count; i ++) {
            [password appendString:self.passwordNumberS[i]];
        }
        if ([self.delegate respondsToSelector:@selector(passwordView:passwordTextDidChange:)]) {
            [self.delegate passwordView:self passwordTextDidChange:password];
        }
        
        if (self.passwordNumberS.count == kPasswordLenght) {
            if ([self.delegate respondsToSelector:@selector(passwordView:didFinishInput:)]) {
                [self.delegate passwordView:self didFinishInput:password];
            }
        }
    }
    self.passwordInputView.inputCount = self.passwordNumberS.count;
}

/** 删除按钮点击 */
- (void)randomKeyboardDeleteButtonClick:(XLRandomKeyboard *)keyboard
{
    [self.passwordNumberS removeLastObject];
    self.passwordInputView.inputCount = self.passwordNumberS.count;
}

/** 确定按钮点击 */
- (void)randomKeyboardOKButtonClick:(XLRandomKeyboard *)keyboard
{
    [self hidePasswordView];
}

#pragma mark    -   UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
        }
            break;
        case 1:
        {
            [self hidePasswordView];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark    -   public method

+ (instancetype)passwordView
{
    XLPasswordView *password = [[self alloc] init];
    return password;
}

/**
 *  展示
 *
 *  @param view 添加到的目的视图
 */
- (void)showPasswordInView:(UIView *)view
{
    self.frame = XLKeyWindow.bounds;
    if (view == nil) {
        [XLKeyWindow addSubview:self];
    } else {
        [view addSubview:self];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.4;
        self.inputContainerView.xl_y = XLScreenH - self.inputContainerView.xl_height;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  隐藏
 */
- (void)hidePasswordView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundView.alpha = 0.0;
        self.inputContainerView.xl_y = XLScreenH;
    } completion:^(BOOL finished) {
        self.backgroundView = nil;
        [self removeFromSuperview];
    }];
}

/**
 *  清除
 */
- (void)clearPassword
{
    [self.passwordInputView clearPassword];
}

@end
