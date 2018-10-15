//
//  EditImageVC.m
//  Tripod
//
//  Created by Mohan on 04/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import "EditImageVC.h"
//#import "NKOColorPickerView.h"
@interface NSURLRequest (InvalidSSLCertificate)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
#define _AFNETWORKING_ALLOW_INVALID_SSL_CERTIFICATES_ 1
@end
@interface EditImageVC ()
//@property (nonatomic, retain) IBOutlet NKOColorPickerView *pickerView;

@end

@implementation EditImageVC
{
    NSURL *url;
}
@synthesize editImageView,editView,drawingView,editfilename,isPickerSeleted,dismissView,penButton;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fileName:(NSString*)fileName ;
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        editfilename = fileName;
    }
    return self;
}
- (void)viewDidLoad {
    
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backbutton"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    //self.navigationItem.rightBarButtonItem = backButtonItem;
    //self.drawingView.delegate = self;
    // start with a black pen
    //self.lineWidthSlider.value = self.drawingView.lineWidth;
  ////  //isPickerSeleted = NO;
    NSString *str = @"file://";
    

#if TARGET_IPHONE_SIMULATOR
    
    editfilename = [editfilename stringByReplacingOccurrencesOfString:str
                                                           withString:@""];
    editfilename = [editfilename stringByReplacingOccurrencesOfString:@"%20"
                                                           withString:@" "];
#else // TARGET_IPHONE_SIMULATOR
    
    // Device specific code
    editfilename = [editfilename stringByReplacingOccurrencesOfString:str
                                                           withString:@""];
    editfilename = [editfilename stringByReplacingOccurrencesOfString:@"%20"
                                                           withString:@" "];
#endif // TARGET_IPHONE_SIMULATOR
    
    
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:editfilename];
    if (fileExists == 0)
    {
        NSLog(@"File is Not exists");
        
    }
    
    NSData *imageData = [NSData dataWithContentsOfFile:editfilename];
    
    UIImage *im = [UIImage imageWithData:imageData];
    [editImageView setImage:im];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) handleTapFrom: (UITapGestureRecognizer *)recognizer
{
    //Code to handle the gesture
    selectionlocation = [recognizer locationInView:self.editImageView];
    if (recognizer.state == UIGestureRecognizerStateEnded)
    {
        //[self imageCropButtonAction:0];
        isPickerSeleted = NO;
        if (self.dismissView)
        {
            // [self.pickerView removeFromSuperview];
            
            [self.dismissView removeFromSuperview];
            // self.drawingView.lineWidth = self.lineWidthSlider.value;
        }
        
        selectionlocation = CGPointZero;
    }
}


- (IBAction)reTakeButtonAction:(id)sender
{
    //    //Camera
    //    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    //    {   [self displayImagePickerControllerWithType:UIImagePickerControllerSourceTypeCamera];
    //    }
    //
    //    else
    //    {
    //       // [self.view makeToast:CAMERA_ERROR];
    //    }
    
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Pen Width"
                                  message:@"                                                                                          "
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
    
    UISlider *mySlider=[[UISlider alloc] initWithFrame:CGRectMake(40, 50, 180, 20)];
    mySlider.maximumValue=20.00;
    mySlider.minimumValue=1.00;
    //mySlider.value = self.drawingView.lineWidth;
    
    [alert.view addSubview:mySlider];
    
    
    [mySlider addTarget:self action:@selector(widthChange:) forControlEvents:UIControlEventValueChanged];
    
    
    UIImageView *smallImagePen=[[UIImageView alloc] initWithFrame:CGRectMake(14, 50, 22, 22)];
    [smallImagePen setImage:[UIImage imageNamed:@"icn_brush_small"]];
    
    [alert.view addSubview:smallImagePen];
    
    
    UIImageView *bigImagePen=[[UIImageView alloc] initWithFrame:CGRectMake(230, 50, 22, 22)];
    [bigImagePen setImage:[UIImage imageNamed:@"icn_brush_big"]];
    
    [alert.view addSubview:bigImagePen];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark- UIImagePickerController Display

//| ----------------------------------------------------------------------------
-(void)displayImagePickerControllerWithType:(UIImagePickerControllerSourceType)pickerType{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    //picker.mediaTypes = [NSArray arrayWithObject:(NSString*)kUTTypeImage];
    
    
    picker.sourceType = pickerType;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}


#pragma mark - UIImagePickerController Delegate Method(s)

//| ----------------------------------------------------------------------------
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
        //                _pictureImageView.image =  [info objectForKey:UIImagePickerControllerEditedImage];
        UIImage *final = [info objectForKey:UIImagePickerControllerEditedImage];
        
        NSData *imgData= UIImageJPEGRepresentation(final,0.0);
        
        
        {
            NSError * error = nil;
            [imgData writeToFile:editfilename options:NSDataWritingAtomic error:&error];
            // [imgData writeToFile:thumImgstr options:NSDataWritingAtomic error:&error];
            
            if (error != nil) {
                NSLog(@"Error: %@", error);
                return;
            }
            
            else
            {
                //[self clear:0];
                NSData *imageData = [NSData dataWithContentsOfFile:editfilename];
                
                UIImage *im = [UIImage imageWithData:imageData];
                [editImageView setImage:im];
                
            }
            
            
        }
        
    }];
}

// ----------------------------------------------------------------------------
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        
        
    }];
}

- (UIImage *)captureView:(UIView*)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//| ----------------------------------------------------------------------------
- (IBAction)attachImageButtonAction:(id)sender
{
    NSLog(@"atttach image button action");
    
    UIImage *final =  [self captureView:self.editImageView];
    float compressionQuality = 0.5;
    UIImage *a = [UIImage imageNamed:@"ic_launcher.png"];
    NSData *imgData= UIImageJPEGRepresentation(a, 1.0);
    NSError * error = nil;
    [imgData writeToFile:editfilename options:NSDataWritingAtomic error:&error];
    // [imgData writeToFile:thumImgstr options:NSDataWritingAtomic error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error);
        return;
    }
    
    else
    {
        [self Back];
    }
    
}

//| ----------------------------------------------------------------------------
- (void)renameFileWithName:(NSString *)srcName toName:(NSString *)dstName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePathSrc = [documentsDirectory stringByAppendingPathComponent:srcName];
    NSString *filePathDst = [documentsDirectory stringByAppendingPathComponent:dstName];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePathSrc]) {
        NSError *error = nil;
        [manager moveItemAtPath:filePathSrc toPath:filePathDst error:&error];
        if (error) {
            NSLog(@"there is an error occur : %@", error);
            [self Back];
        }
    } else {
        NSLog(@"File %@ doesn't exists", srcName);
    }
}

//| ----------------------------------------------------------------------------
- (IBAction)Back
{
    // NSArray *array = [self.navigationController viewControllers];
    [self.navigationController popViewControllerAnimated: YES];
    //[self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
}
//Paint
#pragma mark - PAINT
#pragma mark - ACEDrawing View Delegate

//| ----------------------------------------------------------------------------
//- (void)drawingView:(ACEDrawingView *)view didEndDrawUsingTool:(id<ACEDrawingTool>)tool;
//{
//    [self updateButtonStatus];
//}
//
//#pragma mark - Actions
//
////| ----------------------------------------------------------------------------
//- (void)updateButtonStatus
//{
//    self.undoButton.enabled = [self.drawingView canUndo];
//    self.redoButton.enabled = [self.drawingView canRedo];
//}
//
////| ----------------------------------------------------------------------------
//- (IBAction)undo:(id)sender
//{
//    [self.drawingView undoLatestStep];
//    [self updateButtonStatus];
//}

//| ----------------------------------------------------------------------------



//| ----------------------------------------------------------------------------
//- (IBAction)clear:(id)sender
//{
//    [self.drawingView clear];
//    [self updateButtonStatus];
//    // self.drawingView.drawTool = ACEDrawingToolTypeText;
//}
//
////| ----------------------------------------------------------------------------
//- (IBAction)widthChange:(UISlider *)sender
//{
//    self.drawingView.lineWidth = sender.value;
//}

//| ----------------------------------------------------------------------------
-(void) dissmissButtonAction
{
    isPickerSeleted = NO;
    if (self.dismissView)
    {
        // [self.pickerView removeFromSuperview];
        
        [self.dismissView removeFromSuperview];
        // self.drawingView.lineWidth = self.lineWidthSlider.value;
    }
    
}

-(IBAction)SendImageToServer:(id)sender
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@""
                                  message:@""
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   [self sendEditedImageToServer];
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Summary";
        
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Description";
        //textField.secureTextEntry = YES;
    }];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)sendEditedImageToServer
{
    url = [NSURL URLWithString:@"https://demo01.gendevs.com/tripod-backend/rest/file-upload/crash/b269dc4edef644c?type=imageCrash"];
//    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
//    NSSet *certificates = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certificates];
//    manager.securityPolicy = policy;
//    manager.securityPolicy.allowInvalidCertificates = YES;
    
    UIImage *final =  [self captureView:self.editView];
    UIImage *a = [UIImage imageNamed:@"ic_launcher.png"];
    NSData *imgData= UIImageJPEGRepresentation(final,1.0);
    NSError *error;
    //[imgData writeToFile:editfilename options:NSDataWritingAtomic error:&error];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    [urlRequest setURL:[NSURL URLWithString:@"https://demo01.gendevs.com/tripod-backend/rest/file-upload/crash/b269dc4edef644c?type=imageCrash"]];
    [urlRequest setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    //[urlRequest addValue:@"tCU784RXJ4t14aSM0kRQCy5o8rutTTT3MgLOnoLLablxpcZtPfHujOKZDjhMPICo8mPqaCD1TOVMqwEcmguiQDc1wTXh945NvD9xHkWDQsrmSRrTrcPDBBMl1L9k7XgG" forHTTPHeaderField:@"access_token"];
    [urlRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n",@"file"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[NSData dataWithData:imgData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [urlRequest setHTTPBody:body];
    
    
    //AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    //manager.securityPolicy.allowInvalidCertificates = YES;
    //manager.responseSerializer.acceptableContentTypes = nil;
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if(data.length > 0)
        {
            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            [self imageCrashInfo:(NSString *)text];
        }
    }];
   
   /* NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];

    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:[NSURL URLWithString:@"https://demo01.gendevs.com/tripod-backend/rest/file-upload/crash/b269dc4edef644c?type=imageCrash"]
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                            NSLog(@"Data: %@",text);
                                                        }
                                                        else
                                                        {
                                                            NSLog(@"Error: %@", error);
                                                        }
                                                    }];

    [dataTask resume];*/

    
    
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//
//        } else {
//
//            NSLog(@"Response  %@",responseObject);
//            NSLog(@"success");
//            [self imageCrashInfo:(NSString *)responseObject];
//
//        }
//    }];
//    [dataTask resume];

    
   // [serviceCall initWithRequestSubURL:@"images" andMethodType:@"POST" andBody:jsonString andViewRef:nil anyDataValue:nil];
   // serviceCall.webServiceDelegate=self;
    
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler
{
    completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]);
}
-(void)imageCrashInfo:(NSString *)url
{
    
    UIDevice *myDevice = [UIDevice currentDevice];
    NSString *deviceName = myDevice.name;
    NSString *deviceSystemName = myDevice.systemName;
    NSString *deviceOSVersion = myDevice.systemVersion;
    NSString *deviceModel = myDevice.model;
    NSDateFormatter *Formatter = [[NSDateFormatter alloc] init];
    Formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
    NSString *stringFor = [Formatter stringFromDate:[NSDate date]];
    NSLog(@"Date is %@",stringFor);
    
    NSLog(@"responce %@",url);//[NSString stringWithFormat:@"%@",url],
    NSDictionary *d=[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:11],@"issueNo",@"e18564d32899ece",@"environmentKey",@"https://s3-us-west-2.amazonaws.com/back-bone/organisations/54ede848e4b036074b8be76e/image/crash/1523351044607.png",@"imageUrl",@"From iOS Application",@"summary",@"image Crash report",@"message", @"log message",@"logger",@"1",@"level",@"1.0",@"appVersion",@"Tripod",@"appName",@"1.0",@"appVersionCode",@"iphone5",@"locale",@"com.gendevs.tripod",@"packageName",deviceModel,@"deviceModel",  @"ios9",@"os",deviceOSVersion,@"osVersion",deviceName,@"brand",@"ios",@"board",deviceName, @"device",@"d",@"host",deviceSystemName,@"model",@"Tripod",@"product",@"ios ipad",@"type", @"retina display",@"display",@"MAC",@"hardware",@"2015",@"manufacturer",   @"d",@"cpu",@"123333",@"totalInternalMemory",@"183333",@"availableInternalMemory",nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request1 = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://demo01.gendevs.com/tripod-backend/rest/images"]];
    
    NSMutableData *body1 = [NSMutableData data];
    [body1 appendData:[[NSString stringWithFormat:@"%@",jsonString] dataUsingEncoding:NSUTF8StringEncoding]];
    [request1 setHTTPBody:body1];
    [request1 setHTTPMethod:@"POST"];
//    [request1 addValue:@"5scPZwkdwFJNrVyxHxhZsPhoP8OLNdKQKPHeAQtOkpP4zwRUsvUg5dEzBwVGfWqCbHygxEr8Cr0qF9u3f5gXG3qzBmbTzzNbZGI56AhacPFFOTBx3t9rsOOXj5oR0W3K" forHTTPHeaderField:@"access_token"];
    
    NSString *contentType1 = [NSString stringWithFormat:@"application/json"];
    [request1 setValue:contentType1 forHTTPHeaderField: @"Content-Type"];
    //[request addValue:@"multipart/form-data" forHTTPHeaderField: @"Content-Type"];
    NSURLResponse *response;
    NSData *result = [NSURLConnection sendSynchronousRequest:request1 returningResponse:&response error:&error];
    if (!result) {
        //Display error message here
        NSLog(@"Error");
    } else {
        
        //TODO: set up stuff that needs to work on the data here.
        NSDictionary *dd = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        NSString* responcestr = [dd objectForKey:@"message"];
        //responcestr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        NSLog(@"isues %@", responcestr);
        
    }
}




+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if([challenge.protectionSpace.host isEqualToString:@"demo01.gendevs.com"] /*check if this is host you trust: */ )
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    
}
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        if([challenge.protectionSpace.host isEqualToString:@"demo01.gendevs.com"]){
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
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
