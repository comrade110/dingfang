//
//  dfViewController.h
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZUserService.h"
#import "dfLoginBtnDelegate.h"


@interface dfViewController : UIViewController<dfLoginBtnDelegate>{
    IBOutlet UINavigationItem *navigationItem;
    UIBarButtonItem *loginBtn;
    IBOutlet UIButton *hotelOrderBtn;
    UIBarButtonItem *userBtn;

}
@property(nonatomic,retain) UIBarButtonItem *loginBtn;
@property(nonatomic,retain) IBOutlet UIButton *hotelOrderBtn;
@property(nonatomic,retain) UIBarButtonItem *userBtn;



@end
