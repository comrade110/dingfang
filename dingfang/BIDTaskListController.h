//
//  BIDTaskListController.h
//  dingfang
//
//  Created by user on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDTaskListController : UITableViewController<NSXMLParserDelegate> 
{


    
	NSMutableData *webData;
	NSMutableString *soapResults;
	NSXMLParser *xmlParser;
	BOOL recordResults;
}


@property (strong, nonatomic) NSArray *tasks;
@property (strong, nonatomic) NSArray *tasks2;
@property (strong, nonatomic) NSArray *areaArrs;
@property (strong, nonatomic) IBOutlet UIButton *areaButton;

@property(nonatomic, retain) NSMutableData *webData;
@property(nonatomic, retain) NSMutableString *soapResults;
@property(nonatomic, retain) NSXMLParser *xmlParser;
- (void)getOffesetUTCTimeSOAP;

@end
