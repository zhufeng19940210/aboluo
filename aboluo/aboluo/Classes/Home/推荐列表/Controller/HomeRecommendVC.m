//  HomeRecommendVC.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeRecommendVC.h"
#import "RecommadnCell.h"
@interface HomeRecommendVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong) NSMutableArray *recommandArray;
@end
@implementation HomeRecommendVC
-(NSMutableArray *)recommandArray
{
    if (!_recommandArray) {
        _recommandArray = [NSMutableArray array];
    }
    return _recommandArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优质推荐";
    [self setupData];
    [self setupTableView];
}
/**
 请求数据
 */
-(void)setupData
{
    
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    //注册cell
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommandArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecommadnCell *cell  = [RecommadnCell recommandcellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
