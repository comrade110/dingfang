//
//  cityListViewController.h
//  dingfang
//
//  Created by user on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CityListViewControllerDelegate<NSObject>

-(void)cityValue:(NSString*)fromValue;

@end

@interface cityListViewController : UITableViewController{
    
    NSString *userSession;
    NSMutableArray *cityArr;
    id<CityListViewControllerDelegate> delegate;
    NSString *citySelTag;
    
}

@property (nonatomic, retain) id delegate; 
@property (nonatomic, strong) NSString *userSession;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSString *citySelTag;


@end
