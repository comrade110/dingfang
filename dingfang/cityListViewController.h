//
//  cityListViewController.h
//  dingfang
//
//  Created by user on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cityListViewController : UITableViewController{
    
    NSString *userSession;
    NSMutableArray *cityArr;
    NSString *citySelTag;
    
}

@property (nonatomic, strong) NSString *userSession;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, copy) NSString *citySelTag;


@end
