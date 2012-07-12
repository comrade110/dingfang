//
//  DingDanViewController.h
//  dingfang
//
//  Created by user on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dfLoginBtnDelegate.h"

@interface DingDanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{


    NSObject<dfLoginBtnDelegate> * delegate;
    UITableView *orderTableView;
    NSArray *ddArr;
    UITableViewCell *cell;
}

@property (strong, nonatomic) NSObject<dfLoginBtnDelegate> * delegate;
- (IBAction)colseView:(id)sender;
- (IBAction)logoutAction:(id)sender;

@end
