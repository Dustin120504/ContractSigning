//
//  ApiPort.h
//  HDemoProject
//
//  Created by James on 2019/3/5.
//  Copyright © 2019年 JamesWu. All rights reserved.
//

#ifndef HApiPort_h
#define HApiPort_h
#define baseServerUrl @"http://172.16.16.23:8084"

#define F(string, args...)                  [NSString stringWithFormat:string, args]

#define Malling_package F(@"%@%@",baseServerUrl,@"/xyg/face/max/package")//思图大礼包
#define Malling_compare F(@"%@%@",baseServerUrl,@"/xyg/face/compare")//思图人脸对比
#endif
