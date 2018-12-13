//  ServerBillingInsuranceCell.h
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
@protocol ServerBillingInsuranceCellDelegate<NSObject>
-(void)pushToInsuranceMethod;
@end
@interface ServerBillingInsuranceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *insurance_tf;
@property (nonatomic,weak)id <ServerBillingInsuranceCellDelegate> delegate;
@end
