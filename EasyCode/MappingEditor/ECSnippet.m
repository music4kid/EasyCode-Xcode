//
//  ECSnippet.m
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "ECSnippet.h"
#import "NSString+Additions.h"


@interface ECSnippet () {
    NSMutableArray<ECSnippetEntry*>* _entryList;
}
@end


@implementation ECSnippet
-(instancetype)initWithSourceType:(ECSourceType)sourceType entries:(NSArray<ECSnippetEntry*>*)entries {
    self = [super init];
    if (self) {
        _type = @(sourceType);
        _entryList = [entries mutableCopy];
        _version = @(1);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    self.version = [decoder decodeObjectForKey:@"version"];
    self.entries = [decoder decodeObjectForKey:@"entries"];
    self.type = [decoder decodeObjectForKey:@"type"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_version forKey:@"version"];
    [encoder encodeObject:[self entries] forKey:@"entries"];
    [encoder encodeObject:_type forKey:@"type"];
}

- (id)copyWithZone:(NSZone *)zone {
    ECSnippet* snippet = [[[self class] allocWithZone:zone] init];
    snippet.version = _version;
    snippet.entries = [_entryList copy];
    snippet.type = _type;
    return snippet;
}

-(NSArray<ECSnippetEntry *> *)entries {
    return [_entryList copy];
}

-(void)setEntries:(NSArray<ECSnippetEntry *> *)entries {
    _entryList = [entries mutableCopy];
}

//排序
-(void)sortedEntry {
    [_entryList sortUsingComparator:^NSComparisonResult(ECSnippetEntry*  _Nonnull e1, ECSnippetEntry*  _Nonnull e2) {
        return [e1.key compare:e2.key];
    }];
}

//条目数量
-(NSInteger)entryCount {
    return _entryList.count;
}

-(ECSnippetEntry*)entryForKey:(NSString*)key {
    NSString* trimKey = [key ec_trimWhiteSpace];
    NSArray* entryList = [self entries];
    NSUInteger index = [entryList indexOfObjectWithOptions:NSEnumerationConcurrent passingTest:^BOOL(ECSnippetEntry*  _Nonnull snippet, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL result = [snippet.key isEqualToString:trimKey];
        if (result) {
            *stop = YES;
        }
        return result;
    }];
    if (index != NSNotFound) {
        return entryList[index];
    }
    return nil;
}

-(void)addEntry:(ECSnippetEntry*)entry {
    if ([entry.key ec_isNotEmpty] == NO) {
        return;
    }
    ECSnippetEntry* hitEntry = [self entryForKey:entry.key];
    if (hitEntry == nil) { //add
        [_entryList addObject:entry];
    } else {
        [self updateEntry:entry];
    }
    _version = @([_NUMBER(_version) unsignedIntegerValue] + 1);
}

-(ECSnippetEntry*)removeEntryForKey:(NSString*)key {
    ECSnippetEntry* hitEntry = [self entryForKey:key];
    if (hitEntry) {
        [_entryList removeObject:hitEntry];
        _version = @([_NUMBER(_version) unsignedIntegerValue] + 1);
    }
    return hitEntry;
}

-(void)updateEntry:(ECSnippetEntry*)entry {
    ECSnippetEntry* hitEntry = [self entryForKey:entry.key];
    [hitEntry updateBySnippet:hitEntry];
    _version = @([_NUMBER(_version) unsignedIntegerValue] + 1);
}

-(NSData*)snippetData {
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:self];
    return data;
}


@end
