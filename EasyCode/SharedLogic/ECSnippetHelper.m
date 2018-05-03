//
//  ECSnippetHelper.m
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "ECSnippetHelper.h"
#import "NSFileManager+Additions.h"
#import "ECMappingForObjectiveC.h"
#import "ECMappingForSwift.h"

@implementation ECSnippetHelper

+(ECSourceType)sourceTypeForContentUTI:(NSString*)contentUTI {
    if ([contentUTI isEqualToString:@"public.swift-source"]) {
        return ECSourceTypeSwift;
    } else {
        return ECSourceTypeOC;
    }
}

+(NSString*)directoryForSourceType:(ECSourceType)sourceType {
    if (sourceType == ECSourceTypeOC) {
        return DirectoryOCName;
    } else {
        return DirectorySwiftName;
    }
}

+(ECSourceType)sourceTypeForDirectory:(NSString*)filename {
    if ([filename isEqualToString:DirectoryOCName]) {
        return ECSourceTypeOC;
    } else {
        return ECSourceTypeSwift;
    }
}

+(ECSnippet*)snippetWithFileWrapper:(NSFileWrapper*)fileWrapper {
    NSString* filename = [fileWrapper filename];
    NSDictionary *fileWrappers = [fileWrapper fileWrappers];
    NSFileWrapper *snippetWrapper = [fileWrappers objectForKey:SnippetFileName];
    if (snippetWrapper == nil) { //switch ubiquity to local
        NSURL* fileURL = [[NSFileManager defaultManager] ec_localSnippetsURLWithFilename:filename];
        fileWrapper = [[NSFileWrapper alloc] initWithURL:fileURL options:NSFileWrapperReadingWithoutMapping error:nil];
        fileWrappers = [fileWrapper fileWrappers];
        snippetWrapper = [fileWrappers objectForKey:SnippetFileName];
    }
    NSData* data = [snippetWrapper regularFileContents];
    ECSnippet* snippet = nil;
    if ([data length] > 0) {
        snippet = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(snippet.entries.count==0){
            NSArray* entries = nil;
            if ([[fileWrapper filename] isEqualToString:DirectoryOCName]) {
                entries = [ECMappingForObjectiveC defaultEntries];
            } else {
                entries = [ECMappingForSwift defaultEntries];
            }
            ECSourceType sourceType = [self sourceTypeForDirectory:filename];
            snippet = [[ECSnippet alloc] initWithSourceType:sourceType entries:entries];
        }
        
    } else { //create from memory if local not exist
        NSArray* entries = nil;
        if ([[fileWrapper filename] isEqualToString:DirectoryOCName]) {
            entries = [ECMappingForObjectiveC defaultEntries];
        } else {
            entries = [ECMappingForSwift defaultEntries];
        }
        ECSourceType sourceType = [self sourceTypeForDirectory:filename];
        snippet = [[ECSnippet alloc] initWithSourceType:sourceType entries:entries];
    }
    return snippet;
}

+(ECSnippet*)snippetWithSourceType:(ECSourceType)sourceType {
    NSURL* fileURL = [[NSFileManager defaultManager] ec_detectURLForSourceType:sourceType];
    NSFileWrapper* fileWrapper = [[NSFileWrapper alloc] initWithURL:fileURL
                                                            options:NSFileWrapperReadingWithoutMapping
                                                              error:nil];
    ECSnippet* snippet = [self snippetWithFileWrapper:fileWrapper];
    return snippet;
}

+(NSInteger)versionForSourceType:(ECSourceType)sourceType {
    NSURL* url = [[NSFileManager defaultManager] ec_detectURLForSourceType:sourceType];
    NSFileWrapper* fileWrapper = [[NSFileWrapper alloc] initWithURL:url options:NSFileWrapperReadingWithoutMapping error:nil];
    NSDictionary *fileWrappers = [fileWrapper fileWrappers];
    NSFileWrapper *versionWrapper = [fileWrappers objectForKey:VersionFileName];
    NSData* data = [versionWrapper regularFileContents];
    NSInteger version = 0;
    if ([data length] > 0) {
        NSString* verStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        version = [verStr integerValue];
    }
    return version;
}
@end
