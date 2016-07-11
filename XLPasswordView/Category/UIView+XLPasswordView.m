//
//  UIView+XLPasswordView.m
//  XLPasswordView
//
//  Created by Liushannoon on 16/7/11.
//  Copyright © 2016年 LiuShannoon. All rights reserved.
//

#import "UIView+XLPasswordView.h"

@implementation UIView (XLPasswordView)

- (CGSize)xl_size
{
    return self.frame.size;
}

- (void)setXl_size:(CGSize)xl_size
{
    CGRect frame = self.frame;
    frame.size = xl_size;
    self.frame = frame;
}

- (CGFloat)xl_width
{
    return self.frame.size.width;
}

- (void)setXl_width:(CGFloat)xl_width
{
    CGRect rect = self.frame;
    rect.size.width = xl_width;
    self.frame = rect;
}

- (CGFloat)xl_height
{
    return self.frame.size.height;
}

- (void)setXl_height:(CGFloat)xl_height
{
    CGRect rect = self.frame;
    rect.size.height = xl_height;
    self.frame = rect;
}

- (CGFloat)xl_x
{
    return self.frame.origin.x;
}

- (void)setXl_x:(CGFloat)xl_x
{
    CGRect rect = self.frame;
    rect.origin.x = xl_x;
    self.frame = rect;
}

- (CGFloat)xl_y
{
    return self.frame.origin.y;
}

- (void)setXl_y:(CGFloat)xl_y
{
    CGRect rect = self.frame;
    rect.origin.y = xl_y;
    self.frame = rect;
}

- (CGFloat)xl_centerX
{
    return self.center.x;
}

- (void)setXl_centerX:(CGFloat)xl_centerX
{
    CGPoint point = self.center;
    point.x = xl_centerX;
    self.center = point;
}

- (CGFloat)xl_centerY
{
    return self.center.y;
}

- (void)setXl_centerY:(CGFloat)xl_centerY
{
    CGPoint point = self.center;
    point.y = xl_centerY;
    self.center = point;
}

@end
