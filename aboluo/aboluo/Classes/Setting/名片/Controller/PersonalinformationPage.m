//  PersonalinformationPage.m
//  aboluo
//  Created by zhufeng on 2018/12/9.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "PersonalinformationPage.h"
#import "InformationAvavtorCell.h"
#import "InformationPhoneCell.h"
#import "linformationUpdatePhonePage.h"
@interface PersonalinformationPage ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
@implementation PersonalinformationPage
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人资料";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupTableView];
}
-(void)setupTableView
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
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 80;
    }else{
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *informationCell = nil;
    if (indexPath.row == 0) {
        InformationAvavtorCell *avavtorCell = [InformationAvavtorCell BaseCellWithTableView:tableView];
        informationCell = avavtorCell;
    }else{
        InformationPhoneCell *phoneCell = [InformationPhoneCell BaseCellWithTableView:tableView];
        informationCell = phoneCell;
    }
    informationCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return informationCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        linformationUpdatePhonePage *updatePhonevc = [[linformationUpdatePhonePage alloc]init];
        [self.navigationController pushViewController:updatePhonevc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
