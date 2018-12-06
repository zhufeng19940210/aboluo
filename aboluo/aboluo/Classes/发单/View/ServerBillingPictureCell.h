//  ServerBillingPictureCell.h
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
@protocol ServerBillingPictureCellDelegate <NSObject>

-(void)BCYPhotoPushSelectWithType;

@end
@interface ServerBillingPictureCell : UITableViewCell
@property (nonatomic,strong)NSMutableArray *selectArray;
@property (nonatomic,weak) id <ServerBillingPictureCellDelegate> delegate;
@end
