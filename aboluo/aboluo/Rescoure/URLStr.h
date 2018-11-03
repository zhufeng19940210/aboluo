//  URLStr.h
//  xiaochacha
//  Created by apple on 2018/10/31.
//  Copyright © 2018 HuiC. All rights reserved.
#ifndef URLStr_h
#define URLStr_h

#define BaseUrl @"http://223.84.156.187:806/api"
///登录注册接口
#define User_Login_URL [BaseUrl stringByAppendingString:@"/User/UserLogin"]
///获取首页列表
#define Home_GetMenu_URL [BaseUrl stringByAppendingString:@"/Index/GetMenu"]
///查询学校列表
#define Home_SchoolList_URL [BaseUrl stringByAppendingString:@"/School/GetSchoolList"]
#endif /* URLStr_h */
