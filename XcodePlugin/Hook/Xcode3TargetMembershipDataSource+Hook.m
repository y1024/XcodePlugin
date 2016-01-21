//
//  Xcode3TargetMembershipDataSource+Hook.m
//  DemoPlug
//
//  Created by 杜晓星 on 16/1/11.
//  Copyright © 2016年 杜晓星. All rights reserved.
//

#import "Xcode3TargetMembershipDataSource+Hook.h"
#import "Xcode3TargetWrapper.h"
#import "JRSwizzle.h"
@implementation Xcode3TargetMembershipDataSource (Hook)

+ (void)hook
{
    [self jr_swizzleMethod:@selector(updateTargets) withMethod:@selector(updateTargetsHook) error:nil];
}


- (void)updateTargetsHook
{
    // We first call the original method
    [self updateTargetsHook];
    
    // Run our custom code
    NSMutableArray *wrappedTargets = [self valueForKey:@"wrappedTargets"];
    for (Xcode3TargetWrapper *wrappedTarget in wrappedTargets) {
        if ([wrappedTarget.name rangeOfString:@"Tests"].location == NSNotFound) {
             wrappedTarget.selected = YES;
        }
    }
}

@end
