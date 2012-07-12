//
//  dfAppDelegate.h
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZUserService.h"

@class IntroViewController;

@interface dfAppDelegate : UIResponder <UIApplicationDelegate>{

    NSString *userSession;
    
    NSString *resultEncrypt;
    
    NSString *orderNumber;
    
    
}

@property (strong, nonatomic) NSString *resultEncrypt;;
@property (strong, nonatomic) NSString *orderNumber;;
@property (strong, nonatomic) UIWindow *window;

@end
