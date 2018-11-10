//  URLStr.h
//  xiaochacha
//  Created by apple on 2018/10/31.
//  Copyright © 2018 HuiC. All rights reserved.
#ifndef URLStr_h
#define URLStr_h
#define BaseUrl @"http://106.12.192.149:8080/lanpangzi"
///登录注册接口
#define User_Login_URL [BaseUrl stringByAppendingString:@"/loginController/login"]
///注册接口
#define User_Register_URL [BaseUrl stringByAppendingString:@"/registerController/register"]
///注册获取验证码
#define User_Get_Code [BaseUrl stringByAppendingString:@"/sendCodeController/coding"]
///忘记密码
#define User_Pwd_Forget [BaseUrl stringByAppendingString:@"/updateOrForgetPwdController/updatePwd"]
#endif /* URLStr_h */
