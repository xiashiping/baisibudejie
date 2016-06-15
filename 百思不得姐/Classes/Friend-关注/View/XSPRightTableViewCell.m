//
//  XSPRightTableViewCell.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/31.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPRightTableViewCell.h"
#import "XSPRightPrecemmend.h"
#import "UIImageView+WebCache.h"

@interface XSPRightTableViewCell ()
@property (strong, nonatomic) IBOutlet UIImageView *headimage;

@property (strong, nonatomic) IBOutlet UILabel *screen_nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *fan_countLabel;

@end

@implementation XSPRightTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(XSPRightPrecemmend *)user
{
    _user = user;
    self.screen_nameLabel.text = user.screen_name;
    
    NSString *FanNumber = nil;
    if (user.fans_count < 10000)
    {
        FanNumber = [NSString stringWithFormat:@"%ld",user.fans_count];
    }
    else
    {
        FanNumber = [NSString stringWithFormat:@"%.1f万",user.fans_count / 10000.0];
    }
    self.fan_countLabel.text = FanNumber;
    
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
