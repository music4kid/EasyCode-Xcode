//
//  ECFileParser.m
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECFileParser.h"
#import "FSImpProcessor.h"

@implementation ECFileParser

- (FSElementCache*)getImpElementByContent:(NSString*)content
{
    FSImpProcessor* p = [FSImpProcessor new];
    NSArray* elementsInFile = [p createElements:content];
    if (elementsInFile.count > 0) {
        return [elementsInFile firstObject];
    }
    else
    {
        return nil;
    }
}

- (FSElementCache*)getElementByContent:(NSString*)content selection:(NSRange)range {
    FSElementCache* element = nil;
    FSImpProcessor* p = [FSImpProcessor new];
    NSArray* elementsInFile = [p createElements:content];
    for (FSElementCache* e in elementsInFile) {
        if (NSLocationInRange(range.location, e.contentRange)) {
            //element match
            NSLog(@"get a match");
            element = e;
            break;
        }
    }
    
    return element;
}



@end
