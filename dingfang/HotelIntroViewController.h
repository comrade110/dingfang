//
//  HotelIntroViewController.h
//  dingfang
//
//  Created by user on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZYuDingRoomService.h"


@interface HotelIntroViewController : UIViewController<UIScrollViewDelegate>{

    IBOutlet UIScrollView *scrollView;
	IBOutlet UIScrollView *imageScrollView;
    IBOutlet UIPageControl *pageControl;
	NSMutableArray *viewControllers;
    BOOL pageControlUsed;
    NSString *mySession;
    NSMutableArray *imgArr;
    
    NSTimer *timer;
}

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIScrollView *imageScrollView;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic, retain) NSMutableArray *viewControllers;


- (IBAction)changePage:(id)sender;
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;




@end
