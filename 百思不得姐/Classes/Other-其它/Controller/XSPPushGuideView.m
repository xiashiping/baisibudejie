//
//  XSPPushGuideView.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/6.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPPushGuideView.h"

@implementation XSPPushGuideView

+(void)show
{
//    XSPLog(@"%@",[NSBundle mainBundle].infoDictionary);//获取版本号
    
    NSString *key = @"CFBundleShortVersionString";
    //获取当前软件版本号
    NSString *curentVersion = [NSBundle mainBundle].infoDictionary[key];
    //获取沙盒存储的版本号
    NSString *saboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    if (![curentVersion isEqualToString:saboxVersion])
    {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
            XSPPushGuideView *guideView = [XSPPushGuideView GuideView];
            guideView.frame = window.bounds;
            [window addSubview:guideView];
        
        //存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:curentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(instancetype)GuideView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)knowBtn
{
    [self removeFromSuperview];
}

@end
