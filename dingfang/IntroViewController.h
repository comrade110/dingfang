//
//  IntroViewController.h
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZYuDingRoomService.h"
#import "NSString.h"
#import "JSONKit.h"
#include <CommonCrypto/CommonCryptor.h>
#import "iToast.h"
#import "dfAppDelegate.h"



@interface IntroViewController : UIViewController<UIScrollViewDelegate,UITabBarControllerDelegate>
{
    IBOutlet UIScrollView *scrollView;
	IBOutlet UIScrollView *imageScrollView;
    IBOutlet UIPageControl *pageControl;
	NSMutableArray *viewControllers;
    BOOL pageControlUsed;
    UIView *orderView;
    
    NSString *keyVal;
    
    NSString *myDesc;    
    NSString *myAddress; 
    NSString *myHotelName;
    NSString *myRoomType;    
    NSString *myFax;    
    NSString *myPhone;    
    NSString *myPrice;    
    NSString *myNum;    
    NSString *myHotelID; 
    NSString *myRoomID;
    NSString *myUserID;
    NSString *orderNumber;
    
    NSString *mySession;
    
    NSString *resultEncrypt;
    dfAppDelegate *apd;
    
    NSMutableDictionary *item;
    NSMutableDictionary *item2;
    
    UITextField *payNumField;    //  付款按钮
    
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *imageScrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;
@property (nonatomic, retain) IBOutlet UITabBarItem *firstTabBarItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *secondTabBarItem;
@property (nonatomic, retain) IBOutlet UITabBarItem *thirdTabBarItem;
@property (nonatomic, retain) NSString *resultEncrypt;
@property (nonatomic, retain) NSString *orderNumber;
@property (nonatomic, retain) dfAppDelegate *apd;

- (IBAction)changePage:(id)sender;
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end
