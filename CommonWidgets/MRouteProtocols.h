//
//  MRouteProtocols.h
//  MBusiness
//
//  Created by jack zhou on 04/07/2017.
//  Copyright © 2017 jack zhou. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MRouteProtocols.h"
// 用于MDcotor类型的协议
@protocol SelectDoctorProtocol
@required
- (void)selectDoctor:(NSDictionary *)doctor;
@end

