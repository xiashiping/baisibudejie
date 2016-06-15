//
//  XSPTopicCell.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/10.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPTopicCell.h"
#import "XSPTopic.h"
#import "UIImageView+WebCache.h"
#import "XSPTopicPictureView.h"

@interface XSPTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
//昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//时间
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
//顶
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
//踩
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
//分享
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
//评论
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

//新浪加v
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

//帖子的文字内容
@property (weak, nonatomic) IBOutlet UILabel *text_Label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak)XSPTopicPictureView *PictureView;

@end

@implementation XSPTopicCell

- (XSPTopicPictureView *)PictureView
{
    if (!_PictureView)
    {
        XSPTopicPictureView *pictureView = [XSPTopicPictureView pictureView];
        NSLog(@"%@",[XSPTopicPictureView pictureView]);
        [self.contentView addSubview:pictureView];
        _PictureView = pictureView;
    }
    return _PictureView;
}

- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}


/**
  * 今年
  * 今天
  * 1分钟内
  * 刚刚
  * 1小时内
  * xx分钟前
  * 其他
  * xx小时前
 昨天
 昨天 18:56:34
 其他
 06-23 19:56:23
 
 非今年
 2014-05-08 18:45:30
 */

- (void)setTopic:(XSPTopic *)topic
{
    _topic = topic;
    
    //新浪加V(不是新浪会员就隐藏)
    self.sinaVView.hidden = !topic.isSina_v;
    //设置其他控件（设置头像）
    [self.profileImgView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //设置昵称
    self.nameLabel.text = topic.name;
    
    //设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    
    self.PictureView.topic = topic;
    
    //设置按钮文字
    [self SetupButtonTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self SetupButtonTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self SetupButtonTitle:self.shareBtn count:topic.repost placeholder:@"分享"];
    [self SetupButtonTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    
    //设置帖子的文字内容
    self.text_Label.text = topic.text;
    
    //根据模型类型（帖子类型）添加对应的内容到cell的中间
    if (topic.type == XSPtopicTypePicture)//图片帖子
    {
        self.PictureView.topic = topic;
        self.PictureView.frame = topic.pictureViewFrame;
    }
}


//一些时间格式（与此无关）
- (void)testDate:(NSString *)create_time
{
    //日期格式化类(1)
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //当前时间
    NSDate *now = [NSDate date];
    
    //发帖时间
    NSDate *create = [fmt dateFromString:create_time];
    XSPLog(@"%@",[now deltaFrom:create]);  //比较时间的差值
    
    //日历
//    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //比较时间
//    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *cmps = [calendar components:unit fromDate:create toDate:now options:0];
//    XSPLog(@"%@ %@",create,now);
//    XSPLog(@"%zd %zd %zd %zd %zd %zd",cmps.year,cmps.month,cmps.day,cmps.hour,cmps.minute,cmps.second);
//
    //获得NSDate的每一个元素(2)
//    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
//    NSInteger month = [calendar component:NSCalendarUnitWeekOfMonth fromDate:now];
//    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
//    XSPLog(@"%zd %zd %zd",year,month,day);
    
    //获取当前时间(3)
//    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:now];
//    XSPLog(@"%zd %zd %zd",cmps.year,cmps.month,cmps.day);
}


/** 设置底部按钮文字 */
- (void)SetupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    NSString *title = nil;
    
    
    if (count > 10000)
    {
        title = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }
    else
    {
        title = [NSString stringWithFormat:@"%zd",count];
    }
    [button setTitle:title forState:UIControlStateNormal];
}

//cell的间距
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = XSPTopicCellMargin;
    frame.size.width -= 2 * XSPTopicCellMargin;
    frame.size.height -= XSPTopicCellMargin;
    frame.origin.y += XSPTopicCellMargin;
    [super setFrame:frame];
}
@end
