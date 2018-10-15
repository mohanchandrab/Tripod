//
//  WebServiceRequest.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "WebServiceRequest.h"
//#import "Constant.h"
@implementation WebServiceRequest
@synthesize webServiceDelegate;


-(void)initWithRequestSubURL:(NSString *)subUrl andMethodType:(NSString *)methodtype andBody:(NSString *)abody andViewRef:(UIView *)view anyDataValue:(NSData *)Data

{
//    if (![SERVERURL containsString:subUrl]) {
//        SERVERURL =[SERVERURL stringByAppendingString:subUrl];
//    }
//    NSLog(@"urlstring %@",SERVERURL);
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:SERVERURL]];
//    NSError *error;
//
////    if ([methodtype isEqualToString:getMethod])
////    {
////
////
////    //[request setHTTPBody:body];
////    [request setHTTPMethod:methodtype];
////    [request addValue:@"" forHTTPHeaderField:@"access_token"];
////
////    [request addValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
////    }
////    else
////    {
//        NSMutableData *body = [NSMutableData data];
//        [body appendData:[[NSString stringWithFormat:@"%@",abody] dataUsingEncoding:NSUTF8StringEncoding]];
//        [request setHTTPBody:body];
//        [request setHTTPMethod:methodtype];
//        //[request addValue:@"" forHTTPHeaderField:@"access_token"];
//        NSString *contentType = [NSString stringWithFormat:@"application/json"];
//        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
//        //[request addValue:@"multipart/form-data" forHTTPHeaderField: @"Content-Type"];
//    //}
//
//
//    NSURLResponse *response;
//
//    NSData *result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//    if (!result) {
//        //Display error message here
//        NSLog(@"Error");
//    } else {
//
//        //TODO: set up stuff that needs to work on the data here.
//
//        NSDictionary *dd = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
//       NSString* responcestr = [dd objectForKey:@"message"];
//        //responcestr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
//        NSLog(@"isues %@", responcestr);
//
//    }
//
//
//
}




@end

