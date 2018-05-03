//
//  ECSafeCast.m
//  testImage
//
//  Created by li on 10/8/15.
//  Copyright © 2015 hh.changhong.com. All rights reserved.
//

#import "ECSafeCast.h"

@implementation ECSafeCast

+ (NSString *)parseToString:(id)parse
{
    if (!parse) {
        return @"";
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return parse;
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",parse];
    }
    else
        return  [NSString stringWithFormat:@"%@",parse];

}

+ (NSNumber *)parseToNumValue:(id)parse
{
    if (!parse) {
        return @(0);
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [NSNumber numberWithDouble:[parse doubleValue]];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return parse;
    }
    else
        return  @(0);
}
 

+ (double)parseToDoubleValue:(id)parse
{
    if (!parse) {
        return 0;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [(NSString*)parse doubleValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse doubleValue];
    }
    else
        return  0;
}


+ (BOOL)parseToBOOLValue:(id)parse
{
    if (!parse) {
        return false;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [(NSString*)parse boolValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse boolValue];
    }
    else
        return  false;
}

+ (NSInteger)parseToIntegerValue:(id)parse
{
    if (!parse) {
        return 0;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [(NSString*)parse integerValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse integerValue];
    }
    else
        return  0;
}

+ (long long)parseTolongLongValue:(id)parse
{
    if (!parse) {
        return 0;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [(NSString*)parse longLongValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse longLongValue];
    }
    else
        return  0;
}

+ (long)parseTolongValue:(id)parse
{
    if (!parse) {
        return 0;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return (long)[(NSString*)parse longLongValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse longValue];
    }
    else
        return  0;
}

+ (float)parseToFloatValue:(id)parse
{
    if (!parse) {
        return 0;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [(NSString*)parse floatValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse floatValue];
    }
    else
        return  0;
}

+ (int)parseToIntValue:(id)parse
{
    if (!parse) {
        return 0;
    }
    if ([parse isKindOfClass:[NSString class]]) {
        return [(NSString*)parse intValue];
    }
    else if([parse isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber*)parse intValue];
    }
    else
        return  0;
}

+ (NSArray *)parseToArray:(id)parse;
{
    if (!parse) {
        return @[];
    }
    if ([parse isKindOfClass:[NSArray class]]) {
        return parse;
    }
    else
        return @[];
}

+ (NSDictionary *)parseToDictionary:(id)parse
{
    if (parse && [parse isKindOfClass:[NSDictionary class]]) {
        return parse;
    }
    return @{};
}

@end
