//
//  ShaketoReportVC.m
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "ShaketoReportVC.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface ShaketoReportVC ()
{
    NSData *imgData;
    
}
@property (strong, nonatomic) NSURL *videoURL;
@property (strong, nonatomic) MPMoviePlayerController *videoController;
@end

@implementation ShaketoReportVC

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)viewDidLoad

{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shakeNotification:)
                                                 //name:@"UIEventSubtypeMotionShakeEnded" object:nil];
    NSLog(@"check move");
    //[self showActionSheet];
    [CommonMethod updateNavigationbarInController:@"Shake TO Report" navigation:self.navigationItem];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbutton"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(shakeNotification)
    //                                                 name:@"shake"
    //                                               object:nil];
    if(event.type == UIEventTypeMotion && event.subtype== UIEventSubtypeMotionShake)
        // [self shakeNotification:@"UIEventSubtypeMotionShakeEnded"];
        [self showActionSheet];
    
    
}


- (void)showActionSheet {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Tripod" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"LEAP" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Video Report" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        // Distructive button tapped.
        //[self shakeNotification:@"UIEventSubtypeMotionShakeEnded"];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Take Screen Report" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        
        [self shakeNotification:@"UIEventSubtypeMotionShakeEnded"];
        
    }]];
    [self dismissViewControllerAnimated:YES completion:^{
        }];
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}
-(void)shakeNotification :(NSNotification *)anote
{
        //NSLog(@"check");
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
            [tri imageCrashEnvironmentKey:@"a97dcb305adc768" appVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] appVersionCode:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] packageName:[[NSBundle mainBundle] bundleIdentifier] appName:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]];
            NSString * str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        } else {
            [tri.view removeFromSuperview];
            [tri.editImageView setImage:image];
        }
        
    }
    
        
}



-(void)goBack
{
     [self.navigationController popViewControllerAnimated:YES];
}
-(void)videoRecoeding :(NSNotification *)anote{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.videoURL = info[UIImagePickerControllerMediaURL];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    self.videoController = [[MPMoviePlayerController alloc] init];
    
    [self.videoController setContentURL:self.videoURL];
    [self.videoController.view setFrame:CGRectMake (0, 0, 320, 460)];
    [self.view addSubview:self.videoController.view];
    
    [self.videoController play];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
