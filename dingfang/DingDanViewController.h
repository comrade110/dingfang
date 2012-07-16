//
//  DingDanViewController.h
//  dingfang
//
//  Created by user on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dfLoginBtnDelegate.h"
#import "DDTableViewController.h"

@interface DingDanViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{


    NSObject<dfLoginBtnDelegate> * delegate;
    IBOutlet UINavigationBar *navBar;
    UITableView *orderTableView;
    NSArray *ddArr;
    UITableViewCell *cell;
    NSString *nowTime;
    NSString *firstDateTime;
    NSString *secondDateTime;
    NSMutableDictionary *item;
    NSMutableArray *itemArr;
    DDTableViewController *ddTableViewController;
}

@property (strong, nonatomic) NSObject<dfLoginBtnDelegate> * delegate;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)colseView:(id)sender;
- (IBAction)logoutAction:(id)sender;

@end
