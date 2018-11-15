//  HomeTopView.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeTopView.h"
#import "UIButton+POImagePosition.h"
/** 常量数 */
CGFloat const DCMargin = 10;
@interface HomeTopView()
@property (nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *imageArray;
/* 左边的按钮 */
@property(nonatomic,strong)UIButton *leftBarItem;
/* 右边按钮 */
@property(nonatomic,strong)UIButton *rightBarItem;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;

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
    //先创建新的东西
    _leftBarItem = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"home_location"] forState:UIControlStateNormal];
        [button setTitle:@"南昌市" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(actionLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [button setImagePosition:0 withInset:2];
        [button sizeToFit];
        button;
    });
    _rightBarItem = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"nil"] forState:UIControlStateNormal];
        button;
    });
    
    [self addSubview:_leftBarItem];
    [self addSubview:_rightBarItem];
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = [UIColor whiteColor];
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    [self addSubview:_topSearchView];
    
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"搜索你想要的东西" forState:0];
    [_searchButton setTitleColor:[UIColor lightGrayColor] forState:0];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_searchButton setImage:[UIImage imageNamed:@"home_search_gary"] forState:0];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * DCMargin, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, DCMargin, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_topSearchView addSubview:_searchButton];
    //然后是哪个支付宝的东西
    CGFloat btnH = 80;
    CGFloat btnW = btnH;
    CGFloat marign = 10;
    for(int i = 0 ; i<4; i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10+(marign*i)+btnW*i, Height_NavBar+10,btnW , btnH)];
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
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_leftBarItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(Height_StatusBar);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@100);
    }];
    [_rightBarItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->_leftBarItem.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_leftBarItem.mas_right).offset(5);
        make.right.equalTo(self->_rightBarItem.mas_left).offset(30);
        make.height.equalTo(@32);
        make.centerY.equalTo(self->_rightBarItem.mas_centerY);
    }];
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_topSearchView);
        make.top.equalTo(self->_topSearchView);
        make.height.equalTo(self->_topSearchView);
        make.right.equalTo(self->_topSearchView);
    }];
}

/**
 地址button点击
 @param button 地址button的点击
 */
-(void)actionLeftBtn:(UIButton *)button
{
    if (self.leftblock) {
        self.leftblock(button);
    }
}
/**
 搜索的功能
 @param button 搜索的功能
 */
-(void)searchButtonClick:(UIButton *)button
{
    if (self.searchblock) {
        self.searchblock(button);
    }
}
/**
 topbtn点击的按钮
 @param button topbtn的点击按钮
 */
-(void)myButtonClick:(UIButton *)button
{
    int tag =(int)button.tag;
    if (self.topactionCallback) {
        self.topactionCallback((HomeTopType)tag);
    }
}
@end
