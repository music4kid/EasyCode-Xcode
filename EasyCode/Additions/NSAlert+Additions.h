//
//  NSAlert+Additions.h
//  EasyCode
//
//  Created by lijia on 20/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSAlert (Additions)
+(instancetype)ec_alertWithStyle:(NSAlertStyle)alertStyle
                     messageText:(NSString *)message
                 informativeText:(NSString *)informative
                     buttonTitle:(NSString *)firstTitle,...;
@end
