//
//  Common.h
//  HuiYingTianXia
//
//  Created by tsmc on 15-3-18.
//  Copyright (c) 2015年 tsmc. All rights reserved.
//

#ifndef TestTweet_Common_h
#define TestTweet_Common_h

//屏幕宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//navigation bar高度
#define NAVIGATIONBAT_HEIGTH 64
//状态栏高度
#define STATUS_BAR_HEIGHT 20

//系统大于8.0
#define SYSTEM_VERSION_LATER_THAN8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0

#define LINE_HEIGTH             .5

//适配以320屏幕宽度的Frame参数
CG_INLINE CGFloat HFixWidthBaseOn320(CGFloat width)
{
//    return width;
        return (SCREEN_WIDTH * width) / 320.;
}

CG_INLINE CGFloat HFixHeightBaseOn568(CGFloat height)
{
    return (SCREEN_HEIGHT-64) * height / (568.-64);
}


//判断终端是否是iphone4/4s
#define IPHONE4__4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height == 960 : NO)
#endif

//判断终端是否是iphone5/5s
#define IPHONE5__5S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height == 1136 : NO)

//判断终端是否是iphone6
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? [[UIScreen mainScreen] currentMode].size.height == 1334 : NO)
