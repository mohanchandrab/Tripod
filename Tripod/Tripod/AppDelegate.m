//
//  AppDelegate.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "AppDelegate.h"
#import "WebServiceRequest.h"
@interface NSURLRequest (InvalidSSLCertificate)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end
#define TimeStamp [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000]
NSString const *key = @"a97dcb305adc768";
@interface AppDelegate ()

@end


@implementation AppDelegate 
{
    //SRScreenRecorder *screenRecorder;
}

@synthesize s;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    application.applicationSupportsShakeToEdit = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showActionSheet) name:@"shake" object:nil];
    [self.window addSubview:self.s.view];
    [_window makeKeyAndVisible];
   
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
   
    
    
    return YES;
    
    
    // Override point for customization after application launch.
    
}

- (void)showActionSheet :(NSNotification *)anote
{
    NSLog(@"hello");
}

static void uncaughtExceptionHandler(NSException *exception) {


    TripodViewController *tripodFrame = [TripodViewController new];
    NSLog(@"build %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]);
    [tripodFrame createCrash:exception environmentKey:key appVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] appVersionCode:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] packageName:[[NSBundle mainBundle] bundleIdentifier] appName:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self becomeFirstResponder];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
    
}

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}



@end





