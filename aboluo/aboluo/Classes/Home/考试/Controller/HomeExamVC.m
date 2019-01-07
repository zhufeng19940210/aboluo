//  HomeExamVC.m
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeExamVC.h"
#import "HomeExamCell.h"
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
    [self setupData];
}

-(void)setptableview
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.examArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeExamCell *cell = [HomeExamCell HomecellWithTableView:tableView];
    ExamModel *model = self.examArray[indexPath.row];
    cell.exammodel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)setupData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = @"";
    param[@"productId"] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Exam_Start parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseobject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            weakSelf.examArray = [ExamModel mj_objectArrayWithKeyValuesArray:res.data[@"exam"]];
            [weakSelf.tableview reloadData];
        }else{
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
/**
 提交考试
 @param sender 提交考试
 */
- (IBAction)actionCommintBtn:(UIButton *)sender
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userId"] = @"";
    param[@"productId"] = @"";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Exam_End parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"考试responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        return;
    }];
}
@end
