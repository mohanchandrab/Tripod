//
//  NSURLRequest+IgnoreSSL.m
//  Tripod
//
//  Created by Mohan on 30/08/2018.
//  Copyright © 2018 GeneralDevelopers. All rights reserved.
//

#import "NSURLRequest+IgnoreSSL.h"

@implementation NSURLRequest (IgnoreSSL)


    + (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host
    {
        // ignore certificate errors only for this domain
        if ([host hasSuffix:@"demo.gendevs.com"])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    @end
