/*
	SDZYuDingComment.h
	The implementation of properties and methods for the SDZYuDingComment object.
	Generated by SudzC.com
*/
#import "SDZYuDingComment.h"

#import "SDZHotel.h"
#import "SDZUser.h"
@implementation SDZYuDingComment
	@synthesize comment = _comment;
	@synthesize environment = _environment;
	@synthesize evaluate = _evaluate;
	@synthesize hotel = _hotel;
	@synthesize _id = __id;
	@synthesize occurTime = _occurTime;
	@synthesize service = _service;
	@synthesize status = _status;
	@synthesize user = _user;

	- (id) init
	{
		if(self = [super init])
		{
			self.comment = nil;
			self.hotel = nil; // [[SDZHotel alloc] init];
			self.occurTime = nil;
			self.user = nil; // [[SDZUser alloc] init];

		}
		return self;
	}

	+ (SDZYuDingComment*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (SDZYuDingComment*)[[SDZYuDingComment alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.comment = [Soap getNodeValue: node withName: @"comment"];
			self.environment = [[Soap getNodeValue: node withName: @"environment"] intValue];
			self.evaluate = [[Soap getNodeValue: node withName: @"evaluate"] intValue];
			self.hotel = [[SDZHotel newWithNode: [Soap getNode: node withName: @"hotel"]] object];
			self._id = [[Soap getNodeValue: node withName: @"id"] longLongValue];
			self.occurTime = [Soap getNodeValue: node withName: @"occurTime"];
			self.service = [[Soap getNodeValue: node withName: @"service"] intValue];
			self.status = [[Soap getNodeValue: node withName: @"status"] intValue];
			self.user = [[SDZUser newWithNode: [Soap getNode: node withName: @"user"]] object];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"YuDingComment"];
	}
  
	- (NSMutableString*) serialize: (NSString*) nodeName
	{
		NSMutableString* s = [NSMutableString string];
		[s appendFormat: @"<%@", nodeName];
		[s appendString: [self serializeAttributes]];
		[s appendString: @">"];
		[s appendString: [self serializeElements]];
		[s appendFormat: @"</%@>", nodeName];
		return s;
	}
	
	- (NSMutableString*) serializeElements
	{
		NSMutableString* s = [super serializeElements];
		if (self.comment != nil) [s appendFormat: @"<comment>%@</comment>", [[self.comment stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<environment>%@</environment>", [NSString stringWithFormat: @"%i", self.environment]];
		[s appendFormat: @"<evaluate>%@</evaluate>", [NSString stringWithFormat: @"%i", self.evaluate]];
		if (self.hotel != nil) [s appendString: [self.hotel serialize: @"hotel"]];
		[s appendFormat: @"<id>%@</id>", [NSString stringWithFormat: @"%ld", self._id]];
		if (self.occurTime != nil) [s appendFormat: @"<occurTime>%@</occurTime>", [[self.occurTime stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<service>%@</service>", [NSString stringWithFormat: @"%i", self.service]];
		[s appendFormat: @"<status>%@</status>", [NSString stringWithFormat: @"%i", self.status]];
		if (self.user != nil) [s appendString: [self.user serialize: @"user"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[SDZYuDingComment class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end