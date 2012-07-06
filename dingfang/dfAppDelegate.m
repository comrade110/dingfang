//
//  dfAppDelegate.m
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "dfAppDelegate.h"
#import "IntroViewController.h"
#import "AlixPay.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <sys/utsname.h>

@interface dfAppDelegate ()

- (BOOL)isSingleTask;
- (void)parseURL:(NSURL *)url application:(UIApplication *)application;

@end

@implementation dfAppDelegate

@synthesize window = _window;

- (BOOL)isSingleTask{
	struct utsname name;
	uname(&name);
	float version = [[UIDevice currentDevice].systemVersion floatValue];//判定系统版本。
	if (version < 4.0 || strstr(name.machine, "iPod1,1") != 0 || strstr(name.machine, "iPod2,1") != 0) {
		return YES;
	}
	else {
		return NO;
	}
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    SDZUserService *userService = [SDZUserService service];
    userService.logging = YES;
    [userService createSession:self action:@selector(createSessionHandler:)];
    
    

    
    // 判断用户是否登录  0为未登录  1为登录
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    
    int  isLogin = 0;
    [SaveDefaults setInteger:isLogin forKey:@"isLogin"];
    
    
    /*
	 *单任务handleURL处理
	 */
	if ([self isSingleTask]) {
		NSURL *url = [launchOptions objectForKey:@"UIApplicationLaunchOptionsURLKey"];
		
		if (nil != url) {
			[self parseURL:url application:application];
		}
	}

    
    return YES;
}

- (void) createSessionHandler:(id)value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"error:%@", value);
		return;
	}
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"fault:%@", value);
		return;
	}
    NSString *userSession = (NSString *)value;
    
    NSLog(@"%@",userSession);
    SDZUserService *userService = [SDZUserService service];
    userService.logging = YES;
    
    [userService noOperation:self action:nil sessionId:userSession];
    
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject:userSession forKey:@"userSessionKey"];
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	
	[self parseURL:url application:application];
	return YES;
}


- (void)parseURL:(NSURL *)url application:(UIApplication *)application {
	AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//是否支付成功
		if (9000 == result.statusCode) {
			/*
			 *用公钥验证签名
			 */
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *zhifubao_rsa_alipay_public_ava = [userDefaults objectForKey:@"zhifubao_rsa_alipay_public"];
			id<DataVerifier> verifier = CreateRSADataVerifier(zhifubao_rsa_alipay_public_ava);
			if ([verifier verifyString:result.resultString withSign:result.signString]) {
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
																	 message:result.statusMessage 
																	delegate:nil 
														   cancelButtonTitle:@"确定" 
														   otherButtonTitles:nil];
				[alertView show];
			}//验签错误
			else {
				UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
																	 message:@"签名错误@@" 
																	delegate:nil 
														   cancelButtonTitle:@"确定" 
														   otherButtonTitles:nil];
				[alertView show];
			}
		}
		//如果支付失败,可以通过result.statusCode查询错误码
		else {
			UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
																 message:result.statusMessage 
																delegate:nil 
													   cancelButtonTitle:@"确定" 
													   otherButtonTitles:nil];
			[alertView show];
		}
		
	}	
}

							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
