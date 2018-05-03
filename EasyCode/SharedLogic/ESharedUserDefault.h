//
//  ESharedUserDefault.h
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESharedUserDefault : NSObject
+ (BOOL)boolForKey:(NSString*)key;
+ (id)objectForKey:(NSString*)key;
+ (id)dataForKey:(NSString*)key;
+ (id)stringForKey:(NSString*)key;

+ (void)setBool:(BOOL)value forKey:(NSString*)key;
+ (void)setObject:(NSObject*)value forKey:(NSString*)key;
+ (void)setObjects:(NSArray*)values forKeys:(NSArray*)keys;
@end
