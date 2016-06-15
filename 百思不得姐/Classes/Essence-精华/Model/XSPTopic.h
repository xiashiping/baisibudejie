//
//  XSPTopic.h
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSPTopic : NSObject
//名称
@property (copy, nonatomic) NSString *name;
//头像的URL
@property (copy, nonatomic) NSString *profile_image;
//发帖时间
@property (copy, nonatomic) NSString *create_time;
//文字内容
@property (copy, nonatomic) NSString *text;
//顶的数量
@property (assign, nonatomic) NSInteger ding;
//踩的数量
@property (assign, nonatomic) NSInteger cai;
//转发的数量
@property (assign, nonatomic) NSInteger repost;
//评论的数量
@property (assign, nonatomic) NSInteger comment;
//是否为新浪加V用户
@property (assign, nonatomic,getter=isSina_v) BOOL *sina_v;
/** 图片的宽度 */
@property (assign, nonatomic) CGFloat width;
/** 图片的高度 */
@property (assign, nonatomic) CGFloat height;
/** 小图片的URL */
@property (copy, nonatomic) NSString *small_image;
/** 中图片的URL */
@property (copy, nonatomic) NSString *middle_image;
/** 大图片的URL */
@property (copy, nonatomic) NSString *large_image;


/** 帖子类型 (交给子类去实现)*/
@property (assign, nonatomic) XSPTopicType type;


/** 额外的辅助属性 */
/** cell的高度 */
@property (assign, nonatomic,readonly) CGFloat cellHeight;

/** 图片控件的frame */
@property (assign, nonatomic,readonly) CGRect pictureViewFrame;
/** 图片是否太大 */
@property (assign, nonatomic,getter=isBigPictuer)BOOL bigPicture;
@end
