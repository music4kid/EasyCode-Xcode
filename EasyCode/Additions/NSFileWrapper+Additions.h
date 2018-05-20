//
//  NSFileWrapper+Additions.h
//  EasyCode
//
//  Created by lijia on 07/03/2017.
//  Copyright © 2017 music4kid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileWrapper (Additions)
-(void)ec_replaceFileWrapper:(NSFileWrapper*)child forKey:(NSString*)filename;
@end
