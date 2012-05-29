/*
	SDZYuDingRoomService.h
	The interface definition of classes and methods for the YuDingRoomService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				
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

/* Interface for the service */
				
@interface SDZYuDingRoomService : SoapService
		
	/* Returns long.  */
	- (SoapRequest*) countYuDingRoomLogInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime;
	- (SoapRequest*) countYuDingRoomLogInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime;

	/* Returns NSString*.  */
	- (SoapRequest*) findHotelInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId;
	- (SoapRequest*) findHotelInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (long) hotelId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findYuDingRoomByCondition: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice orderByCondition: (NSString*) orderByCondition pageNo: (int) pageNo perPageNum: (int) perPageNum;
	- (SoapRequest*) findYuDingRoomByCondition: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice orderByCondition: (NSString*) orderByCondition pageNo: (int) pageNo perPageNum: (int) perPageNum;

	/* Returns NSString*.  */
	- (SoapRequest*) findYuDingRoomInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId roomId: (long) roomId;
	- (SoapRequest*) findYuDingRoomInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId roomId: (long) roomId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findHotelByCity: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId city: (NSString*) city;
	- (SoapRequest*) findHotelByCity: (id) target action: (SEL) action sessionId: (NSString*) sessionId city: (NSString*) city;

	/* Returns NSString*.  */
	- (SoapRequest*) findYuDingRoomLogInfo: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime pageNo: (int) pageNo perPageNum: (int) perPageNum;
	- (SoapRequest*) findYuDingRoomLogInfo: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId cityName: (NSString*) cityName startTime: (NSString*) startTime endTime: (NSString*) endTime pageNo: (int) pageNo perPageNum: (int) perPageNum;

	/* Returns BOOL.  */
	- (SoapRequest*) saveYuDingComment: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId userId: (long) userId evaluate: (int) evaluate environment: (int) environment service: (int) service comment: (NSString*) comment;
	- (SoapRequest*) saveYuDingComment: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (long) hotelId userId: (long) userId evaluate: (int) evaluate environment: (int) environment service: (int) service comment: (NSString*) comment;

	/* Returns long.  */
	- (SoapRequest*) countYuDingCommmentByHotel: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId;
	- (SoapRequest*) countYuDingCommmentByHotel: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (long) hotelId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findYuDingCommentByHotel: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (long) hotelId pageNo: (int) pageNo perPageNum: (int) perPageNum;
	- (SoapRequest*) findYuDingCommentByHotel: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (long) hotelId pageNo: (int) pageNo perPageNum: (int) perPageNum;

	/* Returns BOOL.  */
	- (SoapRequest*) bookRoom: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId roomId: (NSString*) roomId userId: (NSString*) userId;
	- (SoapRequest*) bookRoom: (id) target action: (SEL) action sessionId: (NSString*) sessionId roomId: (NSString*) roomId userId: (NSString*) userId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllCity: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId;
	- (SoapRequest*) findAllCity: (id) target action: (SEL) action sessionId: (NSString*) sessionId;

	/* Returns long.  */
	- (SoapRequest*) countYuDingRoomByCondition: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice;
	- (SoapRequest*) countYuDingRoomByCondition: (id) target action: (SEL) action sessionId: (NSString*) sessionId hotelId: (NSString*) hotelId hotelName: (NSString*) hotelName cityName: (NSString*) cityName hotelDengJi: (NSString*) hotelDengJi minPrice: (NSString*) minPrice maxPrice: (NSString*) maxPrice;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllHotelGroupByCity: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId;
	- (SoapRequest*) findAllHotelGroupByCity: (id) target action: (SEL) action sessionId: (NSString*) sessionId;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) findAllHotelDengJi: (id <SoapDelegate>) handler sessionId: (NSString*) sessionId;
	- (SoapRequest*) findAllHotelDengJi: (id) target action: (SEL) action sessionId: (NSString*) sessionId;

		
	+ (SDZYuDingRoomService*) service;
	+ (SDZYuDingRoomService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	