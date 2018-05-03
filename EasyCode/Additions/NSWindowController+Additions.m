//
//  NSWindowController+Additions.m
//  EasyCode
//
//  Created by lijia on 02/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import "NSWindowController+Additions.h"

@implementation NSWindowController (Additions)
-(void)ec_makeWindowFront {
    [self.window makeKeyAndOrderFront:nil];
}
@end
