//
//  ShaketoReportVC.h
//  Tripod
//
//  Created by Mohan on 03/03/16.
//  Copyright © 2016 GeneralDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMethod.h"
#import "EditImageVC.h"

@interface ShaketoReportVC : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    EditImageVC *editImageVC;
    TripodViewController *tri;
}
-(void)chek;
@end
