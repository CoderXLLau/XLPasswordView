//
//  UIImage+XLPasswordView.m
//  XLPasswordView
//
//  Created by Liushannoon on 16/7/11.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "UIImage+XLPasswordView.h"

@implementation UIImage (XLPasswordView)

/**
 *  返回一张密码输入框网格图片
 *
 *  @param gridCount 网格数
 *  @param gridLineColor 网格线颜色
 *  @param gridLineWidth 网格线宽度
 *
 *  @return 网格图片
 */
+ (instancetype)xl_passwordInputGridImageWithGridCount:(NSInteger)gridCount gridLineColor:(UIColor *)gridLineColor gridLineWidth:(CGFloat)gridLineWidth
{
    CGFloat gridWidth = 54;
    CGSize size = CGSizeMake(gridWidth * gridCount, gridWidth);
    
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    // 获取图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 画外边框
    CGFloat marginFix = gridLineWidth * 0.5;
    CGContextMoveToPoint(context, marginFix, marginFix);
    CGContextAddLineToPoint(context, size.width - marginFix, marginFix);
    CGContextAddLineToPoint(context, size.width - marginFix, size.height - marginFix);
    CGContextAddLineToPoint(context, marginFix, size.height - marginFix);
    CGContextAddLineToPoint(context, marginFix, marginFix);
    // 画内边框
    for (int i = 1 ; i < gridCount; i ++) {
        CGContextMoveToPoint(context, i * gridWidth, 0);
        CGContextAddLineToPoint(context, i * gridWidth, gridWidth);
    }
    
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    // 设置线条颜色
    [gridLineColor setStroke];
    //设置线条宽度
    CGContextSetLineWidth(context, gridLineWidth);
    //设置连接样式,,,必须要连接在一起的，首位相接的，第二条线的起点不是你用CGContextMoveToPoint自己写的，才有用
    CGContextSetLineJoin(context, kCGLineJoinBevel );
    //设置顶角样式
    CGContextSetLineCap(context, kCGLineCapRound);
    //渲染，线段，图片用rect,后边的参数是渲染方式kCGPathFillStroke,表示既有边框，又有填充；kCGPathFill只填充
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //获取图片
    UIImage *gridImage = UIGraphicsGetImageFromCurrentImageContext();
    //关闭位图
    UIGraphicsEndImageContext();
    
    return gridImage;
}

/**
 *  返回一张指定size的指定颜色的圆形拉伸保护的纯色图片
 */
+ (UIImage *)xl_circleAndStretchableImageWithColor:(UIColor *)color size:(CGSize)size
{
    if (size.width <= 1) {
        size.width = 100;
        size.height = 100;
    }
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    //获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //添加一个椭圆，第一个参数是在那个上下文上面添加，，，第二个参数是设定一个矩形框，这个椭圆会”填充“这个矩形框，如果这个矩形框是正方形，那么就是圆
    CGRect rect =CGRectMake(0, 0, size.width, size.height);
    CGContextAddEllipseInRect(context,rect);
    CGContextClip(context);
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    // 裁剪
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    ;
}

@end
