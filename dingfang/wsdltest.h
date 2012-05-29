//
//  wsdltest.h
//  dingfang
//
//  Created by user on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZYuDingRoomService.h"
#import "SDZUserService.h"

@interface wsdltest : UIViewController{
    UITextField *field;
}
@property (nonatomic, retain) IBOutlet UITextField *field;
@property (nonatomic, strong) NSString *userID;
- (IBAction)buttonPressed:(id)sender;

@end
