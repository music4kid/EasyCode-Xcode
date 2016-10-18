//
//  EasyCodeManager.m
//  EasyCode
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "EasyCodeManager.h"
#import "ECMappingForObjectiveC.h"

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

- (int)handleWithBuffer:(NSMutableArray*)lines lineIndex:(NSInteger)index column:(NSInteger)column {
    
    //replace abbr with template code
    int matchedCount = [[ECMappingHelper sharedInstance] insertWithBuffer:lines lineIndex:index column:column];
    
    //dynamic code generation based on class parsing like FastStub(https://github.com/music4kid/FastStub-Xcode)
    
    
    return matchedCount;
}



@end
