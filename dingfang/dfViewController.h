//
//  dfViewController.h
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface dfViewController : UIViewController{
    IBOutlet UIBarButtonItem *loginBtn;
    IBOutlet UIButton *hotelOrderBtn;

}
@property(nonatomic,retain) IBOutlet UIBarButtonItem *loginBtn;
@property(nonatomic,retain) IBOutlet UIButton *hotelOrderBtn;

@end
