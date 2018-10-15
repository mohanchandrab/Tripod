//
//  TripodViewController.h
//  TripodFrame
//
//  Created by Mohan on 12/04/2018.
//  Copyright © 2018 Generaldeveopers. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TripodViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *editImageView;
@property(nonatomic,strong)NSString *editfilename;

//Paint:
//
@property (nonatomic, unsafe_unretained) IBOutlet UIView *editView;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *undoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UIButton *redoButton;
@property (nonatomic, unsafe_unretained) IBOutlet UISlider *lineWidthSlider;
@property (nonatomic, retain) IBOutlet UIButton *dismissView;
@property (nonatomic, retain) IBOutlet UIButton* penButton;
@property BOOL isPickerSeleted;

-(void)createCrash:(NSException *)exception environmentKey :(NSString *)key appVersion:(NSString *)version appVersionCode :(NSString *)code packageName :(NSString *)packageName appName:(NSString *)appName;
-(void)sendEditedImageToServer:(NSData *)imgeData;
- (IBAction)ShowPicker:(id)sender;
-(void)imageCrashEnvironmentKey :(NSString *)key appVersion:(NSString *)version appVersionCode :(NSString *)code packageName :(NSString *)packageName appName:(NSString *)appName;
@end
