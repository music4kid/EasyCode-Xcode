//
//  ECMappingHelper.m
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECMappingHelper.h"
#import "NSFileManager+Additions.h"
#import "ESharedUserDefault.h"
#import "ECSnippet.h"
#import "ECSnippetHelper.h"

@interface ECMappingHelper ()
@property (nonatomic, strong)   ECSnippet* curSnippets;
@end

@implementation ECMappingHelper

+ (instancetype)sharedInstance {
    static ECMappingHelper* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ECMappingHelper alloc] init];
    });

    return instance;
}

- (void)reloadSnippetBySourceType:(ECSourceType)sourceType {
    NSString* dirname = [ECSnippetHelper directoryForSourceType:sourceType];
    NSString* versionKey = [NSString stringWithFormat:kVersionFormat,dirname];
    NSNumber* latestVer = [ESharedUserDefault objectForKey:versionKey];
    
    if ([_curSnippets.version isEqualToNumber:latestVer] == NO) { //if versions are not equal,reload from UserDefaults.
        NSData* data = [ESharedUserDefault dataForKey:dirname];
        _curSnippets = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

- (BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation {
    ECSourceType sourceType = [ECSnippetHelper sourceTypeForContentUTI:invocation.buffer.contentUTI];
    [self reloadSnippetBySourceType:sourceType];
    
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    NSMutableArray* lines = invocation.buffer.lines;
    NSInteger index = selection.start.line;
    NSInteger column = selection.end.column;
    
    int matchedCount = 0;
    
    if (index > lines.count - 1) {
        return false;
    }
    
    NSString* originalLine = lines[index];
    int matchLength = 8;//max match length for shortcut
    while (matchLength >= 1) {
        
        if (column-matchLength >= 0)
        {
            NSRange targetRange = NSMakeRange(column-matchLength, matchLength);
            NSString* lastNStr = [originalLine substringWithRange:targetRange];
            
            NSString* matchedVal = [self matchedCode:lastNStr forSourceType:sourceType];
            
            if (matchedVal.length > 0) {
                int numberOfSpaceIndent = (int)[originalLine rangeOfString:lastNStr].location;
                NSString* indentStr = @"";
                while (numberOfSpaceIndent>0) {
                    indentStr = [indentStr stringByAppendingString:@" "];
                    numberOfSpaceIndent--;
                }
                
                NSArray* linesToInsert = [self convertToLines:matchedVal];
                
                //insert 1st line
                lines[index] = [originalLine stringByReplacingOccurrencesOfString:lastNStr
                                                                       withString:linesToInsert[0]
                                                                          options:NSBackwardsSearch
                                                                            range:targetRange];
                
                //insert the rest
                for (int i = 1; i < linesToInsert.count; i++) {
                    NSString* lineToInsert = linesToInsert[i];
                    //indent
                    lineToInsert = [NSString stringWithFormat:@"%@%@", indentStr, lineToInsert];
                    [lines insertObject:lineToInsert atIndex:index+i];
                }
                
                matchedCount = matchLength;
                
                break;
            }
        }
        
        matchLength--;
        
    }
    
    //adjust selection
    if (matchedCount > 0) {
        selection.start = XCSourceTextPositionMake(selection.start.line, selection.start.column-matchedCount);
        selection.end = selection.start;
    }
    return true;
}


- (NSString*)matchedCode:(NSString*)abbr forSourceType:(ECSourceType)type {
    //need to detect swift or oc
    NSArray<ECSnippetEntry*>* entries = _curSnippets.entries;
    __block NSInteger index = NSNotFound;
    [_curSnippets.entries enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(ECSnippetEntry * _Nonnull entry, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([entry.key hasPrefix:abbr] || [entry.key isEqual:abbr]) {
            index = idx;
            *stop = YES;
        }
    }];
    
    if (index != NSNotFound) {
        NSString* matchedCode = [entries[index] code];
        return matchedCode;
    }
    
    return nil;
}

- (NSArray*)convertToLines:(NSString*)codeStr {
    NSArray* arr = [codeStr componentsSeparatedByString:@"\n"];
    return arr;
}

@end
