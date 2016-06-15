//
//  XSPrecommend.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/30.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPrecommend.h"
#import <MJExtension/MJExtension.h>
@implementation XSPrecommend

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id"
             };
}


//懒加载
- (NSMutableArray *)users
{
    if (_users == nil)
    {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
