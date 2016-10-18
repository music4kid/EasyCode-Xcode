//
//  ECMappingHelper.h
//  EasyCode
//
//  Created by gao feng on 2016/10/18.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECMapping : NSObject
- (NSDictionary*)provideMapping;
@end

@interface ECMappingHelper : NSObject

+ (instancetype)sharedInstance;

- (int)insertWithBuffer:(NSMutableArray*)lines lineIndex:(NSInteger)index column:(NSInteger)column;

@end
