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
    NSString *userSession;
    NSMutableArray *cityArr;
}
@property (nonatomic, retain) IBOutlet UITextField *field;
@property (nonatomic, strong) NSString *userSession;
- (IBAction)buttonPressed:(id)sender;
- (void) createSessionHandler: (id) value;
@end
