//
//  WebServiceRequest.h
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "Constant.h"
@protocol WebServiceRequestDelegate <NSObject>



@end


@interface WebServiceRequest : NSObject


@property (nonatomic, weak) id <WebServiceRequestDelegate> webServiceDelegate;

-(void)initWithRequestSubURL:(NSString *)subUrl andMethodType:(NSString *)methodtype andBody:(NSString *)abody andViewRef:(UIView *)view anyDataValue:(NSData *)Data;
@end
