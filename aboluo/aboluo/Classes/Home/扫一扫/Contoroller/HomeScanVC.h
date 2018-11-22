//  HomeScanVC.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseVC.h"
@protocol HomeScanVCDelegate<NSObject>
-(void)getScanStr:(NSString *)str;
@end
@interface HomeScanVC : BaseVC
@property (nonatomic,weak)id<HomeScanVCDelegate> delegate;
@end
