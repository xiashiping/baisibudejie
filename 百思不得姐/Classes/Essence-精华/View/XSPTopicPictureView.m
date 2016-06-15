//
//  XSPTopicPictureView.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/14.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPTopicPictureView.h"
#import "XSPTopic.h"
#import "UIImageView+WebCache.h"
#import "DALabeledCircularProgressView.h"
#import "XSPShowPictureViewController.h"

@interface XSPTopicPictureView ()
/** GIF标识 */
@property (weak, nonatomic) IBOutlet UIImageView *GifImgView;
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigimgview;

@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end

@implementation XSPTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    self.progressView.roundedCorners = 2;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //给图片添加监听器
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}

- (void)showPicture
{
    XSPShowPictureViewController *showPicture = [[XSPShowPictureViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setTopic:(XSPTopic *)topic
{
    _topic = topic;
    
    /**
     * 在不知道图片扩展名的情况下，如何知道图片的真实类型？
     * 取出图片数据的第一个字节，就可以判断出图片的真实类型
     */
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:YES];
        self.progressView.progressLabel.text = [NSString stringWithFormat:@"%.f%%",progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
    
    //判断是否为gif图片
    //pathExtension:拿到文件路径的扩展名
    NSString *extension = topic.large_image.pathExtension;
    self.GifImgView.hidden = [extension isEqualToString:@"gif"];
    
    //判断是否显示"点击查看全图"按钮
    if (topic.isBigPictuer)
    {
        self.seeBigimgview.hidden = NO;  //是大图的时候就显示点击查看全图按钮
        self.imageView.contentMode = UIViewContentModeScaleAspectFill; // 按原比例伸缩
    }
    else
    {
        self.seeBigimgview.hidden = YES; //不是大图，就隐藏
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
