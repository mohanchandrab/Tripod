//
//  CrashRepotingVC.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "CrashRepotingVC.h"
#import "CommonMethod.h"
@interface CrashRepotingVC ()

@end

@implementation CrashRepotingVC

- (void)viewDidLoad {
    
    [CommonMethod updateNavigationbarInController:@"Crash To Report" navigation:self.navigationItem];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbutton"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)createCrash:(id)sender
{
    NSArray *arrayWithOnlyTwoElements = [[NSArray alloc]initWithObjects:@"s",@"d", nil];
    NSString *crash = [arrayWithOnlyTwoElements objectAtIndex:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
