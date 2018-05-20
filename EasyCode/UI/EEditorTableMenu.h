//
//  EEditorTableMenu.h
//  EasyCode
//
//  Created by lijia on 20/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol EEditorMenuDelegate;

@interface EEditorTableMenu : NSMenu
@property (nonatomic, weak) id<EEditorMenuDelegate>         editorDelegate;
@property (nonatomic, readonly,copy) NSArray* itemsTitle;
@end

@protocol EEditorMenuDelegate <NSObject>
-(void)menu:(EEditorTableMenu*)menu didSelectedItemWithTag:(NSInteger)tag;
@end
