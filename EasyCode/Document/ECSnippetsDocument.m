//
//  ECSnippetDocument.m
//  AirCode
//
//  Created by lijia on 2017/3/1.
//  Copyright © 2017年 music4kid. All rights reserved.
//

#import "ECSnippetsDocument.h"
#import "NSWindowController+Additions.h"
#import "ECSnippetEntry.h"
#import "ECMappingForObjectiveC.h"
#import "ECMappingForSwift.h"
#import "NSFileWrapper+Additions.h"
#import "ECSnippetHelper.h"

NSString *const ECDocumentLoadedNotificationOC = @"ECDocumentLoadedNotificationOC";
NSString *const ECDocumentLoadedNotificationSwift = @"ECDocumentLoadedNotificationSwift";

@interface ECSnippetDocument ()
@property (nonatomic, strong) NSFileWrapper *fileWrapper;
@property (nonatomic, assign,getter=hasSavedAlready) BOOL savedAlready;
@end

@implementation ECSnippetDocument
-(instancetype)initWithFileURL:(NSURL *)itemURL sourceType:(ECSourceType)type {
    if (type == ECSourceTypeOC) {
        self = [super initWithContentsOfURL:itemURL ofType:DirectoryOCName error:nil];
    } else {
        self = [super initWithContentsOfURL:itemURL ofType:DirectorySwiftName error:nil];;
    }
    
    if (self) {
        _sourceType = type;
        _savedAlready = NO;
    }
    return self;
}

-(void)sortedSnippets {
    [_snippet sortedEntry];
}

-(NSInteger)snippetEntryCount {
    return [_snippet entryCount];
}

-(ECSnippetEntry*)snippetEntryForKey:(NSString*)key {
    return [_snippet entryForKey:key];
}

-(void)addSnippetEntry:(ECSnippetEntry*)entry {
    if ([entry.key ec_isNotEmpty] == NO) {
        return;
    }
    [_snippet addEntry:entry];
    [self saveDocumentCompletionHandler:^{
        if ([_delegate respondsToSelector:@selector(snippetsDocument:performActionWithType:withEntry:)]) {
            [_delegate snippetsDocument:self performActionWithType:ECSnippetEntryActionTypeCreate withEntry:entry];
        }
    }];
}

-(void)removeSnippetEntryForKey:(NSString*)key {
    ECSnippetEntry* hitEntry = [_snippet removeEntryForKey:key];
    [self saveDocumentCompletionHandler:^{
        if ([_delegate respondsToSelector:@selector(snippetsDocument:performActionWithType:withEntry:)]) {
            [_delegate snippetsDocument:self performActionWithType:ECSnippetEntryActionTypeDelete withEntry:hitEntry];
        }
    }];
}

-(void)updateSnippetEntry:(ECSnippetEntry*)entry {
    ECSnippetEntry* hitEntry = entry;
    [_snippet updateEntry:hitEntry];
    [self saveDocumentCompletionHandler:^{
        if ([_delegate respondsToSelector:@selector(snippetsDocument:performActionWithType:withEntry:)]) {
            [_delegate snippetsDocument:self performActionWithType:ECSnippetEntryActionTypeUpdate withEntry:hitEntry];
        }
    }];
}

-(void)saveDocumentCompletionHandler:(void (^)(void))handler {
    NSInteger version = [ECSnippetHelper versionForSourceType:_sourceType];
    if (version == _snippet.version.integerValue && [self hasSavedAlready]) {
        if (handler) {
            handler();
        }
        return;
    }
    [self sortedSnippets];
    
    NSString *typeName = DirectoryOCName;
    if (_sourceType == ECSourceTypeOC) {
        typeName = DirectoryOCName;
    } else {
        typeName = DirectorySwiftName;
    }
    
    [self saveToURL:self.fileURL ofType:typeName forSaveOperation:NSSaveOperation completionHandler:^(NSError * _Nullable errorOrNil) {
        if (errorOrNil) {
            NSLog(@"Save Document Error :%@",[errorOrNil localizedDescription]);
        } else {
            _savedAlready = YES;
            
            NSString* dirnameKey = [ECSnippetHelper directoryForSourceType:_sourceType];
            NSData* snippetData = [_snippet snippetData];
            
            NSNumber* versionNum = _snippet.version;
            NSString* versionKey = [NSString stringWithFormat:kVersionFormat,dirnameKey];
            [ESharedUserDefault setObjects:@[snippetData,versionNum] forKeys:@[dirnameKey,versionKey]];
        }
        
        if (handler) {
            handler();
        }
    }];
}

#pragma mark - Override Documents
-(NSString *)displayName {
    return @"Code Snippet";
}

+ (BOOL)autosavesInPlace {
    return NO;
}

- (NSFileWrapper *)fileWrapperOfType:(NSString *)typeName error:(NSError **)outError {
    //snippet data
    NSData* snippetData = [NSKeyedArchiver archivedDataWithRootObject:_snippet];
    NSFileWrapper* snippetWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:snippetData];
    snippetWrapper.preferredFilename = SnippetFileName;
    //version data    
    NSData* verData = [_snippet.version.stringValue dataUsingEncoding:NSUTF8StringEncoding];
    NSFileWrapper* verWrapper = [[NSFileWrapper alloc] initRegularFileWithContents:verData];
    verWrapper.preferredFilename = VersionFileName;
    if (_fileWrapper == nil) {
        NSDictionary<NSString*,NSFileWrapper*>* fileWrappers = @{ SnippetFileName:snippetWrapper,
                                                                  VersionFileName:verWrapper };
        _fileWrapper = [[NSFileWrapper alloc] initDirectoryWithFileWrappers:fileWrappers];
    } else {
        [_fileWrapper ec_replaceFileWrapper:snippetWrapper forKey:SnippetFileName];
        [_fileWrapper ec_replaceFileWrapper:verWrapper forKey:VersionFileName];
    }
    
    return _fileWrapper;
}

- (BOOL)readFromFileWrapper:(NSFileWrapper *)fileWrapper ofType:(NSString *)typeName error:(NSError * _Nullable *)outError {
    _snippet = [ECSnippetHelper snippetWithFileWrapper:fileWrapper];
    
    if (typeName == DirectoryOCName) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ECDocumentLoadedNotificationOC
                                                            object:self];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:ECDocumentLoadedNotificationSwift
                                                            object:self];
    }
    
   
    return YES;
}

@end
