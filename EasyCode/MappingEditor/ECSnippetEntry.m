//
//  ECSnippetEntry.m
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import "ECSnippetEntry.h"
#import "NSString+Additions.h"

static NSDateFormatter* formatter = nil;

@implementation ECSnippetEntry
+ (void)initialize {
    if (self == [ECSnippetEntry class]) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
}

+(instancetype)snippetWithKey:(NSString*)key code:(NSString*)code {
    ECSnippetEntry* snippet = [[[self class] alloc] init];
    snippet.key = key;
    snippet.code = code;
    snippet.createAt = [formatter stringFromDate:[NSDate date]];
    return snippet;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self.key = [decoder decodeObjectForKey:@"key"];
    self.code = [decoder decodeObjectForKey:@"code"];
    self.createAt = [decoder decodeObjectForKey:@"createAt"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_key forKey:@"key"];
    [encoder encodeObject:_code forKey:@"code"];
    [encoder encodeObject:_createAt forKey:@"createAt"];
}

- (id)copyWithZone:(NSZone *)zone {
    ECSnippetEntry* snippet = [[[self class] allocWithZone:zone] init];
    snippet.key = _key;
    snippet.code = _code;
    snippet.createAt = _createAt;
    return snippet;
}

- (void)setKey:(NSString *)key {
    _key = [key ec_trimWhiteSpace];
}

-(void)updateBySnippet:(ECSnippetEntry*)snippet {
    if ([self.key isEqualToString:snippet.key]) {
        self.code = snippet.code;
    }
}

@end
