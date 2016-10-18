//
//  ECMappingHelper.m
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECMappingHelper.h"
#import "ECMappingForObjectiveC.h"
#import "ECMappingForSwift.h"

@implementation ECMapping
- (NSDictionary*)provideMapping {
    return nil;
}
@end

@interface ECMappingHelper ()
@property (nonatomic, strong) NSMutableArray*                 mappings;

@end

@implementation ECMappingHelper

+ (instancetype)sharedInstance
{
    static ECMappingHelper* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [ECMappingHelper new];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mappings = @[].mutableCopy;
        
        [_mappings addObject:[ECMappingForObjectiveC new]];
        [_mappings addObject:[ECMappingForSwift new]];
        
        //check for duplicated keys
        for (ECMapping* mapping in _mappings) {
            
            NSArray* keys = [mapping provideMapping].allKeys;
            NSMutableDictionary* dic = @{}.mutableCopy;
            for (NSString* key in keys) {
                if ([dic objectForKey:keys]) {
                    NSLog(@"detect duplicated keys!");
                }
                else
                {
                    dic[key] = key;
                }
            }
            
        }
        
    }
    return self;
}


- (BOOL)handleInvocation:(XCSourceEditorCommandInvocation *)invocation {
    
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    NSMutableArray* lines = invocation.buffer.lines;
    NSInteger index = selection.start.line;
    NSInteger column = selection.end.column;
    
    int matchedCount = 0;
    
    if (index > lines.count-1) {
        return false;
    }
    
    NSString* originalLine = lines[index];
    
    int matchLength = 4;
    while (matchLength >= 1) {
        
        if (column-matchLength >= 0)
        {
            NSRange targetRange = NSMakeRange(column-matchLength, matchLength);
            NSString* lastNStr = [originalLine substringWithRange:targetRange];
            NSString* matchedVal = [self getMatchedCode:lastNStr];
            
            if (matchedVal.length > 0) {
                
                int numberOfSpaceIndent = (int)[originalLine rangeOfString:lastNStr].location;
                NSString* indentStr = @"";
                while (numberOfSpaceIndent>0) {
                    indentStr = [indentStr stringByAppendingString:@" "];
                    numberOfSpaceIndent --;
                }
                
                NSArray* linesToInsert = [self convertToLines:matchedVal];
                
                //insert 1st line
                lines[index] = [originalLine stringByReplacingOccurrencesOfString:lastNStr
                                                                       withString:linesToInsert[0]
                                                                          options:NSBackwardsSearch
                                                                            range:targetRange];
                
                //insert the rest
                for (int i = 1; i < linesToInsert.count; i ++) {
                    NSString* lineToInsert = linesToInsert[i];
                    //indent
                    lineToInsert = [NSString stringWithFormat:@"%@%@", indentStr, lineToInsert];
                    [lines insertObject:lineToInsert atIndex:index+i];
                }
                
                matchedCount = matchLength;
                
                break;
            }
        }
        
        matchLength --;
        
    }
    
    
    //adjust selection
    if (matchedCount > 0) {
        selection.start = XCSourceTextPositionMake(selection.start.line, selection.start.column-matchedCount);
        selection.end = selection.start;
    }
    return true;
}


- (NSString*)getMatchedCode:(NSString*)abbr
{
    //need to detect swift or oc
    for (ECMapping* mapping in _mappings) {
        NSDictionary* mappingDic = [mapping provideMapping];
        if ([mappingDic objectForKey:abbr] != nil) {
            return [mappingDic objectForKey:abbr];
        }
    }
    
    return nil;
}


- (NSArray*)convertToLines:(NSString*)codeStr
{
    NSMutableArray* lines = @[].mutableCopy;
    
    NSArray* arr = [codeStr componentsSeparatedByString:@"\n"];
    
    for (NSString* line in arr) {
        [lines addObject:line];
    }
    
    return lines;
}



@end
