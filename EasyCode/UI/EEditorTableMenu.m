//
//  EEditorTableMenu.m
//  EasyCode
//
//  Created by lijia on 20/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "EEditorTableMenu.h"
@interface EEditorTableMenu ()

@end


@implementation EEditorTableMenu

- (instancetype)initWithTitle:(NSString*)title
{
    self = [super initWithTitle:title];
    if (self) {
        _itemsTitle = @[@"Edit               "];
        NSInteger index = 0;
        for (NSString* itemTitle in _itemsTitle) {
            NSMenuItem* item = [self addItemWithTitle:itemTitle action:@selector(onMenuItemSelected:) keyEquivalent:@""];
            item.target = self;
            item.tag = index++;
        }
        [self addItem:[NSMenuItem separatorItem]];
    }
    return self;
}

- (void)onMenuItemSelected:(NSMenuItem*)item {
    if (_editorDelegate) {
        if ([_editorDelegate respondsToSelector:@selector(menu:didSelectedItemWithTag:)]) {
            [_editorDelegate menu:self didSelectedItemWithTag:item.tag];
        }
    }
}

@end
