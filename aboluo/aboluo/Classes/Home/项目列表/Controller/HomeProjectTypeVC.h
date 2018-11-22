//  HomeProjectTypeVC.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved
#import "BaseVC.h"
@interface HomeProjectTypeVC : BaseVC
@property (nonatomic,strong)NSMutableArray *projectArray;
///1:代表项目 2:代表工种
@property (nonatomic,copy)NSString *type;
@end
