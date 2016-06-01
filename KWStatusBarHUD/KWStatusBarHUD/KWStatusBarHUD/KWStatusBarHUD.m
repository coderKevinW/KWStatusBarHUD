//
//  KWStatusBarHUD.m
//  KWStatusBarHUD
//
//  Created by 王鑫 on 16/6/1.
//  Copyright © 2016年 KW. All rights reserved.
//

#import "KWStatusBarHUD.h"

#define KWMessageFont [UIFont systemFontOfSize:12]

/** 全局变量:窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;

/** 窗口显示停留的时间间隔 */
static CGFloat const KWWindowMessageDuration = 2;

/** 窗口显示或隐藏过程的时间间隔 */
static CGFloat const KWWindowAnimationInterval = 0.25 ;

@implementation KWStatusBarHUD

/** 
 *  显示下拉窗口 
 */
+ (void)showWindow
{
    //1 设置窗口frame
    CGFloat windowH = 20;
    // 窗口的初始frame
    CGRect  winFrame = CGRectMake(0, - windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    //2 显示窗口
    window_ = [[UIWindow alloc]init];
    
    window_.hidden = YES;
    window_.frame = winFrame;
    window_.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    
    //3 动画
    winFrame.origin.y = 0;
    [UIView animateWithDuration:KWWindowAnimationInterval animations:^{
        window_.frame = winFrame;
    }];
    
}

/** 显示自定义的信息和图片 */
+ (void)showMessage:(NSString *)message image:(UIImage *)image
{
    //1 首先停止计时器
    [timer_ invalidate];
    
    //2 显示窗口
    [self showWindow];
    
    //3 往window_中添加button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.bounds;
    //  添加文字和图片
    [button setTitle:message forState:UIControlStateNormal];
    button.titleLabel.font = KWMessageFont;
    if (image)
    {
        //如果需要传图片
        [button setImage:image forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    }
    
    [window_ addSubview:button];
    
    //4 开启定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:KWWindowMessageDuration target:self selector:@selector(hideHUD) userInfo:nil repeats:NO];
}

/** 加载成功 */
+ (void)showSuccess:(NSString *)message
{
    [self showMessage:message image:[UIImage imageNamed:@"KWStatusBarHUD.bundle/success"]];
}

/** 加载失败 */
+ (void)showFailure:(NSString *)message
{
    [self showMessage:message image:[UIImage imageNamed:@"KWStatusBarHUD.bundle/error"]];
}

/** 加载中 */
+ (void)showLoading:(NSString *)message
{
    //1 计时器停止并释放
    [timer_ invalidate];
    timer_ = nil;
    
    //2 显示窗口
    [self showWindow];
    
    //2 添加文字
    UILabel *label = [[UILabel alloc]init];
    label.frame = window_.bounds;
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.font = KWMessageFont;
    label.textAlignment = NSTextAlignmentCenter;
    [window_ addSubview:label];
    
    //3 添加菊花
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    //  计算菊花frame
    CGFloat textWidth = [message sizeWithAttributes:@{NSFontAttributeName : KWMessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - textWidth) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/** 隐藏 */
+ (void)hideHUD
{
    //计算frame准备
    CGFloat windowH = window_.frame.size.width;
    CGRect frame = window_.frame;
    frame.origin.y = - windowH;
    
    [UIView animateWithDuration:KWWindowAnimationInterval animations:^{
        window_.frame = frame;
    } completion:^(BOOL finished) {
        //将定时器和窗口释放
        timer_ = nil;
        window_ = nil;
    }];
}

@end
