//
//  NSString+Additions.m
//  EasyCode
//
//  Created by lijia on 09/02/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)
-(NSString*)ec_trimWhiteSpace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(BOOL)ec_isNotEmpty {
    NSString* trimStr = [self ec_trimWhiteSpace];
    return (trimStr != nil && trimStr.length > 0);
}
@end
