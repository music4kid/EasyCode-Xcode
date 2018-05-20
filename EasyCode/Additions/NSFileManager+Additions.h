//
//  NSFileManager+Additions.h
//  EasyCode
//
//  Created by lijia on 01/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECDefine.h"

extern NSString *const DirectoryLocationDomain;
extern NSString *const DirectoryUbiquityDocuments;
extern NSString *const DirectoryOCName;
extern NSString *const DirectorySwiftName;
extern NSString *const SnippetFileName;
extern NSString *const VersionFileName;

@interface NSFileManager (Additions)
-(NSURL*)ec_localURL;
-(NSURL*)ec_localSnippetsURLWithFilename:(NSString*)filename;
-(NSURL*)ec_ubiquityURL;
-(NSURL*)ec_ubiquitySnippetsURLWithFilename:(NSString*)filename;

-(NSURL*)ec_detectURLForSourceType:(ECSourceType)sourceType;

-(NSString *)ec_findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                             inDomain:(NSSearchPathDomainMask)domainMask
                  appendPathComponent:(NSString *)appendComponent
                                error:(NSError **)errorOut;
-(NSString*)ec_supportDocumentDirectory;
@end
