//
//  UIView+XLPasswordView.h
//  XLPasswordView
//
//  Created by Liushannoon on 16/7/11.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XLScreenBounds [UIScreen mainScreen].bounds
#define XLScreenSize [UIScreen mainScreen].bounds.size
#define XLScreenW [UIScreen mainScreen].bounds.size.width
#define XLScreenH [UIScreen mainScreen].bounds.size.height
#define xl_autoSizeScaleX ([UIScreen mainScreen].bounds.size.width / 375)
#define xl_autoSizeScaleY ([UIScreen mainScreen].bounds.size.height / 667)
#define XLKeyWindow [UIApplication sharedApplication].windows.firstObject

@interface UIView (XLPasswordView)

@property (nonatomic, assign) CGFloat xl_height;
@property (nonatomic, assign) CGFloat xl_width;
@property (nonatomic, assign) CGFloat xl_x;
@property (nonatomic, assign) CGFloat xl_y;
@property (nonatomic, assign) CGSize xl_size;
@property (nonatomic, assign) CGFloat xl_centerX;
@property (nonatomic, assign) CGFloat xl_centerY;

@end
