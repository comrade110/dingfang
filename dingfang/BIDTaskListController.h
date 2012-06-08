//
//  BIDTaskListController.h
//  dingfang
//
//  Created by user on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "IntroViewController.h"
#import "IntroTabViewController.h"

@interface BIDTaskListController : UIViewController<UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,UIScrollViewDelegate>
{
    NSMutableArray *cityArr;
    NSString *cityV;
    NSMutableArray *hotelArr;
    NSMutableDictionary *item;
    NSMutableDictionary *item2;
    NSString *orderParameter;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
    
    IBOutlet UITableView *listView;
}


@property (strong, nonatomic) IBOutlet UITableView *listView;
@property (strong, nonatomic) IBOutlet UIButton *areaButton;
@property (strong, nonatomic) NSMutableArray *cityArr;
@property (strong, nonatomic) NSString *cityV;
@property (strong, nonatomic) NSMutableArray *hotelArr;
@property (strong, nonatomic) NSString *orderParameter;
- (IBAction)orderByPrice:(id)sender;
- (IBAction)orderByTime:(id)sender;

@end
