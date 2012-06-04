//
//  BIDTaskListController.h
//  dingfang
//
//  Created by user on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cityListViewController.h"


@interface BIDTaskListController : UITableViewController <CityListViewControllerDelegate>
{
    NSMutableArray *cityArr;
    NSString *cityV;
}


@property (strong, nonatomic) IBOutlet UIButton *areaButton;
@property (strong, nonatomic) IBOutlet NSMutableArray *cityArr;
@property (strong, nonatomic) IBOutlet NSString *cityV;



@end
