
//  记录保存用户名。密码及sessionID

#import <Foundation/Foundation.h>
#import "Singleton.h"


@interface UserInfo : NSObject
singleton_interface(UserInfo);

/** 当前用的等级 */
@property(nonatomic,assign)NSInteger viplevel;

/** 登录用户名 */
@property(nonatomic,copy)NSString *username;
/** 员工姓名 */
@property(nonatomic,copy)NSString *membername;
/** 用户头像URL */
@property(nonatomic,copy)NSString *headerpic;
/** 密码 */
@property(nonatomic,copy)NSString *passWord;
/** 会话ID */
@property(nonatomic,copy)NSString *sessionId;
/** 公钥 */
@property(nonatomic,copy)NSString *publicKey;
/** RSA加密过的公钥公钥 */
@property(nonatomic,copy)NSString *RSAsessionId;
/** 当前登录用户的ID */
@property(nonatomic,copy)NSString *userID;

/** 当前登录用户的折扣 */
@property(nonatomic,assign)CGFloat discount;

/** 当前用户的类型  0-老板 1-店长 2- 用户*/
@property (nonatomic,assign) NSInteger userType;

/** 服务电话 */
@property (nonatomic,copy) NSString *telephone;

// 是否为登录状态
@property (nonatomic,assign) BOOL isLogin;

// 是否为是退出
@property (nonatomic,assign) BOOL isQuit;

@property (nonatomic,copy) NSString *registrationID;// 极光注册id


/**
 数据保存到沙盒，保存运行内存与沙盒的数据同步
 */
-(void)synchronizeToSandBox;

/*
 *程序一启动时从沙盒获取数据
 */
-(void)loadDataFromSandBox;


@end
