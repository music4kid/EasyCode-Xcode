//
//  SourceEditorCommand.m
//  EC
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "EasyCodeManager.h"
#import <AppKit/NSWorkspace.h>

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    if ([invocation.commandIdentifier isEqualToString:@"easycode.insertcode"]) {
        [[EasyCodeManager sharedInstance] handleInvocation:invocation];
    }
    else if ([invocation.commandIdentifier isEqualToString:@"easycode.editmapping"]) {
        [[NSWorkspace sharedWorkspace] openURL:[NSURL fileURLWithPath:@"/Applications/EasyCode.app"]];
    }
    
    completionHandler(nil);
}


@end
