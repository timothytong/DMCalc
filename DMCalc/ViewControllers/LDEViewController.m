//
//  LDEViewController.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-03.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//
/*
 The MIT License (MIT)
 
 Copyright (c) [2014] [Timothy Tong]
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

#import "LDEViewController.h"
#import "Constants.h"

@interface LDEViewController ()
@property (weak, nonatomic) IBOutlet UILabel *iPadResultLabel;
@property (weak, nonatomic) IBOutlet UILabel *iPadHeader;
@property (strong, nonatomic) UITextField* xInput;
@property (strong, nonatomic) UITextField* yInput;
@property (strong, nonatomic) UITextField* zInput;
@property (strong, nonatomic) UILabel *outputOne;
@property (strong, nonatomic) UILabel *outputTwo;
@property (strong, nonatomic) UILabel *outputThree;
@property (strong, nonatomic) UILabel *outputFour;
@property (strong, nonatomic) UIButton *computeButton;
@property (strong, nonatomic) UIButton *right;
@property (strong, nonatomic) UIButton *left;
@property (readwrite ,nonatomic)BOOL isAnimating;
@property (nonatomic) int ansOne;
@property (nonatomic) int ansTwo;
@property (nonatomic) int coefficientOne;
@property (nonatomic) int coefficientTwo;

@end

@implementation LDEViewController
@synthesize ldeCalc;
@synthesize gcdCalc;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.xInput resignFirstResponder];
    [self.yInput resignFirstResponder];
    [self.zInput resignFirstResponder];
}

- (void)compute:(id)sender
{
    x = [self.xInput.text intValue];
    y = [self.yInput.text intValue];
    z = [self.zInput.text intValue];
    
    [self.xInput resignFirstResponder];
    [self.yInput resignFirstResponder];
    [self.zInput resignFirstResponder];
    
    if(x == 0 || y == 0 || z == 0 || x == 1 || y == 1) {
        [self prompt:@"Invalid Inputs" :@"Please double-check inputs. \nInput(s) cannot be 0, coefficitents of x and y cannot be 1"];
    }
    else if(abs(x) >= INT32_MAX-1||abs(y) >= INT32_MAX-1||abs(z) >= INT32_MAX-1){
        [self prompt:@"Error" :[NSString stringWithFormat:@"Input bounds [%d to %d]",INT32_MIN,INT32_MAX]];
    }
    else if (abs(x) == abs(y)){
        [self prompt:@"Invalid Inputs" :@"Inputs should be different numbers"];
    }
    else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.outputOne.alpha = 0;
            self.outputTwo.alpha = 0;
            self.outputFour.alpha = 0;
            self.outputThree.alpha = 0;
            self.left.alpha = 0;
            self.right.alpha = 0;
        } completion:^(BOOL finished) {
            ldeCalc = [[LDECalc alloc]init];
            NSArray* coefficients = [ldeCalc solveLDE:x :y :z];
            if(coefficients == nil){
                self.outputOne.text = @"";
                self.outputTwo.text = @"";
                self.outputThree.text = @"";
                self.outputFour.text = @"";
                [self prompt:@"Notice" :@"No solution"];
            }
            else{
                //            gcdCalc = [[GCDCalc alloc]init];
                //            int gcd = [gcdCalc calculateGCD:x :y];
                //            int multiplier = z / gcd;
                /*
                 if (!IS_IPHONE5 && !IS_IPAD)
                 {
                 self.outputOne.text = [NSString stringWithFormat:@"x=%d±%dn", [[coefficients objectAtIndex:0] intValue], y/gcd];
                 self.outputTwo.text = [NSString stringWithFormat:@"y=%d∓%dn", [[coefficients objectAtIndex:1] intValue], x/gcd];
                 
                 } else {
                 */
                self.outputOne.text = [NSString stringWithFormat:@"x = %d", [[coefficients objectAtIndex:0] intValue]]; //* multiplier];
                self.ansOne =[[coefficients objectAtIndex:0] intValue];
                self.outputTwo.text = [NSString stringWithFormat:@"   ±  %dn", y / gcd];
                self.coefficientOne = y/gcd;
                
                self.outputThree.text = [NSString stringWithFormat:@"y = %d", [[coefficients objectAtIndex:1] intValue]]; //* multiplier];
                self.ansTwo =[[coefficients objectAtIndex:1] intValue];
                self.outputFour.text = [NSString stringWithFormat:@"   ∓  %dn", x / gcd];
                self.coefficientTwo = x/gcd;
                NSLog(@"CO1 = %d",self.coefficientOne);
                NSLog(@"CO2 = %d",self.coefficientTwo);
                //}
                [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.outputOne.alpha = 1;
                    self.outputThree.alpha = 1;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.outputTwo.alpha = 1;
                        self.outputFour.alpha = 1;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.left.alpha = 1;
                            self.right.alpha = 1;
                        } completion:^(BOOL finished) {
                        }];
                        
                    }];
                }];
            }
        }]; 
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //TODO: add in SIMPLIFY RESULTS feature.
    [super viewDidLoad];
    self.isAnimating = NO;
    UILabel *xPlus = [[UILabel alloc]init];
    UILabel *yEquals = [[UILabel alloc]init];
    UILabel *resultLabel = [[UILabel alloc]init];
    self.xInput = [[UITextField alloc]init];
    self.yInput = [[UITextField alloc]init];
    self.zInput = [[UITextField alloc]init];
    self.outputOne = [[UILabel alloc]init];
    self.outputTwo = [[UILabel alloc]init];
    self.outputThree = [[UILabel alloc]init];
    self.outputFour = [[UILabel alloc]init];
    self.computeButton = [[UIButton alloc]init];
    self.computeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
    self.left = [[UIButton alloc]init];
    self.right = [[UIButton alloc]init];
    
    self.ansOne = 0;
    self.ansTwo = 0;
    self.coefficientOne = 0;
    self.coefficientTwo = 0;
    
    CGFloat offset = 0;
    CGFloat side= 40;
    if (IS_IPAD) {
        side = 50;
    }
    if (!IS_IOS7 && (IS_IPHONE5 || IS_IPAD)) {
        offset += 50;
    }
    else if(!IS_IOS7){
        offset += 30;
        side= 35;
    }
    
    self.left = [UIButton buttonWithType:UIButtonTypeCustom];
    self.left.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 45- offset, side, side);
    UIImage *leftImage = [UIImage imageNamed:@"/leftArrow.png"];
    [self.left setImage:leftImage forState:UIControlStateNormal];
    
    self.right = [UIButton buttonWithType:UIButtonTypeCustom];
    self.right.frame = CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 45- offset, side,side);
    UIImage *rightImage = [UIImage imageNamed:@"/rightArrow.png"];
    [self.right setImage:rightImage forState:UIControlStateNormal];
    self.left.alpha = 0;
    self.right.alpha = 0;
    [self.left addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.right addTarget:self action:@selector(rightButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.left];
    [self.view addSubview:self.right];
    
    
    UIImageView *leftLine =[[UIImageView alloc]init];
    UIImageView *rightLine = [[UIImageView alloc]init];
    UILabel *header = [[UILabel alloc]init];
    UILabel *subHeader = [[UILabel alloc]init];
    xPlus.text = @"x+";
    yEquals.text = @"y=";
    header.text = @"Enter Coefficients.";
    subHeader.text = @"Linear Diophantine Equation:";
    resultLabel.text = @"Result";
    leftLine.backgroundColor = [UIColor blackColor];
    rightLine.backgroundColor = [UIColor blackColor];
    
    if (IS_IPHONE5) {
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 238, 80, 30);
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            
            header.frame = CGRectMake(20, 88, self.view.frame.size.width - 40, 40);
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            subHeader.frame = CGRectMake(20, 143, self.view.frame.size.width - 40, 30);
            subHeader.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
            self.xInput.frame = CGRectMake(20, 200, 70, 30);
            self.xInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xInput.textAlignment = NSTextAlignmentCenter;
            self.xInput.keyboardType = UIKeyboardTypeNumberPad;
            self.xInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            xPlus.frame = CGRectMake(98, 202, 21, 25);
            xPlus.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            self.yInput.frame = CGRectMake(122, 200, 70, 30);
            self.yInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yInput.textAlignment = NSTextAlignmentCenter;
            self.yInput.keyboardType = UIKeyboardTypeNumberPad;
            self.yInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            yEquals.frame = CGRectMake(200, 202, 25, 25);
            yEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            self.zInput.frame = CGRectMake(230, 200, 70, 30);
            self.zInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.zInput.textAlignment = NSTextAlignmentCenter;
            self.zInput.keyboardType = UIKeyboardTypeNumberPad;
            self.zInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            resultLabel.frame = CGRectMake(111, 290, 98, 32);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35.0];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            self.outputOne.frame = CGRectMake(20, 338, 275, 40);
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.frame = CGRectMake(20, 386, 274, 40);
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.frame = CGRectMake(20, 434, 274, 40);
            self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.frame = CGRectMake(20, 482, 274, 40);
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputFour.textColor = [UIColor blackColor];
        }
        else{
            self.computeButton.frame = CGRectMake(220, 238-50, 85, 30);
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            
            header.frame = CGRectMake(20, 28, self.view.frame.size.width - 40, 40);
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            subHeader.frame = CGRectMake(20, 83, self.view.frame.size.width - 40, 30);
            subHeader.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:22];
            self.xInput.frame = CGRectMake(20, 130, 70, 30);
            self.xInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xInput.textAlignment = NSTextAlignmentCenter;
            self.xInput.keyboardType = UIKeyboardTypeNumberPad;
            self.xInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            xPlus.frame = CGRectMake(98, 132, 21, 25);
            xPlus.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:20];
            self.yInput.frame = CGRectMake(122, 130, 70, 30);
            self.yInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yInput.textAlignment = NSTextAlignmentCenter;
            self.yInput.keyboardType = UIKeyboardTypeNumberPad;
            self.yInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            yEquals.frame = CGRectMake(200, 132, 25, 25);
            yEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:20];
            self.zInput.frame = CGRectMake(230, 130, 70, 30);
            self.zInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.zInput.textAlignment = NSTextAlignmentCenter;
            self.zInput.keyboardType = UIKeyboardTypeNumberPad;
            self.zInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            resultLabel.frame = CGRectMake(111, 230, 98, 32);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35.0];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            self.outputOne.frame = CGRectMake(20, 278, 275, 40);
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.frame = CGRectMake(20, 326, 274, 40);
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.frame = CGRectMake(20, 374, 274, 40);
            self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.frame = CGRectMake(20, 422, 274, 40);
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputFour.textColor = [UIColor blackColor];
            
        }
    }
    else if (!IS_IPHONE5 && !IS_IPAD){
        if (IS_IOS7) {
            header.frame = CGRectMake(20, 73, self.view.frame.size.width - 40, 40);
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            subHeader.frame = CGRectMake(20, 113, self.view.frame.size.width - 40, 30);
            subHeader.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
            self.xInput.frame = CGRectMake(20, 150, 70, 30);
            self.xInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xInput.textAlignment = NSTextAlignmentCenter;
            self.xInput.keyboardType = UIKeyboardTypeNumberPad;
            self.xInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            xPlus.frame = CGRectMake(98, 152, 21, 25);
            xPlus.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            self.yInput.frame = CGRectMake(122, 150, 70, 30);
            self.yInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yInput.textAlignment = NSTextAlignmentCenter;
            self.yInput.keyboardType = UIKeyboardTypeNumberPad;
            self.yInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            yEquals.frame = CGRectMake(200, 152, 25, 25);
            yEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            self.zInput.frame = CGRectMake(230, 150, 70, 30);
            self.zInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.zInput.textAlignment = NSTextAlignmentCenter;
            self.zInput.keyboardType = UIKeyboardTypeNumberPad;
            self.zInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            resultLabel.frame = CGRectMake(111, 220, 98, 32);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35.0];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            self.outputOne.frame = CGRectMake(20, 268, 275, 40);
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.frame = CGRectMake(20, 316, 274, 40);
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.frame = CGRectMake(20, 364, 274, 40);
            self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.frame = CGRectMake(20, 412, 274, 40);
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputFour.textColor = [UIColor blackColor];
            self.computeButton.frame = CGRectMake(220, 238 - 50, 80, 30);
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            
        }
        else{
            header.frame = CGRectMake(20, 23, self.view.frame.size.width - 40, 40);
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            subHeader.frame = CGRectMake(20, 63, self.view.frame.size.width - 40, 30);
            subHeader.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:22];
            self.xInput.frame = CGRectMake(20, 105, 70, 30);
            self.xInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xInput.textAlignment = NSTextAlignmentCenter;
            self.xInput.keyboardType = UIKeyboardTypeNumberPad;
            self.xInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            xPlus.frame = CGRectMake(98, 107, 23, 25);
            xPlus.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yInput.frame = CGRectMake(122, 105, 70, 30);
            self.yInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yInput.textAlignment = NSTextAlignmentCenter;
            self.yInput.keyboardType = UIKeyboardTypeNumberPad;
            self.yInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            yEquals.frame = CGRectMake(200, 107, 25, 25);
            yEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.zInput.frame = CGRectMake(230, 105, 70, 30);
            self.zInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.zInput.textAlignment = NSTextAlignmentCenter;
            self.zInput.keyboardType = UIKeyboardTypeNumberPad;
            self.zInput.clearButtonMode = UITextFieldViewModeWhileEditing;
            resultLabel.frame = CGRectMake(111, 150 + 50, 98, 32);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35.0];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            self.outputOne.frame = CGRectMake(20, 198 + 40, 275, 40);
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.frame = CGRectMake(20, 246 + 30, 274, 40);
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.frame = CGRectMake(20, 294 + 20, 274, 40);
            self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:27];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.frame = CGRectMake(20, 342 + 10, 274, 40);
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:27];
            self.outputFour.textColor = [UIColor blackColor];
            self.computeButton.frame = CGRectMake(220, 238 - 80, 85, 30);
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            
        }
    }
    else if (IS_IPAD){
        if (!IS_IOS7) {
            [self.iPadHeader removeFromSuperview];
            [self.iPadResultLabel removeFromSuperview];
            self.iPadHeader.frame = CGRectMake(191, 265, 670, 70);
            self.iPadResultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:50];
            self.iPadHeader.textAlignment = NSTextAlignmentLeft;
            [self.iPadHeader sizeToFit];
            self.iPadHeader.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
            [self.view addSubview:self.iPadHeader];
            [self.view addSubview:self.iPadResultLabel];
        }
        self.xInput.frame = CGRectMake(68, 400, 170, 30);
        self.xInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
        self.xInput.textAlignment = NSTextAlignmentCenter;
        self.xInput.keyboardType = UIKeyboardTypeNumberPad;
        self.xInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        xPlus.frame = CGRectMake(251, 392, 60, 45);
        xPlus.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
        self.yInput.frame = CGRectMake(294, 400, 170, 30);
        self.yInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
        self.yInput.textAlignment = NSTextAlignmentCenter;
        self.yInput.keyboardType = UIKeyboardTypeNumberPad;
        self.yInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        yEquals.frame = CGRectMake(476, 392, 60, 46);
        yEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
        self.zInput.frame = CGRectMake(524, 400, 170, 30);
        self.zInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
        self.zInput.textAlignment = NSTextAlignmentCenter;
        self.zInput.keyboardType = UIKeyboardTypeNumberPad;
        self.zInput.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        self.outputOne.frame = CGRectMake(49, 639, 670, 60);
        self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
        self.outputOne.textColor = [UIColor blackColor];
        self.outputTwo.frame = CGRectMake(49, 706, 670, 60);
        self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:50];
        self.outputTwo.textColor = [UIColor blackColor];
        self.outputThree.frame = CGRectMake(49, 776, 670, 60);
        self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
        self.outputThree.textColor = [UIColor blackColor];
        self.outputFour.frame = CGRectMake(48, 842, 670, 60);
        self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:50];
        self.outputFour.textColor = [UIColor blackColor];
        self.computeButton.frame = CGRectMake(538, 487, 162, 50);
        UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 50)];
        computeButtonLabel.textAlignment = NSTextAlignmentCenter;
        computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
        computeButtonLabel.text = @"Compute";
        computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        [self.computeButton addSubview:computeButtonLabel];
    }
    
    
    
    
    
    
    leftLine.frame = CGRectMake(20, resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2), self.view.frame.size.width / 2 - 20 - (resultLabel.frame.size.width / 2), 1);
    rightLine.frame = CGRectMake((self.view.frame.size.width / 2) + (resultLabel.frame.size.width / 2), resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2),leftLine.frame.size.width, 1);
    self.xInput.layer.cornerRadius = 10;
    self.xInput.layer.borderWidth = 0.5;
    self.yInput.layer.cornerRadius = 10;
    self.yInput.layer.borderWidth = 0.5;
    self.zInput.layer.cornerRadius = 10;
    self.zInput.layer.borderWidth = 0.5;
    [self.view addSubview:header];
    [self.view addSubview:subHeader];
    [self.view addSubview:self.xInput];
    [self.view addSubview:xPlus];
    [self.view addSubview:self.yInput];
    [self.view addSubview:yEquals];
    [self.view addSubview:self.zInput];
    [self.view addSubview:resultLabel];
    [self.view addSubview:leftLine];
    [self.view addSubview:rightLine];
    
    //    if (IS_IPHONE5 || IS_IPAD) {
    [self.view addSubview:self.outputOne];
    [self.view addSubview:self.outputTwo];
    [self.view addSubview:self.outputThree];
    [self.view addSubview:self.outputFour];
    [self.view addSubview:self.computeButton];
    self.outputOne.alpha = 0;
    self.outputTwo.alpha = 0;
    self.outputFour.alpha = 0;
    self.outputThree.alpha = 0;
    //    }
    //    else{
    //
    //    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prompt:(NSString*)title
              :(NSString*)content
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: content
                                                   delegate: nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)leftButtonPressed:(id)sender
{
    if (!self.isAnimating) {
        self.isAnimating = YES;
        self.ansOne -= self.coefficientTwo;
        self.ansTwo += self.coefficientOne;
        CGFloat originalX = self.outputOne.frame.origin.x;
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.outputTwo.alpha = 0;
                             self.outputFour.alpha = 0;
                         } completion:^(BOOL finished) {
                             self.outputTwo.text = [NSString stringWithFormat:@"   - %dn",self.coefficientTwo];
                             self.outputFour.text = [NSString stringWithFormat:@"   + %dn",self.coefficientOne];
                             [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  self.outputTwo.alpha = 1;
                                                  self.outputFour.alpha = 1;
                                              } completion:^(BOOL finished) {
                                              }];
                         }];
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.outputOne.frame = CGRectMake(-self.view.frame.size.width, self.outputOne.frame.origin.y, self.outputOne.frame.size.width, self.outputOne.frame.size.height);
            self.outputThree.frame = CGRectMake(self.view.frame.size.width, self.outputThree.frame.origin.y, self.outputThree.frame.size.width, self.outputThree.frame.size.height);
            self.outputOne.alpha = 0;
            self.outputThree.alpha = 0;
        } completion:^(BOOL finished) {
            self.outputOne.frame = CGRectMake(self.view.frame.size.width, self.outputOne.frame.origin.y, self.outputOne.frame.size.width, self.outputOne.frame.size.height);
            self.outputThree.frame =CGRectMake(-self.view.frame.size.width, self.outputThree.frame.origin.y, self.outputThree.frame.size.width, self.outputThree.frame.size.height);
            self.outputOne.text = [NSString stringWithFormat:@"x = %d",self.ansOne];
            self.outputThree.text = [NSString stringWithFormat:@"y = %d",self.ansTwo];
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.outputOne.frame = CGRectMake(originalX, self.outputOne.frame.origin.y, self.outputOne.frame.size.width, self.outputOne.frame.size.height);
                self.outputThree.frame = CGRectMake(originalX, self.outputThree.frame.origin.y, self.outputThree.frame.size.width, self.outputThree.frame.size.height);
                self.outputOne.alpha = 1;
                self.outputThree.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     self.outputTwo.alpha = 0;
                                     self.outputFour.alpha = 0;
                                 } completion:^(BOOL finished) {
                                     self.outputTwo.text = [NSString stringWithFormat:@"   ±  %dn",self.coefficientTwo];
                                     self.outputFour.text = [NSString stringWithFormat:@"   ∓  %dn",self.coefficientOne];
                                     [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                                      animations:^{
                                                          self.outputTwo.alpha = 1;
                                                          self.outputFour.alpha = 1;
                                                      } completion:^(BOOL finished) {
                                                          self.isAnimating = NO;
                                                      }];
                                 }];
                
            }];
            
        }];
        
    }
    
}

-(void)rightButtonPressed:(id)sender
{
    if (!self.isAnimating) {
        self.isAnimating = YES;
        self.ansOne += self.coefficientTwo;
        self.ansTwo -= self.coefficientOne;
        CGFloat originalX = self.outputOne.frame.origin.x;
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.outputTwo.alpha = 0;
                             self.outputFour.alpha = 0;
                         } completion:^(BOOL finished) {
                             self.outputTwo.text = [NSString stringWithFormat:@"   + %dn",self.coefficientTwo];
                             self.outputFour.text = [NSString stringWithFormat:@"   - %dn",self.coefficientOne];
                             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                              animations:^{
                                                  self.outputTwo.alpha = 1;
                                                  self.outputFour.alpha = 1;
                                              } completion:^(BOOL finished) {
                                              }];
                         }];
        [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.outputOne.frame = CGRectMake(self.view.frame.size.width, self.outputOne.frame.origin.y, self.outputOne.frame.size.width, self.outputOne.frame.size.height);
            self.outputThree.frame = CGRectMake(-self.view.frame.size.width, self.outputThree.frame.origin.y, self.outputThree.frame.size.width, self.outputThree.frame.size.height);
            self.outputOne.alpha = 0;
            self.outputThree.alpha = 0;
        } completion:^(BOOL finished) {
            self.outputOne.frame = CGRectMake(-self.view.frame.size.width, self.outputOne.frame.origin.y, self.outputOne.frame.size.width, self.outputOne.frame.size.height);
            self.outputThree.frame =CGRectMake(self.view.frame.size.width, self.outputThree.frame.origin.y, self.outputThree.frame.size.width, self.outputThree.frame.size.height);
            self.outputOne.text = [NSString stringWithFormat:@"x = %d",self.ansOne];
            self.outputThree.text = [NSString stringWithFormat:@"y = %d",self.ansTwo];
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.outputOne.frame = CGRectMake(originalX, self.outputOne.frame.origin.y, self.outputOne.frame.size.width, self.outputOne.frame.size.height);
                self.outputThree.frame = CGRectMake(originalX, self.outputThree.frame.origin.y, self.outputThree.frame.size.width, self.outputThree.frame.size.height);
                self.outputOne.alpha = 1;
                self.outputThree.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     self.outputTwo.alpha = 0;
                                     self.outputFour.alpha = 0;
                                 } completion:^(BOOL finished) {
                                     self.outputTwo.text = [NSString stringWithFormat:@"   ±  %dn",self.coefficientTwo];
                                     self.outputFour.text = [NSString stringWithFormat:@"   ∓  %dn",self.coefficientOne];
                                     [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut
                                                      animations:^{
                                                          self.outputTwo.alpha = 1;
                                                          self.outputFour.alpha = 1;
                                                      } completion:^(BOOL finished) {
                                                          self.isAnimating = NO;
                                                      }];
                                 }];
                
            }];
            
        }];
        
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
