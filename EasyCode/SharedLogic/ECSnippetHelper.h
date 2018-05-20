//
//  ECSnippetHelper.h
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECSnippet.h"
#import "ECDefine.h"

@interface ECSnippetHelper : NSObject
+(ECSnippet*)snippetWithFileWrapper:(NSFileWrapper*)fileWrapper;
+(ECSnippet*)snippetWithSourceType:(ECSourceType)sourceType;
+(NSInteger)versionForSourceType:(ECSourceType)sourceType;
+(NSString*)directoryForSourceType:(ECSourceType)sourceType;
+(ECSourceType)sourceTypeForContentUTI:(NSString*)contentUTI;
+(ECSourceType)sourceTypeForDirectory:(NSString*)filename;
@end
