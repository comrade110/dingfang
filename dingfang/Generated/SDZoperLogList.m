/*
	SDZoperLogList.h
	The implementation of properties and methods for the SDZoperLogList array.
	Generated by SudzC.com
*/
#import "SDZoperLogList.h"

#import "SDZOperLog.h"
@implementation SDZoperLogList

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[SDZoperLogList alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZOperLog* value = [[SDZOperLog newWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"OperLog"]];
		}
		return s;
	}
@end
