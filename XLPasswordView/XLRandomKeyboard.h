//
//  XLRandomKeyboard.h
//  XLPasswordView
//
//  Created by Liushannoon on 16/6/29.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

/**
 *  随机键盘
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+XLPasswordView.h"

@class XLRandomKeyboard;

static NSString *XLRandomKeyboardDeleteButtonClick = @"XLRandomKeyboardDeleteButtonClick";
static NSString *XLRandomKeyboardOkButtonClick = @"XLRandomKeyboardOkButtonClick";
static NSString *XLRandomKeyboardNumberButtonClick = @"XLRandomKeyboardNumberButtonClick";
static NSString *XLRandomKeyboardNumberKey = @"XLRandomKeyboardNumberKey";

@protocol XLRandomKeyboardDelegate <NSObject>

@optional

/** 数字按钮点击 */
- (void)randomKeyboard:(XLRandomKeyboard *)keyboard clickButtonNumber:(NSString *)number;
/** 删除按钮点击 */
- (void)randomKeyboardDeleteButtonClick:(XLRandomKeyboard *)keyboard;
/** 确定按钮点击 */
- (void)randomKeyboardOKButtonClick:(XLRandomKeyboard *)keyboard;

@end

@interface XLRandomKeyboard : UIView

@property (nonatomic, weak) id<XLRandomKeyboardDelegate> delegate;

@end