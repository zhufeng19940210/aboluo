//  URLStr.h
//  xiaochacha
//  Created by apple on 2018/10/31.
//  Copyright © 2018 HuiC. All rights reserved.
#ifndef URLStr_h
#define URLStr_h
#define BaseUrl @"http://223.84.156.187:806/api"
///登录接口
#define User_Login_URL [BaseUrl stringByAppendingString:@"/User/UserLogin"]
///注册接口
#define User_Register_URL [BaseUrl stringByAppendingString:@"/Index/GetMenu"]
///绑定接口
#define User_Bind_URL [BaseUrl stringByAppendingString:@"/School/GetSchoolList"]
///忘记密码
#define User_ForgetPwd_URL [BaseUrl stringByAppendingString:@"/School/GetSchoolList"]
#endif /* URLStr_h */
