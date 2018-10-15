//
//  AppDelegate.h
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TripodFrame/TripodFrame.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLConnectionDelegate,NSURLSessionDelegate>
@property (strong, nonatomic) UIWindow *window;
@property(weak,nonatomic)UINavigationController *s;
@property(nonatomic,strong)NSData *imageData;
@end

