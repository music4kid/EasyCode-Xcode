//
//  ECFileParser.h
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FSElementCache;

@interface ECFileParser : NSObject

- (FSElementCache*)getElementByContent:(NSString*)content selection:(NSRange)range;

- (FSElementCache*)getImpElementByContent:(NSString*)content;


@end
