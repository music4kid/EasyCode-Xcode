//
//  EditorWindowController.h
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum : NSUInteger {
    EditorTypeOC,
    EditorTypeSwift,
} EditorType;

@interface EditorWindowController : NSWindowController

@property (nonatomic, strong) IBOutlet NSTableView*           tableView;

- (void)initEditorWindow:(EditorType)editorType;

@end
