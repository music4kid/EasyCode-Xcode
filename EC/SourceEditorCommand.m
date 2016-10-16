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
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    NSInteger index = selection.start.line;
    
    int matchedCharacterCount =  [[EasyCodeManager sharedInstance] insertWithBuffer:invocation.buffer.lines lineIndex:index];
    //adjust selection
    if (matchedCharacterCount > 0) {
        selection.start = XCSourceTextPositionMake(selection.start.line, selection.start.column-matchedCharacterCount);
        selection.end = selection.start;
    }
    
    completionHandler(nil);
}


@end
