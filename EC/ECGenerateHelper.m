//
//  ECGenerateHelper.m
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECGenerateHelper.h"
#import "ECFileParser.h"
#import "FSImpProcessor.h"
#import "NSString+PDRegex.h"

@interface ECGenerateHelper ()
@property (nonatomic, strong) ECFileParser*                 parser;

@end

@implementation ECGenerateHelper

+ (instancetype)sharedInstance
{
    static ECGenerateHelper* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ECGenerateHelper new];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.parser = [ECFileParser new];
    }
    return self;
}

- (BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation
{
    BOOL hasCreatedSelector = [self tryCreateSelectorForCurrentLine:invocation];
    if (hasCreatedSelector) {
        return true;
    }
    
    return false;
}

- (BOOL)tryCreateSelectorForCurrentLine:(XCSourceEditorCommandInvocation *)invocation
{
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    NSMutableArray* lines = invocation.buffer.lines;
    NSInteger index = selection.start.line;
    NSString* curLineContent = lines[index];
    NSMutableString* content = [invocation.buffer.completeBuffer mutableCopy];
    NSRange curSelectionRange = NSMakeRange(NSNotFound, 0);
    NSString* curLineSelector = nil;
    
    //extract selector from current line
    NSString* regex = regex = @"@selector\\((.*?)\\)";
    NSArray* matchedSelectors = [curLineContent vv_stringsByExtractingGroupsUsingRegexPattern:regex caseInsensitive:false treatAsOneLine:true];
    if (matchedSelectors.count > 0) {
        curLineSelector = [matchedSelectors firstObject];
        curSelectionRange = [content rangeOfString:[NSString stringWithFormat:@"@selector(%@)", curLineSelector]];
    }
    
    //parse .m file for implementation
    FSElementCache* element = [_parser getElementByContent:content selection:curSelectionRange];
    if (element != nil && curLineSelector.length > 0) {
        //create method implementation at the end of imp
        NSString* methodImp = nil;
        if ([curLineSelector hasSuffix:@":"]) {
            methodImp = [NSString stringWithFormat:@"- (void)%@(<#type#>)<#name#> {\n\t\n}\n\n", curLineSelector];
        }
        else
        {
            methodImp = [NSString stringWithFormat:@"- (void)%@ {\n\t\n}\n\n", curLineSelector];
        }
        
        NSUInteger insertLocation = element.contentRange.location + element.contentRange.length - 1;
        [content insertString:methodImp atIndex:insertLocation];
        
        //invocation.buffer.completeBuffer = content; //crash! (╯‵□′)╯︵┻━┻
        
        //alternative:find the last @end
        for (int i = (int)lines.count-1; i >=0; i --) {
            NSString* l = lines[i];
            if ([l containsString:@"@end"]) {
                [lines insertObject:methodImp atIndex:i];
                break;
            }
        }
        
        return true;
    }
    
    return false;
}


@end
