//
//  XSPTopic.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPTopic.h"
#import <MJExtension/MJExtension.h>

@implementation XSPTopic
{
    CGFloat _cellHeight;
    CGRect _pictureViewFrame;
}

//设置模型属性名和字典key之间的映射关系
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             };
}


- (NSString *)create_time
{
    //日期格式类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期格式（y:年,M:月,d:日,H时,m:分,s:秒）
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];//（NSString转NSDate类型）
    
    if (create.isThisYear) //今年
    {
        if (create.isToday) //今天
        {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            if (cmps.hour >= 1) //时间差距 >= 1小时
            {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }
            else if (cmps.minute >= 1)//1小时 > 时间差距 >= 1分钟
            {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }
            else // 1分钟 > 时间差距
            {
                return @"刚刚";
            }
        }
        else if (create.isYesterday) //昨天
        {
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        else //其他
        {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }
    else //非今年
    {
        return _create_time;
    }
}

- (CGFloat )cellHeight
{
    if (!_cellHeight)
    {
//        XSPLog(@"\nbeigin-----\n%@\n%@\n%@\nend---",self.small_image,self.middle_image,self.large_image);
        
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * XSPTopicCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell的高度
        //文字部分的高度
        _cellHeight = XSPTopicCellTextY + textH + XSPTopicCellMargin;
        
        //根据段子的类型来计算cell的高度
        if (self.type == XSPtopicTypePicture) //图片
        {
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            if (pictureH >= XSPTopicCellPictureMaxH) //图片高度过长
            {
                pictureH = XSPTopicPictureBreakH;
                self.bigPicture = YES;  //表示是大图
            }
            
            //计算图片控件的frame
            CGFloat pictureX = XSPTopicCellMargin;
            CGFloat pictureY = XSPTopicCellTextY + textH + XSPTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
           
            _cellHeight += pictureH + XSPTopicCellMargin;

        }
        //底部工具条的高度
        _cellHeight += XSPTopicCellBottomBarH + XSPTopicCellMargin;
    }
    
    return _cellHeight;
}

@end
