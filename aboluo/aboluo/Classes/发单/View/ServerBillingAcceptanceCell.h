//  ServerBillingAcceptanceCell.h
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
typedef void (^AcceptanceBlock) (int tag);
@interface ServerBillingAcceptanceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mySelf_btn;
@property (weak, nonatomic) IBOutlet UIButton *pingtai_btn;
@property (nonatomic,copy)AcceptanceBlock accptanceblock;
@end
