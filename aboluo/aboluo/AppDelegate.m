//  AppDelegate.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "AppDelegate.h"
#import "LoginVC.h"
#import "TabBarController.h"
@interface AppDelegate ()
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor  = [UIColor whiteColor];
    UIViewController *rootController = nil;
    BOOL isFirst = [[NSUserDefaults standardUserDefaults]boolForKey:@"isFirst"];
    if (isFirst) {
        TabBarController *tabbarvc = [[TabBarController alloc]init];
        rootController =  tabbarvc;
    }else{
        LoginVC *loginvc = [[LoginVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginvc];
        rootController = nav;
    }
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {

}
- (void)applicationWillEnterForeground:(UIApplication *)application {

}
- (void)applicationDidBecomeActive:(UIApplication *)application {

}
- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
