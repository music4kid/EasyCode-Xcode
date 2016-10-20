//
//  EasyCodeManager.m
//  EasyCode
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "EasyCodeManager.h"
#import "ECMappingForObjectiveC.h"
#import "ECGenerateHelper.h"
#import "ECMappingHelper.h"

@interface EasyCodeManager ()

@end

@implementation EasyCodeManager

+ (instancetype)sharedInstance
{
    static EasyCodeManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [EasyCodeManager new];
    });

    return instance;
}

- (void)handleInvocation:(XCSourceEditorCommandInvocation *)invocation
{
    //dynamic code generation based on class parsing like FastStub(https://github.com/music4kid/FastStub-Xcode)
    if ([[ECGenerateHelper sharedInstance] handleInvocation:invocation]) {
        return;
    }
    
    if ([[ECMappingHelper sharedInstance] handleInvocation:invocation]) {
        return;
    }
    
    
}



@end
