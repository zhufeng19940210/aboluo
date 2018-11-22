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
///忘记密码
#define User_Pwd_Forget [BaseUrl stringByAppendingString:@"/user/updatePwd"]
/*====================用户接口 End==================*/
/*====================首页接口 Start==================*/
///首页接口
#define Home_Index [BaseUrl stringByAppendingString:@"/index"]
///项目列表接口
#define Home_Project_List [BaseUrl stringByAppendingString:@"/index"]
///师傅列表接口
#define Home_Master_List [BaseUrl stringByAppendingString:@"/index"]
///项目详情接口
#define Home_Project_Detail [BaseUrl stringByAppendingString:@"/index"]
///师傅详情接口
#define Home_Master_Deatil [BaseUrl stringByAppendingString:@"/index"]
///考试
/*====================首页接口 End==================*/

#endif /* URLStr_h */
