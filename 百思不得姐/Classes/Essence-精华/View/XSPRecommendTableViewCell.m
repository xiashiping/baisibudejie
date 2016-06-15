//
//  XSPRecommendTableViewCell.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/6/3.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPRecommendTableViewCell.h"
#import "XSPRecommendModle.h"
#import "UIImageView+WebCache.h"

@interface XSPRecommendTableViewCell ()

@property (strong, nonatomic) IBOutlet UIImageView *heardImg;
@property (strong, nonatomic) IBOutlet UILabel *theme_nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *subLabel;


@end

@implementation XSPRecommendTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.heardImg.layer.cornerRadius = self.heardImg.width/2;
    self.heardImg.layer.masksToBounds = YES;
}

- (void)setRecommendTag:(XSPRecommendModle *)RecommendTag
{
    _RecommendTag = RecommendTag;
    [self.heardImg sd_setImageWithURL:[NSURL URLWithString:RecommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.theme_nameLabel.text = RecommendTag.theme_name;
    NSString *subNumber = nil;
    if (RecommendTag.sub_number < 10000)
    {
        subNumber = [NSString stringWithFormat:@"%ld",RecommendTag.sub_number];
    }
    else
    {
        subNumber = [NSString stringWithFormat:@"%1.f万",RecommendTag.sub_number / 10000.0];
    }
    self.subLabel.text = subNumber;
}


//重写setFrame
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 5;
    frame.size.width -= 2 * frame.origin.x;  //tableview两侧的空隙
    frame.size.height -= 1; //设置cell的分隔线
    [super setFrame:frame];
}

@end
