//
//  KWStatusBarHUD.h
//  KWStatusBarHUD
//
//  Created by 王鑫 on 16/6/1.
//  Copyright © 2016年 KW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KWStatusBarHUD : UIView

/** 显示自定义的信息和图片 */
+ (void)showMessage:(NSString *)message image:(UIImage *)image;

/** 加载成功 */
+ (void)showSuccess:(NSString *)message;

/** 加载失败 */
+ (void)showFailure:(NSString *)message;

/** 加载中 */
+ (void)showLoading:(NSString *)message;

/** 隐藏 */
+ (void)hideHUD;

@end
