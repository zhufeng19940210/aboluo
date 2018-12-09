//  URLStr.h
//  xiaochacha
//  Created by apple on 2018/10/31.
//  Copyright © 2018 HuiC. All rights reserved.
#ifndef URLStr_h
#define URLStr_h
/*=====================定义一些宏=================*/
#define UPDATESUCCESS       @"updatesuccess"
#define BaseUrl @"http://47.93.238.67:9999/lanpangzi"
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
///修改电话号码
#define User_Update_Phone [BaseUrl stringByAppendingString:@"/user/updatePhone"]
///修改头像
#define User_Update_Head [BaseUrl stringByAppendingString:@"/user/updateHead"]
///修改密码
#define User_Update_Pwd [BaseUrl stringByAppendingString:@"/user/pwd"]
/*====================用户接口 End==================*/
/*====================首页接口 Start==================*/
///首页接口
#define Home_Index [BaseUrl stringByAppendingString:@"/index"]
///项目列表接口
#define Home_Project_List [BaseUrl stringByAppendingString:@"/project/list"]
///项目详情接口
#define Home_Project_Detail [BaseUrl stringByAppendingString:@"/project/detail"]
///师傅列表接口
#define Home_Master_List [BaseUrl stringByAppendingString:@"/upe/list"]
///师傅详情接口
#define Home_Master_Deatil [BaseUrl stringByAppendingString:@"/upe/detail"]
///开始考试
#define Home_Exam_Start [BaseUrl stringByAppendingString:@"/exam/start"]
///考试结束
#define Home_Exam_End [BaseUrl stringByAppendingString:@"/exam/over"]
///抢单
#define Home_Project_Receive [BaseUrl stringByAppendingString:@"/project/receive"]
///确认接单
#define Home_Project_Confirm [BaseUrl stringByAppendingString:@"/project/okReceive"]
///工种接口
#define Home_GongZhong_Url [BaseUrl stringByAppendingString:@"/product/findAll"]
///工程师接口
#define Home_GongChenShi_Url [BaseUrl stringByAppendingString:@"/engineer/findAll"]
///企业等级接口
#define Home_Company_Level_Url [BaseUrl stringByAppendingString:@"/companyLevel/findAll"]
///商品拓展
#define Home_Company_Category [BaseUrl stringByAppendingString:@"/shop/category"]
/*====================首页接口 End==================*/
/*====================商品接口 star==================*/
///商城首页
#define Home_Store_Home [BaseUrl stringByAppendingString:@"/shop/home"]
///商品详情
#define Home_Store_Home [BaseUrl stringByAppendingString:@"/shop/detail"]
/*====================商品接口 End==================*/
/*====================认证 Start==================*/
///个人认证
#define Person_Authon [BaseUrl stringByAppendingString:@"/person/identify"]
///公司认证
#define Company_Authon [BaseUrl stringByAppendingString:@"/company/identif"]
/*====================认证 End==================*/

/*====================发单 Start==================*/
///判断是否有没有处理发单
#define FaDan_DealWith_Send_Url [BaseUrl stringByAppendingString:@"/project/sendOk"]
///首次发单
#define FaDan_Project_Send [BaseUrl stringByAppendingString:@"/project/send"]

///编辑发单
#define FanDan_Project_Edit [BaseUrl stringByAppendingString:@"/project/find"]
///是否有正在做的单子
#define FanDan_Project_isWork [BaseUrl stringByAppendingString:@"/project/receiveOk"]
/*====================发单 End==================*/

/*====================地址 start==================*/
///地址列表
#define Address_List_Url [BaseUrl stringByAppendingString:@"/address/list"]
///添加地址
#define Address_Add_Url [BaseUrl stringByAppendingString:@"/address/add"]
///编辑地址
#define Address_Eedit_Url [BaseUrl stringByAppendingString:@"/address/edit"]
///删除地址i
#define Address_Del_Url [BaseUrl stringByAppendingString:@"/address/del"]
///设置默认地址
#define Address_Default_Url [BaseUrl stringByAppendingString:@"/address/default"]

/*====================地址 End==================*/

/*====================购物车 strart==================*/
///查看购物车
#define Cart_List_Url [BaseUrl stringByAppendingString:@"/cart/index"]
///保存到购物车
#define Cart_Push_Url [BaseUrl stringByAppendingString:@"/cart/save"]
///增加
#define Cart_Add_Url [BaseUrl stringByAppendingString:@"/cart/add"]
///减少
#define Cart_subtract_Url [BaseUrl stringByAppendingString:@"/cart/subtract"]
///删除购物车中的某个商品
#define Cart_Del_Single_Url [BaseUrl stringByAppendingString:@"/cart/del"]
///删除全部的商品
#define Cart_Clear_All_Url [BaseUrl stringByAppendingString:@"/cart/clear"]
///支付方式
///积分充值
#define Cart_Clear_All_Url [BaseUrl stringByAppendingString:@"/cart/clear"]
///消费记录
#define Cart_Clear_All_Url [BaseUrl stringByAppendingString:@"/cart/clear"]
/*====================购物车 End==================*/

#endif /* URLStr_h */
