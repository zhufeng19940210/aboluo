//  ServerBillinghallVC.m
//  aboluo
//  Created by zhufeng on 2018/12/5.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillinghallVC.h"
#import "ServerBillingHeaderCell.h"
#import "ServerBillingIntroductionCell.h"
#import "ServerBillingPictureCell.h"
#import "ServerBillingTypeCell.h"
#import "ServerBillingOrderTypeCell.h"
#import "ServerBillingAcceptanceCell.h"
#import "ServerBillingInsuranceCell.h"
@interface ServerBillinghallVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end
@implementation ServerBillinghallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发单详情";
    [self setRightButtonText:@"发布" withColor:[UIColor whiteColor]];
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupData];
    [self setupTableView];
}

/**
 发布按钮
 @param button 发布按钮
 */
- (void)onRightBtnAction:(UIButton *)button
{
    
}
-(void)setupData
{
    
}
-(void)setupTableView
{
    self.tableview.delegate = self;
    self.tableview.dataSource  = self;
    self.tableview.backgroundColor = [UIColor clearColor];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingHeaderCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingIntroductionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingIntroductionCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingPictureCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingPictureCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingTypeCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingOrderTypeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingOrderTypeCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingAcceptanceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingAcceptanceCell"];
    [self.tableview registerNib:[UINib nibWithNibName:@"ServerBillingInsuranceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ServerBillingInsuranceCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  7;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 260;
    }else if(indexPath.section == 1){
        return 150;
    }else if(indexPath.section == 2){
        return 160;
    }else if(indexPath.section == 3) {
        return 50;
    }else if(indexPath.section == 4){
        return 120;
    }else if (indexPath.section == 5){
        return 150;
    }else if (indexPath.section == 6){
        return 50;
    }else{
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section !=6) {
        return 8;
    }else{
        return CGFLOAT_MIN;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ServerBillingHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingHeaderCell"];
        return cell;
    }else if (indexPath.section == 1){
        ServerBillingIntroductionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingIntroductionCell"];
        return cell;
    }else if(indexPath.section == 2){
        ServerBillingPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingPictureCell"];
        return cell;
    }else if (indexPath.section == 3){
        ServerBillingTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingTypeCell"];
        return cell;
    }else if (indexPath.section == 4){
        ServerBillingOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingOrderTypeCell"];
        return cell;
    }else if (indexPath.section == 5){
        ServerBillingAcceptanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingAcceptanceCell"];
        return cell;
    }else if (indexPath.section == 6){
        ServerBillingInsuranceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerBillingInsuranceCell"];
        return cell;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end



