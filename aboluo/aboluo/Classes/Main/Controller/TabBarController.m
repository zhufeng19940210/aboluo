//  TabBarController.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "TabBarController.h"
#import "HomeVC.h"
#import "SettingVC.h"
#import "ServerVC.h"
#import "StoreVC.h"
#import "MyNavigationController.h"
#import "LoginVC.h"
@interface TabBarController () <UITabBarControllerDelegate>
@end
@implementation TabBarController
+(void)initialize{
    
    [super initialize];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:(122.0f/255.0f) green:(126.0f/255.0) blue:(131.0f/255.0f) alpha:1  ];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectAttrs[NSForegroundColorAttributeName] =  [  UIColor colorWithRed:(133.0f/255.0f) green:(160.0f/255.0f) blue:(38.0/255.0f) alpha:1];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//去掉tabBar顶部黑色线条
//    CGRect rect = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
//
//    UIGraphicsBeginImageContext(rect.size);
//
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//
//    CGContextFillRect(context, rect);
//
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//
//    UIGraphicsEndImageContext();
//
//    [self.tabBar setBackgroundImage:img];
//
//    [self.tabBar setShadowImage:img];
    // 初始化子控制器
    [self setupAllControllers];
    
    self.delegate = self;
}

#pragma mark - 初始化界面的方法
/**
 *  初始化所有子控制器
 */
- (void)setupAllControllers
{
    //首页
    HomeVC *homevc = [[HomeVC alloc]init];
    [self setupChildViewVC:homevc title:@"首页" norImage:@"tabbar_home_nor" selectImage:@"tabbar_home_sel"];
    //服务
    ServerVC *servervc = [[ServerVC alloc]init];
    [self setupChildViewVC:servervc title:@"服务" norImage:@"tabbar_server_nor" selectImage:@"tabbar_server_sel"];
    //商城
    //StoreVC *storevc = [[StoreVC alloc]init];
    //[self setupChildViewVC:storevc title:@"商城" norImage:@"tabbar_store_nor" selectImage:@"tabbar_store_sel"];
    //会员
    SettingVC  *settingvc = [[SettingVC alloc]init];
    [self setupChildViewVC:settingvc title:@"设置" norImage:@"tabbar_setting_nor" selectImage:@"tabbar_setting_sel"];
}
/**
 *  初始化一个子控制的方法
 */
- (void)setupChildViewVC:(UIViewController *)childVC title:(NSString *)title norImage:(NSString *)norName selectImage:(NSString *)selectImage
{   // 标题
    //childVC.title = title;
    UIImage *norImage = [UIImage imageNamed:norName];
    // 普通状态下得图片
    childVC.tabBarItem.image = [norImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    // 设置选中状态下得图片
    UIImage *selectedImage = [UIImage imageNamed:selectImage];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    // 添加导航控制器
    MyNavigationController *nav = [[MyNavigationController alloc]initWithRootViewController:childVC];
    // 添加tarBarController的子控制器
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{
    NSLog(@"%ld == %@ == %@",tabBarController.selectedIndex,tabBarController,viewController);
    if ([self.viewControllers objectAtIndex:2] == viewController)
    {
        NSLog(@"settingVC is default");
        if ([UserModel isOnline]) {
            //登录成功
            return YES;
        }else{
            //失败成功
            LoginVC *loginvc = [[LoginVC alloc]init];
            MyNavigationController *nav = [[MyNavigationController alloc]initWithRootViewController:loginvc];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
    }
    return YES;
}
@end
