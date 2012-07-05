//
//  CHKeychain.h
//  BNS
//
//  Created by Chenghaojun on 7/16/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface CHKeychain : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;


@end
