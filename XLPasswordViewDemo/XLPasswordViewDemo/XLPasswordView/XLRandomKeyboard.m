//
//  XLRandomKeyboard.m
//  XLPasswordView
//
//  Created by Liushannoon on 16/6/29.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "XLRandomKeyboard.h"

@interface XLRandomKeyboard ()

/**
 *  存放所有的按钮数组
 */
@property (nonatomic , strong) NSMutableArray  *numberButtons;
/**
 *  随机键盘数组
 */
@property (nonatomic , strong) NSMutableArray  *randomNumbers;

@end

@implementation XLRandomKeyboard

#pragma mark    -   懒加载

/**
 *  懒加载成员属性
 */
- (NSMutableArray *)numberButtons
{
    if (_numberButtons == nil) {
        _numberButtons = [NSMutableArray array];
    }
    
    return _numberButtons;
}

/**
 *  懒加载成员属性
 */
- (NSMutableArray *)randomNumbers
{
    if (_randomNumbers == nil) {
        NSMutableArray *randomNumbers = [NSMutableArray array];
        NSMutableArray *orderNumbers = [NSMutableArray array];
        for ( int i  = 0 ; i < 10; i ++) {
            NSString *number = [NSString stringWithFormat:@"%zd",i];
            [orderNumbers addObject:number];
        }
        for (int i = 0 ; i < 10 ; i ++) {
            int index = arc4random_uniform(10 - i);
            [randomNumbers addObject:orderNumbers[index]];
            [orderNumbers removeObjectAtIndex:index];
        }
        _randomNumbers = randomNumbers;
    }
    
    return _randomNumbers;
}

#pragma mark    -   initialUI

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
    self.backgroundColor = [UIColor whiteColor];
    /** 添加所有按键 */
    [self setUpAllButtons];
}

- (void)setUpAllButtons
{
    for (int i = 0; i < 12; i++) {
        // 创建按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn setBackgroundImage:[UIImage imageNamed:@"XLPasswordView.bundle/number_bg"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        if (i == 9) {  // 确定按钮
            [btn setTitle:@"隐藏" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 11) {  // 删除按钮
            [btn setTitle:@"删除" forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            [btn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 10) {  // 删除和确定中间的按钮
            
            NSString *number = [self.randomNumbers lastObject];
            [btn setTitle:number forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = [number integerValue];
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.numberButtons addObject:btn];
        } else {  // 其他数字按钮
            NSString *number = self.randomNumbers[i];
            [btn setTitle:number forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = [number integerValue];
            [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.numberButtons addObject:btn];
        }
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 定义总列数
    NSInteger totalCol = 3;
    
    // 定义间距
    CGFloat pad = 3.0;
    
    // 定义x y w h
    CGFloat x;
    CGFloat y;
    CGFloat w = (XLScreenW - 4 * pad) / totalCol;
    CGFloat h = (self.xl_height - 5 * pad) / 4.0;
    
    // 列数 行数
    NSInteger row;
    NSInteger col;
    for (int i = 0; i < 12; i++) {
        row = i / totalCol;
        col = i % totalCol;
        x = pad + col * (w + pad);
        y = row * (h + pad) + pad;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

#pragma mark - Private

/** 删除按钮点击 */
- (void)deleteBtnClick
{
    if ([self.delegate respondsToSelector:@selector(randomKeyboardDeleteButtonClick:)]) {
        [self.delegate randomKeyboardDeleteButtonClick:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XLRandomKeyboardDeleteButtonClick object:self];
}

/** 确定按钮点击 */
- (void)okBtnClick
{
    if ([self.delegate respondsToSelector:@selector(randomKeyboardOKButtonClick:)]) {
        [self.delegate randomKeyboardOKButtonClick:self];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:XLRandomKeyboardOkButtonClick object:self];
}

/** 数字按钮点击 */
- (void)numBtnClick:(UIButton *)numBtn
{
    NSString *number = numBtn.titleLabel.text;
    if ([self.delegate respondsToSelector:@selector(randomKeyboard:clickButtonNumber:)]) {
        [self.delegate randomKeyboard:self clickButtonNumber:number];
    }
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[XLRandomKeyboardNumberKey] = number;
    [[NSNotificationCenter defaultCenter] postNotificationName:XLRandomKeyboardNumberButtonClick object:self userInfo:userInfo];
}

@end
