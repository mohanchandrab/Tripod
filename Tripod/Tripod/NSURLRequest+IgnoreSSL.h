//
//  NSURLRequest+IgnoreSSL.h
//  Tripod
//
//  Created by Mohan on 30/08/2018.
//  Copyright © 2018 GeneralDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLRequest (IgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;

@end
