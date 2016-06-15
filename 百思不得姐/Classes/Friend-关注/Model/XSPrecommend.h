//
//  XSPrecommend.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/30.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSPrecommend : NSObject

//id
@property (nonatomic, assign)NSInteger ID;

//总数
@property (nonatomic, assign)NSInteger count;

//名字
@property (nonatomic, copy)NSString *name;

//这个类别对应的用户数据 (避免重复发送请求)
@property (nonatomic, strong)NSMutableArray *users;

//总页数
@property (nonatomic, assign)NSInteger total_page;
//总数
@property (nonatomic, assign)NSInteger total;
//当前页码
@property (nonatomic, assign)NSInteger currentPage;


@end
