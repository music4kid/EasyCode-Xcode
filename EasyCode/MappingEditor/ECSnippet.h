//
//  ECSnippet.h
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSnippetEntry.h"
#import "ECDefine.h"

@interface ECSnippet : NSObject <NSCopying,NSCoding>
@property (nonatomic, copy) NSNumber* version;
@property (nonatomic, copy) NSNumber* type;
@property (nonatomic, copy) NSArray<ECSnippetEntry*>* entries;

-(instancetype)initWithSourceType:(ECSourceType)sourceType entries:(NSArray<ECSnippetEntry*>*)entries;

//sort entry
-(void)sortedEntry;
//count entry
-(NSInteger)entryCount;
//search entry
-(ECSnippetEntry*)entryForKey:(NSString*)key;
//insert entry
-(void)addEntry:(ECSnippetEntry*)entry;
//delete entry
-(ECSnippetEntry*)removeEntryForKey:(NSString*)key;
//update entry
-(void)updateEntry:(ECSnippetEntry*)entry;
//use for store
-(NSData*)snippetData;
@end
