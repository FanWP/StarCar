//
//  userModel.h
//  房地产-新旅行
//
//  Created by xinlvxing on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

/**  用户信息模型 */


#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,copy) NSString *ID;//后台返回为id
/** 用户描述信息 */
@property (nonatomic,copy) NSString *describe;//后台返回为description
/** 用户名 */
@property (nonatomic,copy) NSString *name;
/** 用户类型 */
@property (nonatomic,assign) NSInteger type;
/** 用户地址 */
@property (nonatomic,copy) NSString *address;
/** 员工电话 */
@property (nonatomic,copy) NSString *telephone;
/** 身份证 */
@property (nonatomic,copy) NSString *identity;
/** 用户性别 */
@property (nonatomic,assign) NSInteger sex;
/** 用户年龄 */
@property (nonatomic,assign) NSString *age;
/**用户是否被停用(0->false,1->true) */
@property (nonatomic,assign) BOOL isstop; //bu tong

/** 推荐人 */
@property (nonatomic,copy) NSString *referee;


/** 上次修改时间 */
@property (nonatomic,copy) NSString *lasttime;

/** 会话创建时间 */
@property (nonatomic,copy) NSString *createtime;



/** 员工姓名 */
@property (nonatomic,copy) NSString *membername;

/** 用户图像信息修改 */
@property (nonatomic,copy) NSString *headimage;


//额外属性
/** 左边的按钮是否选中 */
@property (nonatomic,assign,getter=isSelected) BOOL selectedBtn;


/** 记录更改个人信息选中的第几组数据 */
@property (nonatomic,assign) NSInteger number;

/** 会员等级 */
@property (nonatomic,assign) NSInteger viplevel;





/** 登录用户名 */
@property (nonatomic,copy) NSString *username;
/** 终端 */
@property (nonatomic,copy) NSString *terminal;
/** 登录时间 */
@property (nonatomic,assign) NSInteger logintime;




/** 会话id */
@property (nonatomic,assign) NSInteger sessionid;
/** 用户id */
@property (nonatomic,assign) NSInteger userid;
/** 登录ip */
@property (nonatomic,copy) NSString *loginip;

/** 会话活动时间 */
@property (nonatomic,assign) NSInteger activetime;
/** 手机的序列码 */
@property (nonatomic,copy) NSString *macid;

@end













