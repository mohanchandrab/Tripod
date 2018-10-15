//
//  EditImageVC.h
//  Tripod
//
//  Created by Mohan on 04/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ACEDrawingView.h"
#import <QuartzCore/QuartzCore.h>
//#import "WebServiceRequest.h"
//#import "AFHTTPSessionManager.h"
@class ACEDrawingView;
@interface EditImageVC : UIViewController<NSURLSessionDelegate,NSURLConnectionDelegate>
{
    CGPoint selectionlocation;
    NSString *editfilename;
    //WebServiceRequest *serviceCall;
}
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property(nonatomic,strong)NSString *editfilename;

//Paint:
@property (nonatomic, unsafe_unretained) IBOutlet ACEDrawingView *drawingView;
@property (nonatomic, unsafe_unretained) IBOutlet UIView *editView;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *undoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *redoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UISlider *lineWidthSlider;
@property (nonatomic, retain) IBOutlet UIButton *dismissView;
@property (nonatomic, retain) IBOutlet UIButton* penButton;
@property BOOL isPickerSeleted;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil fileName:(NSString*)fileName ;

@end
