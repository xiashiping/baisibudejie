//
//  XSPTopicPictureView.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/14.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

//图片中间的那块内容（继承制UIview）

#import <UIKit/UIKit.h>

@class XSPTopic;
@interface XSPTopicPictureView : UIView

+ (instancetype)pictureView;

//帖子数据
@property (strong, nonatomic) XSPTopic *topic;

@end
