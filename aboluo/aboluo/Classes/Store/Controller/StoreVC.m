//  StoreVC.m
//  aboluo
//  Created by zhufeng on 2018/11/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreVC.h"
#import "ZJScrollPageView.h"
#import "StoreDetailVC.h"
#import "HomeSearchVC.h"
@interface StoreVC ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@property(strong, nonatomic)NSArray<UIViewController *> *childVcs;
@property (nonatomic, strong) ZJScrollPageView *scrollPageView;
@end
@implementation StoreVC
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//}
//-(void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
//}
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
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT -Height_TabBar-Height_NavBar) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self withColor:[UIColor whiteColor]];
        [self.view addSubview:scrollPageView];
        _scrollPageView = scrollPageView;
        //滚动的页面
        //[scrollPageView setSelectedIndex:_index animated:NO];
    }
    return _scrollPageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商城中心";
    [self setRightButton:[UIImage imageNamed:@"search2"]];
    [self setupData];
    self.titles = @[@"新闻头条",
                    @"国际要闻",
                    @"体育",
                    @"中国足球",
                    @"汽车",
                    @"囧途旅游",
                    @"幽默搞笑",
                    @"视频",
                    @"无厘头",
                    @"美女图片",
                    @"今日房价",
                    @"头像头像",
                    ];
    for (int i = 0 ; i < self.titles.count; i++) {
        StoreDetailVC *detailvc = [[StoreDetailVC alloc]init];
        detailvc.title = self.titles[i];
        detailvc.typeStr = self.titles[i];
        NSLog(@"title:%@",self.titles[i]);
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
    [SVProgressHUD show];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"categoryId"] = @"1";
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Store_Sort parameters:param success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"responseobject:%@",responseObject);
        ResponeModel *res = [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
        return ;
    }];
}

- (void)onRightBtnAction:(UIButton *)button
{
    HomeSearchVC *searchvc = [[HomeSearchVC alloc]init];
    [self.navigationController pushViewController:searchvc animated:YES];
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
