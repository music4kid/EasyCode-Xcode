//
//  ECSnippetDocument.h
//  AirCode
//
//  Created by lijia on 2017/3/1.
//  Copyright © 2017年 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EditorWindowController.h"
#import "ECSnippet.h"
@protocol ECSnippetEntrysDocumentDelegate;

EC_EXTERN NSString *const ECDocumentLoadedNotificationOC;
EC_EXTERN NSString *const ECDocumentLoadedNotificationSwift;

typedef NS_ENUM(NSInteger,ECSnippetEntryActionType) {
    ECSnippetEntryActionTypeCreate,
    ECSnippetEntryActionTypeRetrieve,
    ECSnippetEntryActionTypeUpdate,
    ECSnippetEntryActionTypeDelete
};

@interface ECSnippetDocument : NSDocument
@property (nonatomic, assign)           ECSourceType                            sourceType;
@property (nonatomic, copy,readonly)    ECSnippet*                              snippet;
@property (nonatomic, weak)             id<ECSnippetEntrysDocumentDelegate>     delegate;

-(instancetype)initWithFileURL:(NSURL*)itemURL sourceType:(ECSourceType)type;
//条目数量
-(NSInteger)snippetEntryCount;
//根据键查找片段
-(ECSnippetEntry*)snippetEntryForKey:(NSString*)key;
//插入片段
-(void)addSnippetEntry:(ECSnippetEntry*)snippet;
//根据键删除片段
-(void)removeSnippetEntryForKey:(NSString*)key;
//根据键更新片段
-(void)updateSnippetEntry:(ECSnippetEntry*)snippet;
//保存文档
-(void)saveDocumentCompletionHandler:(void (^)(void))handler;
@end

@protocol ECSnippetEntrysDocumentDelegate <NSObject>
-(void)snippetsDocument:(ECSnippetDocument*)document performActionWithType:(ECSnippetEntryActionType)actionType withEntry:(ECSnippetEntry*)snippet;
@end


