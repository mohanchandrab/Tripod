//
//  CommonMethod.h
//  Tripod
//
//  Created by Mohan on 04/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"
@interface CommonMethod : NSObject
{
    AppDelegate *app;
}
+ (CommonMethod *)sharedObject;
+(void)updateNavigationbarInController:(NSString *)NavigationTitle   navigation:(UINavigationItem *)navigation;
@end
