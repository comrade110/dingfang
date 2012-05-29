/*
	SDZArrayOfHotel.h
	The implementation of properties and methods for the SDZArrayOfHotel array.
	Generated by SudzC.com
*/
#import "SDZArrayOfHotel.h"

#import "SDZHotel.h"
@implementation SDZArrayOfHotel

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[SDZArrayOfHotel alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				SDZHotel* value = [[SDZHotel newWithNode: child] object];
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
			[s appendString: [item serialize: @"Hotel"]];
		}
		return s;
	}
@end
