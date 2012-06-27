//
//  loginViewController.m
//  dingfang
//
//  Created by user on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

@synthesize userPhoneID, userPW, ruserPhoneID, ruserID, ruserPWCheck,ruserPW, mobileVerify,loginBtn, registerBtn, loginView,registerView;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    userPhoneID.delegate =self;
//    [userPhoneID becomeFirstResponder];
    [registerView removeFromSuperview];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer: tapGestureRecognizer]; 
    [tapGestureRecognizer setCancelsTouchesInView:NO];   // avoid UITapGestureRecognizer in button
    
    userService = [SDZUserService service];
    
    userService.logging = YES;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    mySession = [userDefaults objectForKey:@"userSessionKey"];
    
    
}

- (void)hideKeyBoard:(id)sender
{
    [userPhoneID  resignFirstResponder];
    [userPW  resignFirstResponder];
    [ruserPhoneID  resignFirstResponder];
    [ruserID  resignFirstResponder];
    [ruserPW  resignFirstResponder];
    [ruserPWCheck  resignFirstResponder];
    [mobileVerify  resignFirstResponder];
}


#pragma mark - 点击按钮事件

// 登录按钮点击后事件
-(IBAction)btnPress:(id)sender
{
    
	if ([self isLoginFieldOK]) {
        
        [userService userLogin:self action:@selector(userLoginHandler:) sessionId:mySession mobile:userPhoneID.text password:userPW.text];

    }
    
  
    
    [self writePlist];
    
}
// 注册提交按钮点击后事件
-(IBAction)submitBtnPress:(id)sender
{        
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *yanzhengma = [userDefaults objectForKey:@"yanzhengma"];
    
    NSLog(@"%@",mobileVerify.text);
    
    NSLog(@"%@",yanzhengma);
    
//  忽略大小写 全转为小写    

    if (yanzhengma == nil || [[mobileVerify.text lowercaseString] isEqualToString:[yanzhengma lowercaseString]] == NO ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"验证码不正确。请重新输入" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return;
    }
    
    if ([self isAllFieldOk]) {
        [userService findMobileIsUsed:self action:@selector(findMobileIsUsedHandler:) sessionId:mySession userId:nil mobile:ruserPhoneID.text];  
        
        [userService findNickNameIsUsed:self action:@selector(findNickNameIsUsedHandler:) sessionId:mySession userId:nil nickName:ruserID.text];

        [userService saveRegisterUser:self action:@selector(saveRegisterUserHandler:) sessionId:mySession nickName:ruserID.text mobile:ruserPhoneID.text password:ruserPW.text identityNo:@"" autoLogin:@"false"];
    }
        
   

}


-(IBAction)regBtnPress:(id)sender
{
    [userPhoneID resignFirstResponder];
    [userPW resignFirstResponder];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [animation setSubtype:kCATransitionFromRight];
    
    [loginView removeFromSuperview];
    [self.view addSubview:registerView];
    [[self.view layer] addAnimation:animation forKey:@"switch"];
}

-(IBAction)regBackBtnPress:(id)sender
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [animation setSubtype:kCATransitionFromLeft];
    
    [registerView removeFromSuperview];
    [self.view addSubview:loginView];
    [[self.view layer] addAnimation:animation forKey:@"switch"];
}

-(IBAction)regValidatekBtnPress:(id)sender
{
    if ([self isMobileNumber:ruserPhoneID.text] == NO) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"请填写正确的手机号码。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
    }else {
        
        [userService sendMobileValidateCode:self action:@selector(sendMobileValidateCodeHandler:) sessionId:mySession mobile:ruserPhoneID.text];
    }
    
    
}



#pragma mark -  用户输入判断

//  判断手机号

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else 
    {
        return NO;
    }
}

- (BOOL)isLoginFieldOK
{
	if ([userPW.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }    
    if ([self isMobileNumber:userPhoneID.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"请填写正确的手机号码。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return NO;
    }
    return YES;
}

- (BOOL)isAllFieldOk
{
    //    NSCharacterSet *disallowedCharacters = [[NSCharacterSet
    //                                             characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSCharacterSet *disallowedCharacters2 = [[NSCharacterSet
                                              characterSetWithCharactersInString:@"0123456789QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm"] invertedSet];
    //    NSRange foundRange = [ruserPhoneID.text rangeOfCharacterFromSet:disallowedCharacters];
    NSRange foundRange2 = [ruserPW.text rangeOfCharacterFromSet:disallowedCharacters2];
    NSRange foundRange3 = [ruserID.text rangeOfCharacterFromSet:disallowedCharacters2];
    if ([self isMobileNumber:ruserPhoneID.text] == NO) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"请填写正确的手机号码。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return NO;
    }
    
    
	if ([ruserPW.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    if (foundRange2.location != NSNotFound || ([ruserPW.text length] > 0 && [ruserPW.text length] < 6)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"密码应为大于5位数的数字或字母组合" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return NO;
    }
    
    
    NSLog(@"ruserPW.text = %@\nruserPW.text = %@",ruserPW.text,ruserPWCheck.text);
    if (![ruserPW.text isEqualToString:ruserPWCheck.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"两次输入的密码不同" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
    }
    
    if (foundRange3.location != NSNotFound || ([ruserID.text length] > 1 && [ruserID.text length] > 30)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"用户名长度应为0-30个字符。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return NO;
    }
    return YES;

}

#pragma mark - 登录判断

- (void) userLoginHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"账号密码不对吧！" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"账号密码不对吧" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
		return;
	}				
    
    
	// Do something with the SDZUser* result
    SDZUser* result = (SDZUser*)value;

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userID;
    userID = [NSString stringWithFormat:@"%lld",result._id];
    
    [userDefaults setInteger:result.grade forKey:@"grade"];
    [userDefaults setObject:result.nickName forKey:@"nickName"];
    [userDefaults setDouble:result.score forKey:@"score"];
    [userDefaults setDouble:result.money forKey:@"money"];
    [userDefaults setObject:result.lastLoginTime forKey:@"lastLoginTime"];
    [userDefaults setObject:userID forKey:@"userID"];
    
    int  isLogin = 1;
    
     [userDefaults setInteger:isLogin forKey:@"isLogin"];
    
    
    
    [delegate passValue:result.nickName];
    NSLog(@"self.value.text is%@", result.nickName);
    
    
    [self dismissModalViewControllerAnimated:YES];   
    
    
}



#pragma mark - 注册判断

-(void)findMobileIsUsedHandler:(NSString*)value
{
    
        NSLog(@"henwen %@",value);
    
//    NSString *isUsed = [NSString stringWithFormat:@"%@",[NSNumber numberWithBool:value]];
    

    if ( [value isEqualToString:@"false"]) {
        NSLog(@"手机号码可以使用");
        
    }else if([value isEqualToString:@"true"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"该手机号码已被使用。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return;
    }
   
}

- (void) findNickNameIsUsedHandler: (NSString*) value {
    
    NSString *result = value;
    
    
    if ( [result isEqualToString:@"false"]) {
        NSLog(@"用户名可以使用");   
        
    }else if ( [result isEqualToString:@"true"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"用户名已经存在。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        
        NSLog(@"为什么执行2次！！！！");
        return;
    }
    
}


- (void) sendMobileValidateCodeHandler: (id) value {
    
    NSString *result = (NSString*) value;
    // Handle errors
	if([value isKindOfClass:[NSError class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"验证信息出错。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        NSLog(@"123 %@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"验证出错。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        NSLog(@"543345 %@", value);
		return;
	}
    
        
        NSLog(@"---%@----",result);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"短息验证码已发送，请注意查收。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:result forKey:@"yanzhengma"];
    
}


- (void) saveRegisterUserHandler: (id) value{
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"注册失败。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        NSLog(@"123 %@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"注册失败鸟。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        NSLog(@"543345 %@", value);
		return;
	}		
    NSMutableArray *result = (NSMutableArray*)value;
    
    if (result != nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"注册成功。" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        
        NSLog(@"%@",result);
        [registerView removeFromSuperview];
        [self.view addSubview:loginView];
    }

}

// 注册功能实现


- (void)writePlist
{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSLog(@"%@", documentsDirectory);
    
    NSString *filePath = [documentsDirectory stringByAppendingString:@"/userData.plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableDictionary *plistDict;
    
    if ([fileManager fileExistsAtPath: filePath])
    {
        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }else{
        plistDict = [[NSMutableDictionary alloc] init];
    }
//    //先查看是否已有obj在plist內
//    if ([plistDict objectForKey:name])
//    {
//        newUserLabel.text = [NSString stringWithFormat:@"%@ is already in list", name];
//    }
//    else
//    {
//        //向動態字典追加參數
//        [plistDict setObject:password forKey:name];
//        //把剛追加之參數寫入file
//        if ([plistDict writeToFile:filePath atomically: YES]) {
//            newUserLabel.text = [NSString stringWithFormat:@"User %@ create success!", name];
//            NSLog(@"writePlist success");
//        } else {
//            NSLog(@"writePlist fail");
//        }
//    }
//    //釋放記憶體
//    [plistDict release];
//}

}

//- (void)readPlist :(NSString *)name :(NSString *)password
//{
//    NSString *checkPassword;
//    
//    //取得檔案路徑
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectory stringByAppendingString:@"/userData.plist"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSMutableDictionary *plistDict;
//    //檢查檔案是否存在
//    if ([fileManager fileExistsAtPath: filePath])
//    {
//        NSLog(@"File here.");
//        //存在的話把plist中的資料取出並寫入動態字典plistDict
//        plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
//    }else{
//        NSLog(@"File not here.");
//        plistDict = [[NSMutableDictionary alloc] init];
//    }
//    
//    //使用objectForKey以關鍵字取得其value
//    checkPassword = [plistDict objectForKey:name];
//    
//    //使用isEqualToString比對輸入
//    if ([checkPassword isEqualToString:password])
//    {
//        loginLabel.text = [NSString stringWithFormat:@"%@ login ok!", name];
//    }
//    else
//    {
//        loginLabel.text = [NSString stringWithFormat:@"登入名稱或密碼錯誤！"]; 
//    }
//    [plistDict release];
//}




- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
