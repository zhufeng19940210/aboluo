//  MySendOrderListVC.m
//  aboluo
//  Created by zhufeng on 2018/12/13.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "MySendOrderListVC.h"
#import "ZJScrollPageView.h"
#import "MySendOrderDetailVC.h"
@interface MySendOrderListVC ()<ZJScrollPageViewDelegate>
//横向滚动视图
@property (nonatomic, weak) ZJScrollPageView *scrollPageView;
@end
@implementation MySendOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的发单";
    self.view.backgroundColor = RGB(240, 240, 240);
    MySendOrderDetailVC *vc1 = [[MySendOrderDetailVC alloc]init];
    vc1.title = @"已完成";
    vc1.typeStr = @"1";
    MySendOrderDetailVC *vc2 = [[MySendOrderDetailVC alloc]init];
    vc2.title = @"正在进行";
    vc2.typeStr = @"0";
    MySendOrderDetailVC *vc3 = [[MySendOrderDetailVC alloc]init];
    vc3.title = @"发单失败";
    vc3.typeStr = @"-1";
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    self.scrollPageView.backgroundColor = RGB(240, 240, 240);
}
#pragma mark - getter

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
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-Height_NavBar) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self withColor:[UIColor whiteColor]];
        [self.view addSubview:scrollPageView];
        _scrollPageView = scrollPageView;
        //滚动的页面
        //[scrollPageView setSelectedIndex:_index animated:NO];
    }
    return _scrollPageView;
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
