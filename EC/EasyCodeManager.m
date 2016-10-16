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

- (int)insertWithBuffer:(NSMutableArray*)lines lineIndex:(NSInteger)index {
    int matchedCount = 0;
    
    if (index > lines.count-1) {
        return matchedCount;
    }
    
    NSString* originalLine = lines[index];
    NSString* selectedLine = [originalLine stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    int matchLength = 4;
    while (matchLength >= 2) {
        
        if (selectedLine.length >= matchLength) {
            NSString* lastNStr = [selectedLine substringFromIndex:selectedLine.length-matchLength];
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
                lines[index] = [originalLine stringByReplacingOccurrencesOfString:lastNStr withString:linesToInsert[0]];
                
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
    
    return matchedCount;
}

- (NSString*)getMatchedCode:(NSString*)abbr
{
    NSDictionary* mapping = [ECMappingForObjectiveC ocMapping];
    if ([mapping objectForKey:abbr] != nil) {
        return [mapping objectForKey:abbr];
    }
    else
    {
        return nil;
    }
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
