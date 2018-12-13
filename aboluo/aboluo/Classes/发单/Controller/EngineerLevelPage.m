//  EngineerLevelPage.m
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved
#import "EngineerLevelPage.h"
#import "ConditionCell.h"
#import "EngineerModel.h"
@interface EngineerLevelPage ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *insuranceArray;
@property (nonatomic,strong)EngineerModel *selectmodel;
@property (nonatomic,assign)int currentindex;
@end

@implementation EngineerLevelPage

-(NSMutableArray *)insuranceArray
{
    if (!_insuranceArray) {
        _insuranceArray = [NSMutableArray array];
    }
    return _insuranceArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"请选择师傅等级";
    self.currentindex = 9999;
    [self setRightButtonText:@"确定" withColor:[UIColor whiteColor]];
    [self setupData];
    [self setupTableView];
}

- (void)onRightBtnAction:(UIButton *)button
{
    if (self.selectmodel) {
        self.engineerblock(self.selectmodel);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self showHint:@"请选择师傅等级" yOffset:-200];
        return;
    }
}
-(void)setupData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:FanDan_GongChenShi_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
             [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            [weakSelf.insuranceArray removeAllObjects];
            weakSelf.insuranceArray = [EngineerModel mj_objectArrayWithKeyValuesArray:res.data[@"engineers"]];
           
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return;
    }];
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"ConditionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ConditionCell"];
}
#pragma mark -- uitableviewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.insuranceArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConditionCell *cell = [ConditionCell BaseCellWithTableView:tableView];
    int tag = (int)indexPath.row;
    EngineerModel *model = self.insuranceArray[indexPath.row];
    if (model.isSelect == YES) {
        self.currentindex = tag;
        cell.select_img.image = [UIImage imageNamed:@"zf_circle_select"];
        cell.title_lab.textColor = MainThemeColor;
    }else{
        cell.select_img.image = [UIImage imageNamed:@"zf_circle_nor"];
        cell.title_lab.textColor = [UIColor blackColor];
    }
    cell.title_lab.text = model.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EngineerModel *model = self.insuranceArray[indexPath.row];
    self.selectmodel = model;
    [self updateCellStatus:(int)indexPath.row];
}
// 改变cell的背景颜色
-(void)updateCellStatus:(int)cellIndexRow
{   NSLog(@"cellIndexRow:%d",cellIndexRow);
    EngineerModel *model = self.insuranceArray[cellIndexRow];
    if (model.isSelect == YES) {
        //如果是点击过了就不做处理
    }else{
        model.isSelect = YES;
        NSLog(@"self.currentIndex:%d",self.currentindex);
        if (self.currentindex <=self.insuranceArray.count) {
            EngineerModel *model2 = self.insuranceArray[self.currentindex];
            model2.isSelect = NO;
        }
    }
    self.currentindex = cellIndexRow;
    [self.tableview reloadData];
}
@end
