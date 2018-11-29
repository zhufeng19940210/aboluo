//  URLStr.h
//  xiaochacha
//  Created by apple on 2018/10/31.
//  Copyright © 2018 HuiC. All rights reserved.
#ifndef URLStr_h
#define URLStr_h
/*=====================定义一些宏=================*/
#define UPDATESUCCESS       @"updatesuccess"

#define BaseUrl @"http://106.12.192.149:8080/lanpangzi"
/*====================用户接口 Start==================*/
///登录注册接口
#define User_Login_URL [BaseUrl stringByAppendingString:@"/user/login"]
///注册接口
#define User_Register_URL [BaseUrl stringByAppendingString:@"/user/register"]
///注册获取验证码
#define User_Get_Code [BaseUrl stringByAppendingString:@"/user/registerCode"]
///注册获取验证码
#define User_Update_Code [BaseUrl stringByAppendingString:@"/user/updateCode"]
///修改密码
#define User_Pwd_Forget [BaseUrl stringByAppendingString:@"/user/updatePwd"]
/*====================用户接口 End==================*/
/*====================首页接口 Start==================*/
///首页接口
#define Home_Index [BaseUrl stringByAppendingString:@"/index"]
///项目列表接口
#define Home_Project_List [BaseUrl stringByAppendingString:@"/project/list"]
///师傅列表接口
#define Home_Master_List [BaseUrl stringByAppendingString:@"/productEngineer/list"]
///项目详情接口
#define Home_Project_Detail [BaseUrl stringByAppendingString:@"/project/detail"]
///师傅详情接口
#define Home_Master_Deatil [BaseUrl stringByAppendingString:@"/productEngineer/detail"]
///开始考试
#define Home_Exam_Start [BaseUrl stringByAppendingString:@"/exam/start"]
///考试结束
#define Home_Exam_End [BaseUrl stringByAppendingString:@"/exam/over"]
///发单
#define Home_Project_Send [BaseUrl stringByAppendingString:@"/project/send"]
///抢单
#define Home_Project_Receive [BaseUrl stringByAppendingString:@"/project/receive"]
/*====================首页接口 End==================*/
/*====================商品接口 star==================*/
///商城
#define Home_Store_Home [BaseUrl stringByAppendingString:@"/shop/home"]
///选择类别
#define Home_Store_Sort [BaseUrl stringByAppendingString:@"/shop/category"]
///查看商品
#define Home_Store_Detail [BaseUrl stringByAppendingString:@"/shop/goods"]
/*====================商品接口 End==================*/

#endif /* URLStr_h */
