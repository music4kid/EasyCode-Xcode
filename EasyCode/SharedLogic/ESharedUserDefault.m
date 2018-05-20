//
//  ESharedUserDefault.m
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ESharedUserDefault.h"
#import "ECMappingForObjectiveC.h"
#import "ECMappingForSwift.h"

#define KeySharedContainerGroup         @"JW95CV255J.group.com.sito.easycode"
#define KeyCurrentUDVersion             @"KeyCurrentUDVersion"
#define ValueCurrentUDVersion           @"1"

@interface ESharedUserDefault ()
@property (nonatomic, strong) NSUserDefaults*                   sharedUD;
@end

@implementation ESharedUserDefault

+ (instancetype)sharedInstance
{
    static ESharedUserDefault* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ESharedUserDefault alloc] init];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSharedUD];
    }
    return self;
}

- (void)initSharedUD
{
    _sharedUD = [[NSUserDefaults alloc] initWithSuiteName:KeySharedContainerGroup];
    NSString* UIVersion = [_sharedUD objectForKey:KeyCurrentUDVersion];
    if (UIVersion == nil) {
        [_sharedUD setObject:ValueCurrentUDVersion forKey:KeyCurrentUDVersion];
    }
}

+ (BOOL)boolForKey:(NSString*)key
{
    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    return [shareUD boolForKey:key];
}

+ (id)objectForKey:(NSString*)key
{
    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    return [shareUD objectForKey:key];
}

+ (id)dataForKey:(NSString*)key {
    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    return [shareUD dataForKey:key];
}

+ (id)stringForKey:(NSString*)key {
    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    return [shareUD stringForKey:key];
}

+ (void)setBool:(BOOL)value forKey:(NSString*)key
{
    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    [shareUD setBool:value forKey:key];
    [shareUD synchronize];
}

+ (void)setObject:(NSObject*)value forKey:(NSString*)key
{
    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    [shareUD setObject:value forKey:key];
    [shareUD synchronize];
}

+ (void)setObjects:(NSArray*)values forKeys:(NSArray*)keys
{
    if (keys.count != values.count) {
        return;
    }

    NSUserDefaults* shareUD = [[ESharedUserDefault sharedInstance] sharedUD];
    [keys enumerateObjectsUsingBlock:^(NSString*  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [shareUD setObject:values[idx] forKey:key];
    }];
    BOOL success = [shareUD synchronize];
    if (!success) {
        NSLog(@"synchronize error");
    }
}
@end
