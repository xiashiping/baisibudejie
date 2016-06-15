//
//  XSPTabBar.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/28.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPTabBar.h"


@interface XSPTabBar ()

@property (nonatomic, weak)UIButton *publishButton;

@end

@implementation XSPTabBar



- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        //设置TabBar的背景
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    //设置按钮的frame
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
//    设置其他UITabBarButton的frame
        CGFloat btnY = 0;
        CGFloat btnW = width / 5;
        CGFloat btnH = height;
        NSInteger index = 0;
        for (UIView *btn in self.subviews)
        {
            if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
            {
                CGFloat btnX = btnW * ((index > 1)?(index + 1):index);
                btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            }
            index++;
        }
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
