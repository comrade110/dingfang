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
    NSMutableArray *hotelInfoArr;
}
@property (nonatomic, retain) IBOutlet UITextField *field;
@property (nonatomic, strong) NSString *userSession;
@property (nonatomic, strong) NSMutableArray *cityArr;
- (IBAction)buttonPressed:(id)sender;
@end
