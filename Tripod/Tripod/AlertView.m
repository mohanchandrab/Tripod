//
//  AlertView.m
//  Pods-Tripod
//
//  Created by Mohan on 04/10/2018.
//

#import "AlertView.h"

@implementation AlertView
@synthesize isShown;
@synthesize summary,itsTextView;
- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"frame os %@", NSStringFromCGRect(frame));
    self = [super initWithFrame:CGRectMake(50, 200, 280, 200)];
    if (self) {
        originalFrame = frame;
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 3.0f;
        self.alpha = 1;
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *headingText = [[UILabel alloc]initWithFrame:CGRectMake(24, 18, 250, 21)];
        headingText.text = @"Please Summary and Discription";
        headingText.textAlignment = UITextAlignmentCenter;
        headingText.backgroundColor = [UIColor clearColor];
        [self addSubview:headingText];
        
        self.itsTextView = [[UITextView alloc] initWithFrame:CGRectMake(18 , 47, 240, 50)];
        [self.itsTextView setDelegate:self];
        self.itsTextView.textAlignment = UITextAlignmentCenter;
        self.itsTextView.backgroundColor = [UIColor whiteColor];
        self.itsTextView.layer.borderColor=[[UIColor grayColor]CGColor];
        [self.itsTextView setReturnKeyType:UIReturnKeyContinue];
        [self.itsTextView setText:@"Discription"];
        [self.itsTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        [self.itsTextView setTextColor:[UIColor lightGrayColor]];
        self.itsTextView.layer.borderWidth=1.0;
        [self addSubview:self.itsTextView];
        
        summary = [[UITextView alloc] initWithFrame:CGRectMake(18, 107, 240 ,50)];
        [summary setDelegate:self];
        summary.textAlignment = UITextAlignmentCenter;
        summary.backgroundColor = [UIColor whiteColor];
        summary.layer.borderColor=[[UIColor grayColor]CGColor];
        summary.layer.borderWidth=1.0;
        summary.backgroundColor = [UIColor whiteColor];
        summary.layer.borderColor=[[UIColor grayColor]CGColor];
        [summary setReturnKeyType:UIReturnKeyDone];
        [summary setText:@"Summary"];
        [summary setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
        [summary setTextColor:[UIColor lightGrayColor]];
        [self addSubview:summary];
       
       
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        closeButton.frame = CGRectMake(25,161,90,30);
        [closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        closeButton.backgroundColor = [UIColor whiteColor];
        [self addSubview:closeButton];
        
        UIButton *okButton = [UIButton buttonWithType:UIButtonTypeSystem];
        okButton.frame = CGRectMake(135,161,90,30);
        [okButton setTitle:@"Ok" forState:UIControlStateNormal];
        [okButton addTarget:self action:@selector(hide)
           forControlEvents:UIControlEventTouchUpInside];
        okButton.backgroundColor = [UIColor whiteColor];
        [self addSubview:okButton];
    }
    return self;
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.itsTextView.textColor == [UIColor lightGrayColor]) {
        self.itsTextView.text = @"";
        self.itsTextView.textColor = [UIColor blackColor];
    }
    if (summary.textColor == [UIColor lightGrayColor]) {
        summary.text = @"";
        summary.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(self.itsTextView.text.length == 0){
        self.itsTextView.textColor = [UIColor lightGrayColor];
        self.itsTextView.text = @"List words or terms separated by commas";
        [self.itsTextView resignFirstResponder];
    }
    if(summary.text.length == 0){
        summary.textColor = [UIColor lightGrayColor];
        summary.text = @"List words or terms separated by commas";
        [summary resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(self.itsTextView.text.length == 0){
            self.itsTextView.textColor = [UIColor lightGrayColor];
            self.itsTextView.text = @"List words or terms separated by commas";
            [self.itsTextView resignFirstResponder];
        }
        
       else if([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            if(summary.text.length == 0){
                summary.textColor = [UIColor lightGrayColor];
                summary.text = @"List words or terms separated by commas";
                [summary resignFirstResponder];
            }
       
    }
     return NO;
    
}
    return YES;
}
#pragma mark Custom alert methods

- (void)show
{
    NSLog(@"show");
    isShown = YES;
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView beginAnimations:@"showAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 1;
    [UIView commitAnimations];
}

- (void)hide
{
    NSLog(@"hide");
    isShown = NO;
    [UIView beginAnimations:@"hideAlert" context:nil];
    [UIView setAnimationDelegate:self];
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.alpha = 0;
    [UIView commitAnimations];
}

- (void)toggle
{
    if (isShown) {
        [self hide];
    } else {
        [self show];
    }
}

#pragma mark Animation delegate

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    if ([animationID isEqualToString:@"showAlert"]) {
        if (finished) {
            [UIView beginAnimations:nil context:nil];
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [UIView commitAnimations];
        }
    } else if ([animationID isEqualToString:@"hideAlert"]) {
        if (finished) {
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.frame = originalFrame;
        }
    }
}

#pragma mark Touch methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    lastTouchLocation = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint newTouchLocation = [touch locationInView:self];
    CGRect currentFrame = self.frame;
    
    CGFloat deltaX = lastTouchLocation.x - newTouchLocation.x;
    CGFloat deltaY = lastTouchLocation.y - newTouchLocation.y;
    
    self.frame = CGRectMake(currentFrame.origin.x - deltaX, currentFrame.origin.y - deltaY, currentFrame.size.width, currentFrame.size.height);
    lastTouchLocation = [touch locationInView:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


