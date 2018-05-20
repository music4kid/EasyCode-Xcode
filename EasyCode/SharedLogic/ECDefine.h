//
//  ECDefine.h
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSafeCast.h"

#ifndef ECDefine_H
#define ECDefine_H

#define kUseiCloudSync                @"kUseiCloudSync"
#define kVersionFormat                @"%@-version"

typedef NS_ENUM(NSInteger,ECSourceType) {
    ECSourceTypeOC,
    ECSourceTypeSwift
};

#define _STR(s)                 [ECSafeCast parseToString:s]
#define _INT(s)                 [ECSafeCast parseToIntValue:s]
#define _LONG(s)                [ECSafeCast parseTolongValue:s]
#define _BOOL(s)                [ECSafeCast parseToBOOLValue:s]
#define _FLOAT(s)               [ECSafeCast parseToFloatValue:s]
#define _NUMBER(s)              [ECSafeCast parseToNumValue:s]
#define _INTEGER(s)             [ECSafeCast parseToIntegerValue:s]
#define _LONGLONG(s)            [ECSafeCast parseTolongLongValue:s]
#define _DOUBLE(s)              [ECSafeCast parseToDoubleValue:s]
#define _ARRAY(s)               [ECSafeCast parseToArray:s]
#define _DIC(s)                 [ECSafeCast parseToDictionary:s]

#define APP_OBJ                 [NSApplication sharedApplication]
#define APP_DELEGATE            ((AppDelegate *)[APP_OBJ delegate])

#ifndef dispatch_main_sync_safe
#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
if(block){\
block();\
}\
}\
else {\
if(block){\
dispatch_sync(dispatch_get_main_queue(), block);\
}\
}
#endif

#ifndef dispatch_async_safe
#define dispatch_async_safe(block) \
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#endif



#endif /* ECDefine_H */


