/*
	SDZYuDingRoomList.h
	The implementation of properties and methods for the SDZYuDingRoomList array.
	Generated by SudzC.com
*/
#import "SDZYuDingRoomList.h"

#import "SDZYuDingRoom.h"
@implementation SDZYuDingRoomList

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[SDZYuDingRoomList alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZYuDingRoom* value = [[SDZYuDingRoom newWithNode: child] object];
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
			[s appendString: [item serialize: @"YuDingRoom"]];
		}
		return s;
	}
@end
