//
//  EditorWindowController.h
//  EasyCode
//
//  Created by gao feng on 2016/10/20.
//  Copyright © 2016年 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EditorWindowController : NSWindowController
- (instancetype)initEditorWindowForType:(ECSourceType)sourceType;
@end
