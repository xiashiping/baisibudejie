//
//  XSPleftTableViewCell.m
//  百思不得姐
//
//  Created by 夏世萍 on 16/5/30.
//  Copyright © 2016年 夏世萍. All rights reserved.
//

#import "XSPleftTableViewCell.h"
#import "XSPrecommend.h"

@interface XSPleftTableViewCell ()

@property (strong, nonatomic) IBOutlet UIView *seleced;


@end

@implementation XSPleftTableViewCell

- (void)awakeFromNib {
    
    self.backgroundColor = XSPBGColor(244, 244, 244);
    self.seleced.backgroundColor = XSPBGColor(219, 21, 26);
   
    /*
    //设置左tableview的背景颜色
    self.backgroundColor = XSPBGColor(244, 244, 244);
    //设置左tableview的字体颜色(默认：灰色  高亮：红色)
    self.textLabel.textColor = XSPBGColor(78, 78, 78);
    self.textLabel.highlightedTextColor = XSPBGColor(219, 21, 26);
    
    //去掉选中时的背景颜色
    UIView *bgview = [[UIView alloc] init];
    bgview.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = bgview;
     */
}

- (void)setCategory:(XSPrecommend *)category
{
    _category = category;
    self.textLabel.text = category.name;
}


- (void)layoutSubviews
{
    //系统自带的label，设置左tableview的分隔线
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.seleced.hidden = !selected;
    self.textLabel.textColor = selected ? self.seleced.backgroundColor : XSPBGColor(78, 78, 78);
}

@end
