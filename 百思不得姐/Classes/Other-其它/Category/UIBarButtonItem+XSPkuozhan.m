//
//  UIBarButtonItem+XSPkuozhan.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/29.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "UIBarButtonItem+XSPkuozhan.h"

@implementation UIBarButtonItem (XSPkuozhan)

+ (instancetype)ItemWithImage:(NSString *)image HighlightImage:(NSString *)HighlightImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:HighlightImage] forState:UIControlStateHighlighted];
    btn.size = btn.currentBackgroundImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
