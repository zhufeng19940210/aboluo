//  AppDelegate.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "AppDelegate.h"
#import "LoginVC.h"
#import "TabBarController.h"
#import "GuideVC.h"
#import "GuideVC.h"
#import "MyNavigationController.h"
@interface AppDelegate ()<CLLocationManagerDelegate>
@end
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //定位的调用
    [self initLocation];
    //三方工具的初始化
    [self seutpThirdInitlation];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor  = [UIColor whiteColor];
    UIViewController *rootController = nil;
    BOOL isFirst = [[NSUserDefaults standardUserDefaults]boolForKey:@"isFirst"];
    if (isFirst) {
        if ([UserModel isOnline]) {
            //登录成功
            TabBarController *tabbarvc = [[TabBarController alloc]init];
            rootController =  tabbarvc;
        }else{
            //登录界面
            LoginVC *loginvc = [[LoginVC alloc]init];
            MyNavigationController *nav = [[MyNavigationController alloc]initWithRootViewController:loginvc];
            rootController = nav;
        }
    }else{
        //引导页
        GuideVC *guidevc = [[GuideVC alloc]init];
        MyNavigationController *nav = [[MyNavigationController alloc]initWithRootViewController:guidevc];
        rootController = nav;
    }
    self.window.rootViewController = rootController;
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)seutpThirdInitlation
{
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    ///三方登录的东西
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        [platformsRegister setupQQWithAppId:MOBSSDKQQAppID appkey:MOBSSDKQQAppKey];
        [platformsRegister setupWeChatWithAppId:MOBSSDKWeChatAppID appSecret:MOBSSDKWeChatAppSecret];
        [platformsRegister setupSinaWeiboWithAppkey:MOBSSDKSinaWeiBoAppKey appSecret:MOBSSDKWeChatAppSecret redirectUrl:MOBSSDKSinaWeiBoDirecUrl];
    }];
}
/**
 判断定位是否可用并且初始化定位信息
 */
- (void)initLocation{
    [self setupLocation];
}
//定位的东西了
-(void)setupLocation{
    // 实例化对象
    self.locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    self.locationManager.delegate = self;
    // 请求授权，记得修改的infoplist，NSLocationAlwaysUsageDescription（描述）
    //[self.locationManager requestAlwaysAuthorization];
    [self.locationManager requestWhenInUseAuthorization];
}
#pragma mark - 代理方法，当授权改变时调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // 获取授权后，通过
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        //开始定位(具体位置要通过代理获得)
        [self.locationManager startUpdatingLocation];
        //设置精确度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        //设置过滤距离
        self.locationManager.distanceFilter = 100;
        //开始定位方向
        [self.locationManager startUpdatingHeading];
    }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse){
        //开始定位(具体位置要通过代理获得)
        [self.locationManager startUpdatingLocation];
        //设置精确度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        //设置过滤距离
        self.locationManager.distanceFilter = 100;
        //开始定位方向
        [self.locationManager startUpdatingHeading];
    }
}
#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    //获取当前位置
    CLLocation *currentLocation = [locations lastObject];
    //获取坐标
    CLLocationCoordinate2D corrdinate = currentLocation.coordinate;
    //打印地址
    NSString *latitude  = [NSString stringWithFormat:@"%f",corrdinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",corrdinate.longitude];
    NSLog(@"latitude:%@,latitude:%@",latitude,longitude);
    [[NSUserDefaults standardUserDefaults]setValue:latitude forKey:ZF_Latitude];
    [[NSUserDefaults standardUserDefaults]setValue:longitude forKey:ZF_Longitude];
    [[NSUserDefaults standardUserDefaults]synchronize];
    //反编译
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        NSString *currentCity = nil;
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"未知";
            }
            NSLog(@"当前城市 - %@",currentCity);//当前城市
            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
            currentCity = [NSString stringWithFormat:@"%@%@",currentCity,placeMark.subLocality];
            NSLog(@"currentCity:%@",currentCity);
            [[NSUserDefaults standardUserDefaults]setValue:currentCity forKey:ZF_Location_Add];
            [[NSUserDefaults standardUserDefaults]synchronize];
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
    //停止定位
    [self.locationManager stopUpdatingLocation];
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
