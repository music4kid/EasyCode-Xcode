//
//  ECSnippetEntry.h
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECSnippetEntry : NSObject<NSCoding,NSCopying>
@property (nonatomic, copy) NSString* key;
@property (nonatomic, copy) NSString* code;
@property (nonatomic, copy) NSString* createAt;

+(instancetype)snippetWithKey:(NSString*)key code:(NSString*)code;

-(void)updateBySnippet:(ECSnippetEntry*)snippet;
@end
