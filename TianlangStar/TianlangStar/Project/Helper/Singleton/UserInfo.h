
//  记录保存用户名。密码及sessionID

#import <Foundation/Foundation.h>
#import "Singleton.h"


@interface UserInfo : NSObject
singleton_interface(UserInfo);

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

/** 当前用户的类型 */
@property (nonatomic,assign) NSInteger userType;

// 是否为登录状态
@property (nonatomic,assign) BOOL isLogin;

// 是否为是退出
@property (nonatomic,assign) BOOL isQuit;


///** 接收到的房源管理数据 */
//@property (nonatomic,strong) NSArray *HouseRouseArr;
//
///** 用户选中的houseID */
//@property (nonatomic,strong) NSArray *selectedHouseID;

/**
 数据保存到沙盒，保存运行内存与沙盒的数据同步
 */
-(void)synchronizeToSandBox;

/*
 *程序一启动时从沙盒获取数据
 */
-(void)loadDataFromSandBox;


@end
