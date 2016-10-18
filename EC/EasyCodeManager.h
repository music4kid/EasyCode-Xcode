//
//  EasyCodeManager.h
//  EasyCode
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <XcodeKit/XcodeKit.h>

@interface EasyCodeManager : NSObject

+ (instancetype)sharedInstance;

//return number of characters matched
- (void)handleInvocation:(XCSourceEditorCommandInvocation *)invocation;

@end
