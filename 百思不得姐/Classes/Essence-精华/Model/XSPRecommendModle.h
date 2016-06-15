//
//  XSPRecommendModle.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/3.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSPRecommendModle : NSObject

//图片
@property (nonatomic,copy)NSString *image_list;

//名字
@property (nonatomic,copy)NSString *theme_name;

//订阅数
@property (nonatomic,assign)NSInteger sub_number;
@end
