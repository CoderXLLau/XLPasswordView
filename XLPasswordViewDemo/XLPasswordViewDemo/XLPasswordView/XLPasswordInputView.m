//
//  XLPasswordInputView.m
//  TopHot
//
//  Created by Liushannoon on 16/6/29.
//  Copyright © 2016年 Liushannoon. All rights reserved.
//

#import "XLPasswordInputView.h"
#import "UIView+XLPasswordView.h"
#import "UIImage+XLPasswordView.h"

@interface XLPasswordInputView ()

/**
 * 密码框图片
 */
@property (nonatomic , weak) UIImageView *backgroundImageView;
/**
 *  底部的输入框,用来响应用户点击弹出键盘
 */
@property (nonatomic , weak) UITextField *textField;
/**
 *  小圆点图片数组
 */
@property (nonatomic , strong) NSArray  *dotsArray;
/**
 *  每个密码字符占用的label数组
 */
@property (nonatomic , strong) NSArray  *labelsArray;


@end

@implementation XLPasswordInputView

#pragma mark    -   set / get

- (NSString *)password
{
    return self.textField.text;
}

/**
 *  懒加载成员属性
 */
- (NSArray *)dotsArray
{
    if (_dotsArray == nil) {
        NSMutableArray *dotsArray = [NSMutableArray array];
        for (int i = 0 ; i < _passwordLength; i ++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [UIImage xl_circleAndStretchableImageWithColor:self.dotColor size:CGSizeMake(self.dotWidth, self.dotWidth)];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:imageView];
            [dotsArray addObject:imageView];
            imageView.hidden = YES;
        }
        _dotsArray = dotsArray;
    }
    
    return _dotsArray;
}

/**
 *  懒加载成员属性
 */
- (NSArray *)labelsArray
{
    if (_labelsArray == nil) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.passwordLength];
        for ( int i = 0 ; i < self.passwordLength; i ++ ) {
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = @"";
            titleLabel.numberOfLines = 1;
            titleLabel.textColor = self.textColor;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = self.font;
            titleLabel.hidden = YES;
            [self addSubview:titleLabel];
            [array addObject:titleLabel];
        }
        _labelsArray = array;
    }
    
    return _labelsArray;
}

/**
 *  在这里控制圆点的隐藏和显示
 *
 *  @param inputCount 当前用户输入的密码个数
 */
- (void)setInputCount:(NSInteger)inputCount
{
    inputCount = (inputCount > _passwordLength) ? _passwordLength : inputCount;
    _inputCount = inputCount;
    if (self.isSecureTextEntry) {
        for ( int i = 0 ; i < inputCount; i ++) {
            UIImageView *dotImageView = self.dotsArray[i];
            dotImageView.hidden = NO;
        }
        for (NSInteger i = inputCount; i < self.dotsArray.count; i ++) {
            UIImageView *dotImageView = self.dotsArray[i];
            dotImageView.hidden = YES;
        }
        
        for (int i = 0 ; i < self.labelsArray.count; i ++) {
            UILabel *label = self.labelsArray[i];
            label.hidden = YES;
        }
    } else {
        NSString *password = self.textField.text;
        for ( int i = 0 ; i < inputCount; i ++) {
            UILabel *label = self.labelsArray[i];
            label.text = [password substringWithRange:NSMakeRange(i, 1)];
            [label sizeToFit];
            label.hidden = NO;
        }
        for (NSInteger i = inputCount; i < self.dotsArray.count; i ++) {
            UILabel *label = self.labelsArray[i];
            label.text = nil;
            label.hidden = YES;
        }
        for (int i = 0 ; i < self.dotsArray.count; i ++) {
            UIImageView *imageView = self.dotsArray[i];
            imageView.hidden = YES;
        }
    }
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    self.inputCount = self.inputCount;
}

- (void)setPasswordLength:(NSUInteger)passwordLength
{
    _passwordLength  = passwordLength;
    [self refreshUI];
}

- (void)setGridLineColor:(UIColor *)gridLineColor
{
    _gridLineColor = gridLineColor;
    [self refreshUI];
}

- (void)setGridLineWidth:(CGFloat)gridLineWidth
{
    _gridLineWidth = gridLineWidth;
    [self refreshUI];
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    [self refreshUI];
}

- (void)setDotWidth:(CGFloat)dotWidth
{
    _dotWidth = dotWidth;
    [self refreshUI];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self refreshUI];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self refreshUI];
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
    _passwordLength = 6;
    _gridLineWidth = 1.0f;
    _gridLineColor = [UIColor purpleColor];
    _dotWidth = 12.0f;
    _dotColor = [UIColor purpleColor];
    _secureTextEntry = YES;
    _inputCount = 0;
    _font = [UIFont systemFontOfSize:15];
    _textColor = [UIColor blackColor];
    
    UITextField *textField = [[UITextField alloc] init];
    [self addSubview:textField];
    self.textField = textField;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    textField.tintColor = [UIColor clearColor];
    textField.textColor = [UIColor clearColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    self.backgroundImageView = imageView;
    [self addSubview:imageView];
    
    [self refreshUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageWidth = self.dotWidth;
    CGFloat imageHeight = self.dotWidth;
    CGFloat gridWidth = self.xl_width / self.passwordLength ;
    for (int i = 0 ; i < self.dotsArray.count; i ++) {
        UIImageView *imageView = self.dotsArray[i];
        imageView.xl_width = imageWidth;
        imageView.xl_height = imageHeight;
        imageView.xl_centerY = self.xl_height * 0.5;
        imageView.xl_centerX = gridWidth * 0.5 + i * gridWidth;
    }
    for (int i = 0 ; i < self.labelsArray.count; i ++) {
        UILabel *label = self.labelsArray[i];
        label.xl_width = imageWidth;
        label.xl_height = imageHeight;
        label.xl_centerY = self.xl_height * 0.5;
        label.xl_centerX = gridWidth * 0.5 + i * gridWidth;
    }
    self.textField.frame = self.bounds;
    self.backgroundImageView.frame = self.bounds;
}

#pragma mark - 文本框内容改变

- (void)textChange:(UITextField *)textField {
    NSString *text = textField.text;
    if (text.length > _passwordLength) {
        //substringToIndex,index从0开始, 不包含最后index所指的那个字符,在这里接到的子串不包含6所指的字符
        text = [text substringToIndex:_passwordLength];
        textField.text = text;
    }
    // 刷新位数
    self.inputCount = textField.text.length;
    
    if (self.passwordBlock) {
        self.passwordBlock(text);
    }
    
    if ([self.delegate respondsToSelector:@selector(passwordInputView:inputPassword:)]) {
        [self.delegate passwordInputView:self inputPassword:self.password];
    }
}

#pragma mark    -   public method

/**
 *  快速创建对象,
 *
 *  @param passwordLength 密码长度,默认6位
 *
 *  @return XLPasswordInputView实例对象
 */
+ (instancetype)passwordInputViewWithPasswordLength:(NSInteger)passwordLength;
{
    XLPasswordInputView *passwordInputView = [[self alloc] init];
    passwordInputView.passwordLength = passwordLength;
    
    return passwordInputView;
}

/**
 *  清空密码,重置
 */
- (void)clearPassword
{
    self.textField.text = nil;
    self.inputCount = 0;
}

#pragma mark    -   private method

/**
 *  刷新UI
 */
- (void)refreshUI
{
    [self.dotsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.dotsArray = nil;
    [self.labelsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.labelsArray = nil;
    self.backgroundImageView.image = [UIImage xl_passwordInputGridImageWithGridCount:self.passwordLength gridLineColor:self.gridLineColor gridLineWidth:self.gridLineWidth];
    [self dotsArray];
    [self labelsArray];
    
    self.inputCount = self.inputCount;
    [self textChange:self.textField];
}

@end
