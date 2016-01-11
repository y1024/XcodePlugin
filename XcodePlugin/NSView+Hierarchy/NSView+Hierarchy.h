//
//  NSWindow+Hierarchy.h
//  XcodePlugin
//
//  Created by 杜晓星 on 16/1/11.
//  Copyright © 2016年 杜晓星. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (Hierarchy)
- (void)dumpWithIndent:(NSString *)indent;
@end
