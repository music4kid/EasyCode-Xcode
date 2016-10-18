//
//  ECGenerateHelper.h
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>

@interface ECGenerateHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
