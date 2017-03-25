//
//  HQ_AlrertView.m
//  DemoSecodMonthVersion
//
//  Created by 董杰 on 2017/3/23.
//  Copyright © 2017年 Heyqun. All rights reserved.
//

#import "HQ_AlrertView.h"

#define kLeftPadding (15)

typedef enum : NSUInteger {
    Alert_Frame_Type_Small,
    Alert_Frame_Type_Normal,
    Alert_Frame_Type_Large,
} Alert_Frame_Type;

//static const CGFloat kMaintTitleHeight = 30;
static const CGFloat kBtnWidth = 70;
static const CGFloat kBtnHeight = 30;
static const CGFloat kBtnTopPadding = 10;
//static const CGFloat kOrignYOff = 125;

@interface HQ_AlrertView()
{
    CGFloat supWidth;
    CGFloat kOrignYOff;
    CGFloat kContentFont;
}

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *horSepLine;
@property(nonatomic, strong) UILabel *verSepLine;

//只负责展示
@property(nonatomic, strong) UIButton *mainBtn;//单个 或者 左
@property(nonatomic, strong) UIButton *subBtn;//辅助 按钮

@property(nonatomic, assign) Alert_Frame_Type frmType;

@end

@implementation HQ_AlrertView

//几种状态
/*
 
 (1) oneBtn
 [1] 主标题 + 内容 + oneBtn
 [2] 内容 + oneBtn
 
 (2) twoBtn
 [1] 主标题 + 内容 + twoBtn
 [2]  内容  +  twoBtn;
 
 ---------------
 
 1.主标题
 2.内容
 3.主按钮
 4.副按钮
 
 按钮的展示 要与 按钮的 作用剥离出来;  左边 按钮 - 点击: 0!! 右边 按钮 - 点击: 1 !!
 
 ----------------
 屏幕大小: framType
 1. 小于 375
 2. 等于 375
 3. 大于 375
 
 */

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self defineTheScreenFrameType];
    }
    return self;
}

-(void)initBaseViewForType:(HQ_AlertType)alertType
{
    self.alertType = alertType;
    if (alertType == HQ_AlertType_Content_OneBtn) {
        [self addSubview:self.contentLabel];
        [self addSubview:self.horSepLine];
        [self addSubview:self.mainBtn];
    }else if (alertType == HQ_AlertType_TitleAndContent_OneBtn){
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.horSepLine];
        [self addSubview:self.mainBtn];
    }else if (alertType == HQ_AlertType_Content_TwoBtn){
        [self addSubview:self.contentLabel];
        [self addSubview:self.horSepLine];
        [self addSubview:self.verSepLine];
        [self addSubview:self.mainBtn];
        [self addSubview:self.subBtn];
    }else if (alertType == HQ_AlertType_TitleAndContent_TwoBtn){
        [self addSubview:self.titleLabel];
        [self addSubview:self.contentLabel];
        [self addSubview:self.horSepLine];
        [self addSubview:self.verSepLine];
        [self addSubview:self.mainBtn];
        [self addSubview:self.subBtn];
    }
    
}

-(void)initFrameOfTheViewForType:(HQ_AlertType)alertType
{
    if (alertType == HQ_AlertType_Content_OneBtn) {
        
        self.contentLabel.frame = CGRectMake(kLeftPadding, 15, supWidth - 2 * kLeftPadding, 30);
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/2. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        
    }else if (alertType == HQ_AlertType_TitleAndContent_OneBtn){
       
        self.titleLabel.frame = CGRectMake(kLeftPadding, 8, supWidth - 2 * kLeftPadding, 30);
        self.contentLabel.frame = CGRectMake(kLeftPadding, CGRectGetMaxY(self.titleLabel.frame) + 15, supWidth - 2 * kLeftPadding, 30);
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/2. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        
    }else if (alertType == HQ_AlertType_Content_TwoBtn){
        
        self.contentLabel.frame = CGRectMake(kLeftPadding, 15, supWidth - 2 * kLeftPadding, 30);
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.subBtn.frame = CGRectMake(supWidth * 3/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.verSepLine.frame = CGRectMake(supWidth/2. - 0.5/2., CGRectGetMaxY(self.horSepLine.frame) + 8, 0.5, kBtnHeight);
        
    }else if (alertType == HQ_AlertType_TitleAndContent_TwoBtn){
       
        self.titleLabel.frame = CGRectMake(kLeftPadding, 8, supWidth - 2 * kLeftPadding, 30);
        self.contentLabel.frame = CGRectMake(kLeftPadding, CGRectGetMaxY(self.titleLabel.frame) + 15, supWidth - 2 * kLeftPadding, 30);
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.subBtn.frame = CGRectMake(supWidth * 3/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.verSepLine.frame = CGRectMake(supWidth/2. - 0.5/2., CGRectGetMaxY(self.horSepLine.frame) + 8, 0.5, kBtnHeight);
    
    }
    
}

-(void)updateContentFrameForContent:(NSString *)content
{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = supWidth/15.;
    self.clipsToBounds = YES;
    
    CGFloat supHeight = CGRectGetHeight(self.frame);
    kOrignYOff = (kSCREEN_HEIGHT - supHeight)/2. - kSCREEN_HEIGHT/30.;
    
    if (self.frmType == Alert_Frame_Type_Large) {
         self.frame = CGRectMake(30, kOrignYOff, kSCREEN_WIDTH - 2 * 50, 300);
    }else{
         self.frame = CGRectMake(30, kOrignYOff, kSCREEN_WIDTH - 2 * 30, 300);
    }
    
    if (self.alertType == HQ_AlertType_Content_OneBtn) {
        
        CGFloat contentHeight = [self fetchTheHeightOfTheContent:content];
        CGRect oldRect = self.contentLabel.frame;
        oldRect.size.height = contentHeight;
        self.contentLabel.frame = oldRect;
        
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/2. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        
        CGRect odlFrm = self.frame;
        odlFrm.size.height = CGRectGetMaxY(self.mainBtn.frame) + kBtnTopPadding;
        self.frame = odlFrm;
        
    }else if (self.alertType == HQ_AlertType_TitleAndContent_OneBtn){
        
        self.titleLabel.frame = CGRectMake(kLeftPadding, 8, supWidth - 2 * kLeftPadding, 30);
        
        CGFloat contentHeight = [self fetchTheHeightOfTheContent:content];
        CGRect oldRect = self.contentLabel.frame;
        oldRect.size.height = contentHeight;
        self.contentLabel.frame = oldRect;
        
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/2. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        
        CGRect odlFrm = self.frame;
        odlFrm.size.height = CGRectGetMaxY(self.mainBtn.frame) + kBtnTopPadding;
        self.frame = odlFrm;
        
    }else if (self.alertType == HQ_AlertType_Content_TwoBtn){
        
        CGFloat contentHeight = [self fetchTheHeightOfTheContent:content];
        CGRect oldRect = self.contentLabel.frame;
        oldRect.size.height = contentHeight;
        self.contentLabel.frame = oldRect;
        
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.subBtn.frame = CGRectMake(supWidth * 3/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.verSepLine.frame = CGRectMake(supWidth/2. - 0.5/2., CGRectGetMaxY(self.horSepLine.frame) + 8, 0.5, kBtnHeight);
        
        CGRect odlFrm = self.frame;
        odlFrm.size.height = CGRectGetMaxY(self.mainBtn.frame) + kBtnTopPadding;
        self.frame = odlFrm;
        
    }else if (self.alertType == HQ_AlertType_TitleAndContent_TwoBtn){
        
        self.titleLabel.frame = CGRectMake(kLeftPadding, 8, supWidth - 2 * kLeftPadding, 30);
        
        CGFloat contentHeight = [self fetchTheHeightOfTheContent:content];
        CGRect oldRect = self.contentLabel.frame;
        oldRect.size.height = contentHeight;
        self.contentLabel.frame = oldRect;
        
        self.horSepLine.frame = CGRectMake(8, CGRectGetMaxY(self.contentLabel.frame) + 20, supWidth - 2 *8, 0.5);
        self.mainBtn.frame = CGRectMake(supWidth/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.subBtn.frame = CGRectMake(supWidth * 3/4. - kBtnWidth/2., CGRectGetMaxY(self.horSepLine.frame) + kBtnTopPadding, kBtnWidth, kBtnHeight);
        self.verSepLine.frame = CGRectMake(supWidth/2. - 0.5/2., CGRectGetMaxY(self.horSepLine.frame) + 8, 0.5, kBtnHeight);
        
        CGRect odlFrm = self.frame;
        odlFrm.size.height = CGRectGetMaxY(self.mainBtn.frame) + kBtnTopPadding;
        self.frame = odlFrm;

    }
    
}

-(void)defineTheScreenFrameType
{
    if (kSCREEN_WIDTH < 370) {
        self.alertType = Alert_Frame_Type_Small;
    }else if (kSCREEN_WIDTH < 380){
        self.alertType = Alert_Frame_Type_Normal;
    }else{
        self.alertType = Alert_Frame_Type_Large;
    }
    
    self.frame = CGRectMake(30, kOrignYOff, kSCREEN_WIDTH - 2 * 30, 300);
    
    supWidth = CGRectGetWidth(self.frame);
    kOrignYOff = kSCREEN_HEIGHT/3.;
    self.backgroundColor = [UIColor whiteColor];
    kContentFont = 14;
}

#pragma mark - 初始化方法
-(instancetype)initHQ_AlertviewWithTitle:(NSString *)title content:(NSString *)contentStr alertType:(HQ_AlertType)alertType btnTitles:(NSArray *)btnTitles
{
    self = [super init];
    if (self) {
        _alertType = alertType;
        [self defineTheScreenFrameType];
        [self initBaseViewForType:alertType];
        [self initFrameOfTheViewForType:alertType];
        [self updateContentFrameForContent:contentStr];
        
        [self fillDataWithTitle:title content:contentStr alertType:alertType btnTitles:btnTitles];
    }
    return self;
}

+(instancetype)HQ_AlertViewWithWithTitle:(NSString *)title content:(NSString *)contentStr alertType:(HQ_AlertType)alertType btnTitles:(NSArray *)btnTitles
{
    return [[self alloc] initHQ_AlertviewWithTitle:title content:contentStr alertType:alertType btnTitles:btnTitles];
}

-(void)fillDataWithTitle:(NSString *)title content:(NSString *)contentStr alertType:(HQ_AlertType)alerType btnTitles:(NSArray *)btnTitles
{
    if (self.alertType == HQ_AlertType_Content_OneBtn) {
        self.contentLabel.text = contentStr;
        NSString *btnTitle = [btnTitles firstObject];
        [self.mainBtn setTitle:btnTitle forState:UIControlStateNormal];
        [self.mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if (self.alertType == HQ_AlertType_TitleAndContent_OneBtn){
        self.contentLabel.text = contentStr;
        self.titleLabel.text = title;
        NSString *btnTitle = [btnTitles firstObject];
        [self.mainBtn setTitle:btnTitle forState:UIControlStateNormal];
        [self.mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else if (self.alertType == HQ_AlertType_Content_TwoBtn){
        self.contentLabel.text = contentStr;
        NSString *btnTitle1 = [btnTitles objectAtIndex:0];
        [self.mainBtn setTitle:btnTitle1 forState:UIControlStateNormal];
        [self.mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString *btnTitle2 = [btnTitles objectAtIndex:1];
        [self.subBtn setTitle:btnTitle2 forState:UIControlStateNormal];
        [self.subBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }else if (self.alertType == HQ_AlertType_TitleAndContent_TwoBtn){
        self.contentLabel.text = contentStr;
        self.titleLabel.text = title;
        NSString *btnTitle1 = [btnTitles objectAtIndex:0];
        [self.mainBtn setTitle:btnTitle1 forState:UIControlStateNormal];
        [self.mainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        NSString *btnTitle2 = [btnTitles objectAtIndex:1];
        [self.subBtn setTitle:btnTitle2 forState:UIControlStateNormal];
        [self.subBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
       
    }

}

#pragma mark - Action
-(void)showAction
{
    [UIView animateWithDuration:1.5 animations:^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.bgView];
        [window addSubview:self];
    }];
}

-(void)hideAction
{
    [UIView animateWithDuration:1.5 animations:^{

    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

-(void)tapThBg
{
    [self hideAction];
}

-(void)mainClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HQ_AlertDidSelectIndex:)]) {
        [self.delegate HQ_AlertDidSelectIndex:0];
    }
    
    [self hideAction];
}

-(void)subBtnClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HQ_AlertDidSelectIndex:)]) {
        [self.delegate HQ_AlertDidSelectIndex:1];
    }
    
    [self hideAction];
}

#pragma mark - 颜色字体设置
//颜色字体设置
-(void)setTitleLabelForTextColor:(UIColor *)titleColor titleFont:(UIFont *)tFont
{
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = tFont;
}

-(void)setContentLabelForTextColor:(UIColor *)titleColor titleFont:(CGFloat)tFont
{
    self.contentLabel.textColor = titleColor;
    kContentFont = tFont;
    self.contentLabel.font = [UIFont systemFontOfSize:tFont];
}

-(void)setLeftBtnTitleColor:(UIColor *)leftColor titleFont:(CGFloat)tFont
{
    [self.mainBtn setTitleColor:leftColor forState:UIControlStateNormal];
    self.mainBtn.titleLabel.font = [UIFont systemFontOfSize:tFont];
}

-(void)setRightBtnTitleColor:(UIColor *)rightColor titleFont:(CGFloat)tFont
{
    [self.subBtn setTitleColor:rightColor forState:UIControlStateNormal];
    self.subBtn.titleLabel.font = [UIFont systemFontOfSize:tFont];
}

#pragma mark - Private
-(CGFloat)fetchTheHeightOfTheContent:(NSString *)contentStr
{
    UIFont *textFont = [UIFont systemFontOfSize:kContentFont];
    CGSize textSize = [contentStr boundingRectWithSize:CGSizeMake( CGRectGetWidth(self.contentLabel.frame), MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : textFont} context:nil].size;
    
    if (textSize.height < 20) {
        return 20;
    }else{
        return textSize.height;
    }
    
}

#pragma mark - Property
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.backgroundColor = [UIColor purpleColor];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

-(UILabel *)horSepLine
{
    if (!_horSepLine) {
        _horSepLine = [[UILabel alloc] init];
        _horSepLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _horSepLine;
}

-(UILabel *)verSepLine
{
    if (!_verSepLine) {
        _verSepLine = [[UILabel alloc] init];
        _verSepLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _verSepLine;
}

-(UIButton *)mainBtn
{
    if (!_mainBtn) {
        _mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_mainBtn addTarget:self action:@selector(mainClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainBtn;
}

-(UIButton *)subBtn
{
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn addTarget:self action:@selector(subBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}

-(UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _bgView.backgroundColor = [UIColor lightGrayColor];
        _bgView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapBg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThBg)];
        [_bgView addGestureRecognizer:tapBg];
    }
    return _bgView;
}

@end
