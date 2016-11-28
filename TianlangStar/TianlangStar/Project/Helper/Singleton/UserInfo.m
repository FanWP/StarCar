
//单例模式的实现

#import "UserInfo.h"
#define UserNameKey @"USER_NAME"
#define PwdKey @"PASSWORD"
#define sessionID @"sessionID"
#define publicKEY @"publicKEY"
#define HouseRouseA @"HouseRouseA"
#define selectedHouseA @"selectedHouseID"
#define RSASessionID @"RSASessionID"
#define userId @"userId"
#define userTYpe @"USerTYPE"
#define EmployeeName @"EmployeeName"
#define Headerpic @"Headerpic"
//#import <MJExtension.h>

@implementation UserInfo
singleton_implementation(UserInfo);

-(void)synchronizeToSandBox{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.username forKey:UserNameKey];
    [defaults setObject:self.passWord forKey:PwdKey];
    [defaults setObject:self.sessionId forKey:sessionID];
    [defaults setObject:self.publicKey forKey:publicKEY];
    [defaults setObject:self.RSAsessionId forKey:RSASessionID];
    [defaults setObject:self.userID forKey:userId];
//    [defaults setObject:self.userType forKey:userTYpe];
    [defaults setInteger:self.userType forKey:userTYpe];
    [defaults setObject:self.membername forKey:EmployeeName];
    [defaults setObject:self.headerpic forKey:Headerpic];
    [defaults setBool:self.isLogin forKey:@"isLogin"];
    [defaults setBool:self.isQuit forKey:@"isQuit"];
    [defaults synchronize];
}

-(void)loadDataFromSandBox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.username = [defaults objectForKey:UserNameKey];
    self.passWord = [defaults objectForKey:PwdKey];
    self.sessionId = [defaults objectForKey:sessionID];
    self.publicKey = [defaults objectForKey:publicKEY];
    self.RSAsessionId = [defaults objectForKey:RSASessionID];
    self.userID = [defaults objectForKey:userId];
//    self.userType = [defaults objectForKey:userTYpe];
    self.userType = [defaults integerForKey:userTYpe];
    self.headerpic = [defaults objectForKey:Headerpic];
    self.membername = [defaults objectForKey:EmployeeName];
    self.isLogin = [defaults boolForKey:@"isLogin"];
    self.isQuit = [defaults boolForKey:@"isQuit"];
}


///**
// *  当一个对象要归档进沙盒中时，就会调用这个方法
// *  目的：在这个方法中说明这个对象的哪些属性要存进沙盒
// */
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    [encoder encodeObject:self.username forKey:UserNameKey];
//    [encoder encodeObject:self.passWord forKey:PwdKey];
//    [encoder encodeObject:self.sessionId forKey:sessionID];
//    [encoder encodeObject:self.publicKey forKey:publicKEY];
//    [encoder encodeObject:self.HouseRouseArr forKey:HouseRouseA];
//    [encoder encodeObject:self.selectedHouseID forKey:selectedHouseA];
//}
//
///**
// *  当从沙盒中解档一个对象时（从沙盒中加载一个对象时），就会调用这个方法
// *  目的：在这个方法中说明沙盒中的属性该怎么解析（需要取出哪些属性）
// */
//- (id)initWithCoder:(NSCoder *)decoder
//{
//    if (self = [super init]) {
//        self.username = [decoder decodeObjectForKey:UserNameKey];
//        self.passWord = [decoder decodeObjectForKey:PwdKey];
//        self.sessionId = [decoder decodeObjectForKey:sessionID];
//        self.publicKey = [decoder decodeObjectForKey:publicKEY];
//        self.HouseRouseArr = [decoder decodeObjectForKey:HouseRouseA];
//        self.selectedHouseID = [decoder decodeObjectForKey:selectedHouseA];
//    }
//    return self;
//}


@end
