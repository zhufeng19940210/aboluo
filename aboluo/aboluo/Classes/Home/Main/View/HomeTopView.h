//  HomeTopView.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HomeTopType) {
    HomeTopTypeScan   = 1000,//扫一扫
    HomeTopTypePay    = 1001,//付款
    HomeTopTypeReceipt= 1002,//收款
    HomeTopTypeExchage= 1003,//兑换
};
typedef void(^LeftBtnBlock)(UIButton *btn);
typedef void(^SearchBtnBlock)(UIButton *btn);
@interface HomeTopView : UIView
@property (nonatomic,copy) void(^topactionCallback)(HomeTopType type);
@property (nonatomic,copy) LeftBtnBlock   leftblock;
@property (nonatomic,copy) SearchBtnBlock searchblock;
@end
