//  ServerOrderruleListVC.m
//  aboluo
//
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved
#import "ServerOrderruleListVC.h"
#import "ServerOrderruleVC.h"
#import "ZJScrollPageView.h"
#import "GongZhongModel.h"
@interface ServerOrderruleListVC ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSMutableArray *titleArray;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@end

@implementation ServerOrderruleListVC

-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (ZJScrollPageView *)scrollPageView
{
    if(_scrollPageView == nil)
    {
        ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
        //显示滚动条
        style.showLine = YES;
        // 颜色渐变
        style.gradualChangeTitleColor = YES;
        style.contentViewBounces = NO;
        style.animatedContentViewWhenTitleClicked = NO;
        style.autoAdjustTitlesWidth = YES;
        style.scrollLineColor = MainThemeColor;
        style.selectedTitleColor = MainThemeColor;
        style.normalTitleColor = RGB(100,100,100);
        style.titleFont = [UIFont systemFontOfSize:16];
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT -Height_TabBar-30) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self withColor:[UIColor whiteColor]];
        [self.view addSubview:scrollPageView];
        _scrollPageView = scrollPageView;
        //滚动的页面
        //[scrollPageView setSelectedIndex:_index animated:NO];
    }
    return _scrollPageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"抢单须知";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setupData];
}

-(void)refreshStore
{
    for (int i = 0 ; i < self.titleArray.count; i++) {
        ServerOrderruleVC *detailvc = [[ServerOrderruleVC alloc]init];
        GongZhongModel *model = self.titleArray[i];
        detailvc.title = model.name;
        detailvc.typeStr = model.gid;
        [self addChildViewController:detailvc];
    }
    //这个一定要的东西了呀哈哈
    self.scrollPageView.backgroundColor = RGB(240, 240, 240);
}
/**
 请求数据
 */
-(void)setupData
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:FanDan_GongZhong_Url parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            [weakSelf.titleArray removeAllObjects];
            weakSelf.titleArray  = [GongZhongModel mj_objectArrayWithKeyValuesArray:res.data[@"products"]];
            [weakSelf refreshStore];
        }else{
            [SVProgressHUD showErrorWithStatus:res.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [SVProgressHUD dismiss];
        return;
    }];
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return self.childViewControllers.count;
}
- (UIViewController <ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    if (!childVc) {
        childVc = self.childViewControllers[index];
    }
    return childVc;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

@end
