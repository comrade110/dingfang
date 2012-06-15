/*
	SDZstring2UserMap.h
	The implementation of properties and methods for the SDZstring2UserMap array.
	Generated by SudzC.com
*/
#import "SDZstring2UserMap.h"

#import "SDZUser.h"
@implementation SDZstring2UserMap

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[SDZstring2UserMap alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				NSString* value = [child stringValue];
				[self addObject: value];
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [[item stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		}
		return s;
	}
@end