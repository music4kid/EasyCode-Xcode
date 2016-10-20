//
//  DetailWindowController.h
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EShortcutEntry.h"

typedef enum : NSUInteger {
    DetailEditorModeUpdate,
    DetailEditorModeInsert,
} DetailEditorMode;

@protocol DetailWindowEditorDelegate <NSObject>

- (void)onEntryUpdated:(EShortcutEntry*)entry;
- (void)onEntryInserted:(EShortcutEntry*)entry;

@end


@interface DetailWindowController : NSWindowController

- (void)initWithMappingEntry:(EShortcutEntry*)entry;

@property (nonatomic, weak) id<DetailWindowEditorDelegate>         delegate;
@property (nonatomic, assign) DetailEditorMode                     editMode;


@property (nonatomic, strong) IBOutlet NSTextField*                txtKey;
@property (nonatomic, strong) IBOutlet NSTextField*                txtCode;

@end
