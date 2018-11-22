//  HomeExamVC.m
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeExamVC.h"
@interface HomeExamVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *type_lab;
@property (nonatomic,strong)NSMutableArray *examArray;
@end
@implementation HomeExamVC
-(NSMutableArray *)examArray
{
    if (!_examArray) {
        _examArray = [NSMutableArray array];
    }
    return _examArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"等级考试区";
    [self setptableview];
}

-(void)setptableview
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
}
/**
 提交考试
 @param sender 提交考试
 */
- (IBAction)actionCommintBtn:(UIButton *)sender
{
    
}
@end
