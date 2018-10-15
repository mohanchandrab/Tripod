//
//  ViewController.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <mach/machine.h>
#define MIN(A,B) ((A) <= (B) ? (A) : (B))

@interface ViewController ()
{
    NSData *imgData;
    //SRScreenRecorder *src;
    AppDelegate *appDel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getFreeDiskspace];
    
    
    
    
    //NSLog(@"vale %lu",(unsigned long)sum);
    //getCPUType();
    //NSLog(@"cpu tyope%@",getCPUType());
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *version1 = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-ddTHH:mm:ss.zzzz"];
    
//    NSDate *theDate = [formatter dateFromString:dateString];
//    NSLog(@"The Date: %@", theDate);
    UIDevice *myDevice = [UIDevice currentDevice];
    
    
    NSLog(@"name %@ %@", myDevice.systemName,myDevice.model);
    //[captureView performSelector:@selector(startRecording) withObject:nil afterDelay:1.0];
    //[captureView performSelector:@selector(stopRecording) withObject:nil afterDelay:31.0];
    // Do any additional setup after loading the view, typically from a nib.
}




-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)crash:(id)sender
{
    crashReport = [[CrashRepotingVC alloc]init];
    crashReport = [self.storyboard instantiateViewControllerWithIdentifier:@"CrashReportVC"];
    
    [self.navigationController pushViewController:crashReport animated:YES];
}
-(IBAction)shakeToreport:(id)sender
{
    shakeToReport = [[ShaketoReportVC alloc]init];
    shakeToReport = [self.storyboard instantiateViewControllerWithIdentifier:@"ShaketoCaptureVC"];
    [self.navigationController pushViewController:shakeToReport animated:YES];
    
}
- (BOOL)canBecomeFirstResponder {
    return YES;
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shakeNotification)
                                                 name:@"shake"
                                               object:nil];
    //if(event.type == UIEventTypeMotion && event.subtype== UIEventSubtypeMotionShake)
    //[self shakeNotification:@"UIEventSubtypeMotionShakeEnded"];
    //[self showActionSheet];
    
    
}
-(IBAction)stopRecording:(id)sender
{
    //src= [SRScreenRecorder new];
    //[src stopRecording];
    
    
}

-(void)shakeNotification :(NSNotification *)anote
{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    else
        UIGraphicsBeginImageContext(self.view.bounds.size);
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* Imagename = [documentsDirectory stringByAppendingPathComponent:@"test.png" ];
    
    
    if (!imgData)
    {
        imgData = UIImagePNGRepresentation(image);
        [imgData writeToFile:Imagename atomically:YES];
        tri = [[TripodViewController alloc]initWithNibName:@"TripodViewController" bundle:[NSBundle bundleWithIdentifier:@"com.gendevs.TripodFrame"]];
        
        if(![tri.view isDescendantOfView:self.view]) {
            [self.view addSubview:tri.view];
            [tri.editImageView setImage:image];
            
        } else {
            [tri.view removeFromSuperview];
            [tri.editImageView setImage:image];
        }
    }
}
-(uint64_t)getFreeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
       NSString* totalInternalMemory  =  [NSString stringWithFormat:@"value is: %lld",totalFreeSpace];
        NSLog(@"tota %@",totalInternalMemory);
        NSLog(@"Memory Capacity of %llu MiB with %llu MiB Free memory available.", ((totalSpace/1024ll)/1024ll), ((totalFreeSpace/1024ll)/1024ll));
    } else {
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);
    }
    
    return totalFreeSpace;
}

@end
