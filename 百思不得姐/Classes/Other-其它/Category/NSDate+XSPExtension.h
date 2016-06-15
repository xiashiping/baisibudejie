//
//  NSDate+XSPExtension.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/12.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XSPExtension)

//比较from和self的时间差值
- (NSDateComponents *)deltaFrom:(NSDate *)from;

//是否是今年
- (BOOL)isThisYear;

//是否是今天
- (BOOL)isToday;

//是否是昨天
- (BOOL)isYesterday;
@end
