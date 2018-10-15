//
//  CommonMethod.m
//  Tripod
//
//  Created by Mohan on 04/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod

+ (CommonMethod *)sharedObject
{
    static dispatch_once_t once;
    static CommonMethod *sharedObject;
    dispatch_once(&once, ^ { sharedObject = [[CommonMethod alloc] init]; });
    return sharedObject;
}

+(void)updateNavigationbarInController:(NSString *)NavigationTitle   navigation:(UINavigationItem *)navigation
{
    
    UIImage* image3 = [UIImage imageNamed:@"navigationbarimage"];
    UIButton *tripodImagebtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [tripodImagebtn setBackgroundImage:image3 forState:UIControlStateNormal];
    
    [tripodImagebtn setFrame:CGRectMake(0, 0, 30, 30)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 05, 150, 20)];
    [label setFont:[UIFont fontWithName:@"Arial-BoldMT" size:15]];
    NSMutableString *UserName  = [[NSMutableString alloc]initWithString:NavigationTitle];
    
    [label setText:UserName];
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
    [tripodImagebtn addSubview:label];
    UIBarButtonItem *tripodNavbarButton = [[UIBarButtonItem alloc] initWithCustomView:tripodImagebtn];
    navigation.leftBarButtonItem=tripodNavbarButton;
    

//    
//    navigation.leftBarButtonItems = [[NSArray alloc]initWithObjects:barButtonItem,barButton, nil];

}

//    UIImage* image3 = [UIImage imageNamed:@"navigationbarimage"];
//    CGRect frameimg = CGRectMake(0, 0, image3.size.width, image3.size.height);
//    UIButton *tripodImagebtn = [[UIButton alloc] initWithFrame:frameimg];
//    [tripodImagebtn setBackgroundImage:image3 forState:UIControlStateNormal];
//
//    [tripodImagebtn setShowsTouchWhenHighlighted:YES];
//
//    UIBarButtonItem *tripodbarbutton =[[UIBarButtonItem alloc] initWithCustomView:tripodImagebtn];
//    navigation.leftBarButtonItem=tripodbarbutton;




@end
