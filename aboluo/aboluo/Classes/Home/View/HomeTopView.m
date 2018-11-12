//  HomeTopView.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "HomeTopView.h"
@interface HomeTopView()
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end
@implementation HomeTopView
-(NSMutableArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"hom_sao",@"home_fu",@"home_shou",@"home_dui", nil];
    }
    return _titleArray;
}
-(NSMutableArray *)imageArray
{
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithObjects:@"扫一扫",@"付款",@"收款",@"兑换", nil];
    }
    return _imageArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self seutpUI];
    }
    return self;
}

-(void)seutpUI
{
    CGFloat btnH = 80;
    CGFloat btnW = btnH;
    CGFloat marign = 10;
    for(int i = 0 ; i<4; i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+(marign*i)+btnW*i, 10,btnW , btnH)];
        [button setImage:[UIImage imageNamed:self.titleArray[i]] forState:UIControlStateNormal];
        [button setTitle:self.imageArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setImagePosition:POImagePositionTop withInset:1];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 1000+i;
        [button addTarget:self action:@selector(myButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
-(void)myButtonClick:(UIButton *)button
{
    
}
@end
