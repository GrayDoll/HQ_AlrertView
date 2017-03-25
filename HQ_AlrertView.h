//
//  HQ_AlrertView.h
//  DemoSecodMonthVersion
//
//  Created by 董杰 on 2017/3/23.
//  Copyright © 2017年 Heyqun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HQ_AlertType_TitleAndContent_OneBtn,
    HQ_AlertType_TitleAndContent_TwoBtn,
    HQ_AlertType_Content_OneBtn,
    HQ_AlertType_Content_TwoBtn,
} HQ_AlertType;


@protocol HQ_AlertDelegate <NSObject>

-(void)HQ_AlertDidSelectIndex:(NSInteger)sIndex;

@end

@interface HQ_AlrertView : UIView

@property(nonatomic, assign) HQ_AlertType alertType;

@property(nonatomic, assign) id <HQ_AlertDelegate> delegate;

+(instancetype)HQ_AlertViewWithWithTitle:(NSString *)title content:(NSString *)contentStr alertType:(HQ_AlertType)alertType btnTitles:(NSArray *)btnTitles;

-(void)setTitleLabelForTextColor:(UIColor *)titleColor titleFont:(UIFont *)tFont;
-(void)setContentLabelForTextColor:(UIColor *)titleColor titleFont:(CGFloat)tFont;
-(void)setLeftBtnTitleColor:(UIColor *)leftColor titleFont:(CGFloat)tFont;
-(void)setRightBtnTitleColor:(UIColor *)rightColor titleFont:(CGFloat)tFont;

-(void)showAction;
-(void)hideAction;




@end
