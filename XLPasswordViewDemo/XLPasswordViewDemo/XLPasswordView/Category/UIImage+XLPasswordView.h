//
//  UIImage+XLPasswordView.h
//  XLPasswordView
//
//  Created by Liushannoon on 16/7/11.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XLPasswordView)

/**
 *  返回一张密码输入框网格图片
 *
 *  @param gridCount 网格数
 *  @param gridLineColor 网格线颜色
 *  @param gridLineWidth 网格线宽度
 *
 *  @return 网格图片
 */
+ (instancetype)xl_passwordInputGridImageWithGridCount:(NSInteger)gridCount gridLineColor:(UIColor *)gridLineColor gridLineWidth:(CGFloat)gridLineWidth;
/**
 *  返回一张指定size的指定颜色的圆形拉伸保护的纯色图片
 */
+ (instancetype)xl_circleAndStretchableImageWithColor:(UIColor *)color size:(CGSize)size;

@end
