//
//  XLXConst.h
//  房地产-新旅行
//
//  Created by xinlvxing on 16/7/21.
//  Copyright © 2016年 apple. All rights reserved.
//  存放常量

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


/** 设置borderStyle的格式 */
UIKIT_EXTERN CGFloat const TFborderStyle;

/** 长度20 */
UIKIT_EXTERN CGFloat const Klength20;

/** 长度10 */
UIKIT_EXTERN CGFloat const Klength10;

/** 长度15 */
UIKIT_EXTERN CGFloat const Klength15;

/** 长度5 */
UIKIT_EXTERN CGFloat const Klength5;

/** 长度30 */
UIKIT_EXTERN CGFloat const Klength30;

/** 长度44 */
UIKIT_EXTERN CGFloat const Klength44;

/** button的cornerRadius */
UIKIT_EXTERN CGFloat const BtncornerRadius;

/** 网址前段 */
UIKIT_EXTERN NSString const *URL;

/** 图片网址前段 */
UIKIT_EXTERN NSString const *picURL;





/** 网址前段 - 新 */
UIKIT_EXTERN NSString const *uRL;





/** 个人信息修改 */
typedef enum : NSUInteger {
    membername = 0,
    sex =1,
    telephone = 2,
    identity = 3,
    address =4,
    viplevel = 5,
    referee = 6,
    description =7,
    //    insurancetime = 8,
    //    commercialtime = 9,
} UserInfoType;
















































//
///**
// * 处理完成，并且成功
// */
//public static final int SUCESSCODE = 1000;
//
///**
// * 数据库没有这条数据
// */
//public static final int NOTFOUND = 1001;
//
///**
// * 系统错误
// */
//public static final int SYSERROR = 1002;
//
///**
// * 密码错误
// */
//public static final int VALUEWRONG = 1003;
//
///**
// * sql语句执行错误
// */
//public static final int SQLERROR = -1004;
//
///**
// * 未知错误
// */
//public static final int OTHERERROR = 1005;
//
///**
// * 参数有null
// */
//public static final int PARAMNULL = 1006;
//
///**
// * 用户没有登录
// */
//public static final int UNLOGIN = 1007;
//
///**
// * 验证码错误
// */
//public static final int IDENTCODE = 1008;
//
///**
// * 用户登录ip和本次请求ip不符；
// */
//public static final int IPCHANGED = 1009;
//
///**
// * 用户密码与用户确认密码不同
// */
//public static final int DIFFERENPWD = 1010;
//
///**
// * 用户登录macid和本次请求macid不符；
// */
//public static final int MACIDCHANGED = 1011;
//
///**
// * 误差值过大
// */
//public static final int DEVIATION = 1012;
//
///**
// * 登录手机改变
// */
//public static final int PHONECHANGED = 1013;
//
///**
// * 用户名在数据库中已经存在
// */
//public static final int EXISTS = 1014;
//
///**
// * 验证码不匹配
// */
//public static final int UNCHECKCODE = 1015;
//
///**
// * 用户没权限
// */
//public static final int NOPERMISSION = 1016;
//
///**
// * 图片不符合格式
// */
//public static final int PICTUREERROR = 1017;
//
///**
// * 添加操作没有成功
// */
//public static final int ADDFAULT = 1018;
//
///**
// * 删除操作没有成功
// */
//public static final int DELETEFAULT = 1019;
//
///**
// * 修改操作没有成功
// */
//public static final int UPDATEFAULT = 1020;
//
///**
// * 用户名在数据库中不存存在
// */
//public static final int NOEXISTS = 1021;
//
///**
// * 请核对金额
// */
//public static final int CHECKMONEY = 1022;
//
///**
// * 操作成功
// */
//public static final boolean SUCESS = true;
//
///**
// * 操作未完成或失败
// */
//public static final boolean FAULT = false;
//
///**
// * 操作是否成功的KEY
// */
//public static final String ISSUCESS = "success";
//
///**
// * 获取执行错误信息的KEY
// */
//public static final String ERROR = "error";
//
///**
// * 加解密返回结果的KEY
// */
//public static final String STRCODE = "strCode";
//
///**
// * 获取短信验证码的Key
// */
//public static final String CODE = "code";
//
///**
// * issucess为键取的值，表示执行成功
// */
//public static final String STRTRUE = "true";
//
///**
// * issucess为键取的值，表示执行失败
// */
//public static final String STRFALSE = "false";
//
///**
// * int类型初始值为0的变量的初始值
// */
//public static final int PRIMITIVEVALUE = 0;
//
///**
// * 此值不用在数据库更新
// */
//public static final int DONTCHANGE = 0;




