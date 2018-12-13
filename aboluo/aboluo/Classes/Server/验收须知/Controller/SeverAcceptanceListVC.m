//  SeverAcceptanceListVC.m
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "SeverAcceptanceListVC.h"
#import "SeverAcceptanceVC.h"
#import "ZJScrollPageView.h"
@interface SeverAcceptanceListVC ()<ZJScrollPageViewDelegate>
//横向滚动视图
@property (nonatomic, weak) ZJScrollPageView *scrollPageView;
@end
@implementation SeverAcceptanceListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发单须知";
    self.view.backgroundColor = RGB(240, 240, 240);
    [self setRightButton:[UIImage imageNamed:@"电话"]];
    SeverAcceptanceVC *vc1 = [[SeverAcceptanceVC alloc]init];
    vc1.title = @"自主验收";
    vc1.typeStr = @"3";
    SeverAcceptanceVC  *vc2 = [[SeverAcceptanceVC alloc]init];
    vc2.title = @"平台验收";
    vc2.typeStr = @"4";
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
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
        ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-30) segmentStyle:style titles:[self.childViewControllers valueForKey:@"title"] parentViewController:self delegate:self withColor:[UIColor whiteColor]];
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
