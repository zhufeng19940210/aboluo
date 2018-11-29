//  HomeExamCell.m
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeExamCell.h"
@interface HomeExamCell()
@property (weak, nonatomic) IBOutlet UILabel *content_lab;
@property (weak, nonatomic) IBOutlet UIButton *a_btn;
@property (weak, nonatomic) IBOutlet UIButton *b_btn;
@property (weak, nonatomic) IBOutlet UIButton *c_btn;
@property (weak, nonatomic) IBOutlet UIButton *d_btn;
@end

@implementation HomeExamCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (instancetype)HomecellWithTableView:(UITableView *)tableView{
    HomeExamCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}

/**
 选择选项的功能设置
 @param sender 选择功能的选项
 */
- (IBAction)actionSelectTypeBtn:(UIButton *)sender
{
    
}

-(void)setExammodel:(ExamModel *)exammodel
{
    _exammodel = exammodel;
}
@end
