/*
	SDZYuDingRoomService.m
	The implementation classes and methods for the YuDingRoomService web service.
	Generated by SudzC.com
*/

#import "SDZYuDingRoomService.h"
				
#import "Soap.h"
	
#import "SDZYuDingRoomList.h"
#import "SDZcityHotelList.h"
#import "SDZYuDingCommentList.h"
#import "SDZcityList.h"
#import "SDZhotelDengJiList.h"
#import "SDZArrayOfHotel.h"
#import "SDZYuDingRoom.h"
#import "SDZUser.h"
#import "SDZstring2ArrayOfHotelMap.h"
#import "SDZHotel.h"
#import "SDZYuDingComment.h"

/* Implementation of the service */
				
@implementation SDZYuDingRoomService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"http://192.168.3.3:9001/idc/services/YuDingRoomService";
			self.namespace = @"http://soap.additional/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (SDZYuDingRoomService*) service {
		return [SDZYuDingRoomService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (SDZYuDingRoomService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[SDZYuDingRoomService alloc] initWithUsername:username andPassword:password];
	}

		
	/* Returns long.  */
	- (SoapRequest*) countYuDingRoomLogInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime
	{
		return [self countYuDingRoomLogInfo: handler action: nil sessionId: sessionId hotelId: hotelId cityName: cityName startTime: startTime endTime: endTime];
	}

	- (SoapRequest*) countYuDingRoomLogInfo: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelId forName: @"hotelId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: cityName forName: @"cityName"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: startTime forName: @"startTime"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: endTime forName: @"endTime"]];
		NSString* _envelope = [Soap createEnvelope: @"countYuDingRoomLogInfo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"long"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) findHotelInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId
	{
		return [self findHotelInfo: handler action: nil sessionId: sessionId hotelId: hotelId];
	}

	- (SoapRequest*) findHotelInfo: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (long) hotelId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: hotelId] forName: @"hotelId"]];
		NSString* _envelope = [Soap createEnvelope: @"findHotelInfo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findYuDingRoomByCondition: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice orderByCondition: (NSString*) orderByCondition pageNo: (int) pageNo perPageNum: (int) perPageNum
	{
		return [self findYuDingRoomByCondition: handler action: nil sessionId: sessionId hotelId: hotelId hotelName: hotelName cityName: cityName hotelDengJi: hotelDengJi minPrice: minPrice maxPrice: maxPrice orderByCondition: orderByCondition pageNo: pageNo perPageNum: perPageNum];
	}

	- (SoapRequest*) findYuDingRoomByCondition: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice orderByCondition: (NSString*) orderByCondition pageNo: (int) pageNo perPageNum: (int) perPageNum
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelId forName: @"hotelId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelName forName: @"hotelName"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: cityName forName: @"cityName"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelDengJi forName: @"hotelDengJi"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: minPrice forName: @"minPrice"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: maxPrice forName: @"maxPrice"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: orderByCondition forName: @"orderByCondition"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: pageNo] forName: @"pageNo"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: perPageNum] forName: @"perPageNum"]];
		NSString* _envelope = [Soap createEnvelope: @"findYuDingRoomByCondition" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZYuDingRoomList alloc]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) findYuDingRoomInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId roomId: (long) roomId
	{
		return [self findYuDingRoomInfo: handler action: nil sessionId: sessionId roomId: roomId];
	}

	- (SoapRequest*) findYuDingRoomInfo: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId roomId: (long) roomId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: roomId] forName: @"roomId"]];
		NSString* _envelope = [Soap createEnvelope: @"findYuDingRoomInfo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findHotelByCity: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId city: (NSString*) city
	{
		return [self findHotelByCity: handler action: nil sessionId: sessionId city: city];
	}

	- (SoapRequest*) findHotelByCity: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId city: (NSString*) city
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: city forName: @"city"]];
		NSString* _envelope = [Soap createEnvelope: @"findHotelByCity" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZcityHotelList alloc]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) findYuDingRoomLogInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime pageNo: (int) pageNo perPageNum: (int) perPageNum
	{
		return [self findYuDingRoomLogInfo: handler action: nil sessionId: sessionId hotelId: hotelId cityName: cityName startTime: startTime endTime: endTime pageNo: pageNo perPageNum: perPageNum];
	}

	- (SoapRequest*) findYuDingRoomLogInfo: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime pageNo: (int) pageNo perPageNum: (int) perPageNum
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelId forName: @"hotelId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: cityName forName: @"cityName"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: startTime forName: @"startTime"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: endTime forName: @"endTime"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: pageNo] forName: @"pageNo"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: perPageNum] forName: @"perPageNum"]];
		NSString* _envelope = [Soap createEnvelope: @"findYuDingRoomLogInfo" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns BOOL.  */
	- (SoapRequest*) saveYuDingComment: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId userId: (long) userId evaluate: (int) evaluate environment: (int) environment service: (int) service comment: (NSString*) comment
	{
		return [self saveYuDingComment: handler action: nil sessionId: sessionId hotelId: hotelId userId: userId evaluate: evaluate environment: environment service: service comment: comment];
	}

	- (SoapRequest*) saveYuDingComment: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (long) hotelId userId: (long) userId evaluate: (int) evaluate environment: (int) environment service: (int) service comment: (NSString*) comment
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: hotelId] forName: @"hotelId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: userId] forName: @"userId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: evaluate] forName: @"evaluate"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: environment] forName: @"environment"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: service] forName: @"service"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: comment forName: @"comment"]];
		NSString* _envelope = [Soap createEnvelope: @"saveYuDingComment" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"BOOL"];
		[_request send];
		return _request;
	}

	/* Returns long.  */
	- (SoapRequest*) countYuDingCommmentByHotel: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId
	{
		return [self countYuDingCommmentByHotel: handler action: nil sessionId: sessionId hotelId: hotelId];
	}

	- (SoapRequest*) countYuDingCommmentByHotel: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (long) hotelId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: hotelId] forName: @"hotelId"]];
		NSString* _envelope = [Soap createEnvelope: @"countYuDingCommmentByHotel" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"long"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
- (SoapRequest*) findYuDingCommentByHotel: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId pingJi:(int)pingJi pageNo: (int) pageNo perPageNum: (int) perPageNum
	{
		return [self findYuDingCommentByHotel: handler action: nil sessionId: sessionId hotelId: hotelId pingJi: pingJi pageNo: pageNo perPageNum: perPageNum];
	}

- (SoapRequest*) findYuDingCommentByHotel: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (long) hotelId pingJi: (int)pingJi pageNo: (int) pageNo perPageNum: (int) perPageNum
		{
		NSMutableArray* _params = [NSMutableArray array];
		
        [_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
        [_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithLong: hotelId] forName: @"hotelId"]];
        [_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: pingJi] forName: @"pingJi"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: pageNo] forName: @"pageNo"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: [NSNumber numberWithInt: perPageNum] forName: @"perPageNum"]];
		NSString* _envelope = [Soap createEnvelope: @"findYuDingCommentByHotel" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZYuDingCommentList alloc]];
		[_request send];
		return _request;
	}

	/* Returns BOOL.  */
	- (SoapRequest*) bookRoom: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId roomId: (NSString*) roomId userId: (NSString*) userId
	{
		return [self bookRoom: handler action: nil sessionId: sessionId roomId: roomId userId: userId];
	}

	- (SoapRequest*) bookRoom: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId roomId: (NSString*) roomId userId: (NSString*) userId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: roomId forName: @"roomId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: userId forName: @"userId"]];
		NSString* _envelope = [Soap createEnvelope: @"bookRoom" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"BOOL"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllCity: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId
	{
		return [self findAllCity: handler action: nil sessionId: sessionId];
	}

	- (SoapRequest*) findAllCity: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		NSString* _envelope = [Soap createEnvelope: @"findAllCity" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZcityList alloc]];
		[_request send];
		return _request;
	}

	/* Returns long.  */
	- (SoapRequest*) countYuDingRoomByCondition: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice
	{
		return [self countYuDingRoomByCondition: handler action: nil sessionId: sessionId hotelId: hotelId hotelName: hotelName cityName: cityName hotelDengJi: hotelDengJi minPrice: minPrice maxPrice: maxPrice];
	}

	- (SoapRequest*) countYuDingRoomByCondition: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelId forName: @"hotelId"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelName forName: @"hotelName"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: cityName forName: @"cityName"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: hotelDengJi forName: @"hotelDengJi"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: minPrice forName: @"minPrice"]];
		[_params addObject: [[SoapParameter alloc] initWithValue: maxPrice forName: @"maxPrice"]];
		NSString* _envelope = [Soap createEnvelope: @"countYuDingRoomByCondition" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: @"long"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllHotelGroupByCity: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId
	{
		return [self findAllHotelGroupByCity: handler action: nil sessionId: sessionId];
	}

	- (SoapRequest*) findAllHotelGroupByCity: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		NSString* _envelope = [Soap createEnvelope: @"findAllHotelGroupByCity" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZstring2ArrayOfHotelMap alloc]];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllHotelDengJi: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId
	{
		return [self findAllHotelDengJi: handler action: nil sessionId: sessionId];
	}

	- (SoapRequest*) findAllHotelDengJi: (id) _target action: (SEL) _action sessionId: (NSString*) sessionId
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[SoapParameter alloc] initWithValue: sessionId forName: @"sessionId"]];
		NSString* _envelope = [Soap createEnvelope: @"findAllHotelDengJi" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"" postData: _envelope deserializeTo: [SDZhotelDengJiList alloc]];
		[_request send];
		return _request;
	}


@end
	