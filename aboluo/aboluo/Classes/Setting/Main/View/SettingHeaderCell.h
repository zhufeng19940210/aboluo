//  SettingHeaderCell.h
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,SettingHeaderType) {
    SettingHeaderTypeIcon     = 1000,//头像Btn
    SettingHeaderTypeCode     = 2000,//二维码Btn
    SettingHeaderTypeMine     = 3000,//个人中心Btn
    SettingHeaderTypeHuan     = 4000,//其他Btn
};
@interface SettingHeaderCell :
UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *right_btn;
@property (weak, nonatomic) IBOutlet UIButton *left_btn;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *level_lab;
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UIImageView *setting_bg;
@property (nonatomic,copy)void(^actionBlock)(SettingHeaderType type);
@end
