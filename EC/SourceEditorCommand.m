//
//  SourceEditorCommand.m
//  EC
//
//  Created by gao feng on 2016/10/15.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "SourceEditorCommand.h"
#import "EasyCodeManager.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    [[EasyCodeManager sharedInstance] handleInvocation:invocation];
    
    completionHandler(nil);
}


@end
