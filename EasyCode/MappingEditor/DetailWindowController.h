//
//  DetailWindowController.h
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ECSnippetEntry.h"

typedef enum : NSUInteger {
    DetailEditorModeUpdate,
    DetailEditorModeInsert,
} DetailEditorMode;

@protocol DetailWindowEditorDelegate <NSObject>
- (void)onSnippetUpdated:(ECSnippetEntry*)snippet;
- (void)onSnippetInserted:(ECSnippetEntry*)snippet;
@end


@interface DetailWindowController : NSWindowController
@property (nonatomic, readonly,getter=hasEdited) BOOL edited;

- (void)initWithEntry:(ECSnippetEntry*)entry;

@property (nonatomic, weak) id<DetailWindowEditorDelegate>         delegate;
@property (nonatomic, assign) DetailEditorMode                     editMode;
@property (nonatomic, strong) IBOutlet NSTextField*                txtKey;
@property (nonatomic, strong) IBOutlet NSTextField*                txtCode;

@end
