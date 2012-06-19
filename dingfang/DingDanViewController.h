//
//  DingDanViewController.h
//  dingfang
//
//  Created by user on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZUserService.h"
#import "dfLoginBtnDelegate.h"

@interface DingDanViewController : UIViewController{


    NSObject<dfLoginBtnDelegate> * delegate;
}

@property (strong, nonatomic) NSObject<dfLoginBtnDelegate> * delegate;

- (IBAction)colseView:(id)sender;
- (IBAction)logoutAction:(id)sender;

@end
