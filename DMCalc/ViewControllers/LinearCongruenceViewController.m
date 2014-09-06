//
//  LinearCongruenceViewController.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-24.
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

#import "LinearCongruenceViewController.h"
#import "Constants.h"

@interface LinearCongruenceViewController ()
@property (strong, nonatomic) UILabel *outputOne;
@property (strong, nonatomic) UILabel *outputTwo;
@property (strong, nonatomic) UITextField *coInput;
@property (strong, nonatomic) UITextField *reInput;
@property (strong, nonatomic) UITextField *modInput;
@property (strong, nonatomic) UIButton *computeButton;
@property (weak, nonatomic) IBOutlet UILabel *iPadXEquals;
@property (weak, nonatomic) IBOutlet UILabel *iPadOpenBrackets;
@property (weak, nonatomic) IBOutlet UILabel *iPadHeader;
@property (weak, nonatomic) IBOutlet UILabel *iPadResultLabel;

@end

@implementation LinearCongruenceViewController
@synthesize gcdCalc;
@synthesize ldeCalc;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.coInput resignFirstResponder];
    [self.reInput resignFirstResponder];
    [self.modInput resignFirstResponder];
}

- (void)compute:(id)sender
{
    a = [self.coInput.text intValue];
    b = [self.reInput.text intValue];
    m = [self.modInput.text intValue];
    
    [self.coInput resignFirstResponder];
    [self.reInput resignFirstResponder];
    [self.modInput resignFirstResponder];
    
    if( a == 0 || m == 0 ){
        [self prompt:@"Invalid Inputs" :@"Please doublecheck inputs."];
    }
    else if (self.coInput.text.length == 0 || self.reInput.text.length == 0 || self.modInput.text.length == 0 ) {
        [self prompt:@"Error" :@"Empty input(s)"];
    }
    else if(abs(a) >= INT32_MAX-1||abs(b) >= INT32_MAX-1 || abs(m) >= INT32_MAX-1){
        [self prompt:@"Error" :[NSString stringWithFormat:@"Input bounds \n%d to %d",INT32_MIN,INT32_MAX]];
    }
    
    else{
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.outputOne.alpha = 0;
            self.outputTwo.alpha = 0;
        } completion:^(BOOL finished) {
            gcdCalc = [[GCDCalc alloc]init];
            gcd = [gcdCalc calculateGCD:a :m];
            
            //        int multipler = b/gcd;
            if (b % gcd != 0) {
                [self prompt:@"Notice" :@"No solutions."];
                self.outputTwo.text = @"";
                self.outputOne.text = @"";
            }
            else{
                ldeCalc = [[LDECalc alloc]init];
                NSArray* soln = [ldeCalc solveLDE:a :m :b];
                ans = [[soln objectAtIndex:0] intValue];
                //            ans *= multipler;
                if (ans < 0) {
                    while (ans < 0) {
                        ans += (m/gcd);
                    }
                }
                else if (ans > (m/gcd)){
                    while (ans > (m/gcd)){
                        ans -= (m/gcd);
                    }
                }
                else if (ans == (m/gcd)){
                    ans = 0;
                }
                UILabel *solToLabel;
                if (IS_IPHONE5) {
                    CGFloat solLabely = 295;
                    if (!IS_IOS7) {
                        solLabely-=60;
                    }
                    solToLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, solLabely, 280, 80)];
                    solToLabel.numberOfLines = 2;
                    solToLabel.text = @"Solutions to\nLinear Congruence";
                    solToLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:25];
                    [self.view addSubview:solToLabel];
                    
                }
                else if(!IS_IPHONE5 && !IS_IPAD) {
                    CGFloat solLabely = 265;
                    if (!IS_IOS7) {
                        solLabely-=60;
                    }
                    solToLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, solLabely, 280, 60)];
                    solToLabel.numberOfLines = 2;
                    solToLabel.text = @"Solutions to\nLinear Congruence";
                    solToLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:22];
                    solToLabel.alpha = 0;
                    [self.view addSubview:solToLabel];
                }
                else{
                    //ipad
                    CGFloat solLabely = 589;
                    solToLabel = [[UILabel alloc]initWithFrame:CGRectMake(48, solLabely, 670, 60)];
                    solToLabel.numberOfLines = 2;
                    solToLabel.text = @"Solutions to Linear Congruence";
                    solToLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:48];
                    solToLabel.alpha = 0;
                    [self.view addSubview:solToLabel];
                }
                if (!IS_IPAD) {
                    self.outputOne.text = [NSString stringWithFormat:@"%d x = %d (%d):", a, b, m];
                }
                else{
                    self.outputOne.text = [NSString stringWithFormat:@"%d x = %d (mod %d):", a, b, m];
                }
                self.outputTwo.text = [NSString stringWithFormat:@"x = %d (mod %d)", ans, m/gcd];
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    solToLabel.alpha = 1;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.outputOne.alpha = 1;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.outputTwo.alpha = 1;
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
    [super viewDidLoad];
    UILabel *header = [[UILabel alloc]init];
    UILabel *xEquals = [[UILabel alloc]init];
    UILabel *openBracket = [[UILabel alloc]init];
    UILabel *closeBracket = [[UILabel alloc]init];
    self.outputOne = [[UILabel alloc]init];
    self.outputTwo = [[UILabel alloc]init];
    self.coInput = [[UITextField alloc]init];
    self.reInput = [[UITextField alloc]init];
    self.modInput = [[UITextField alloc]init];
    self.computeButton = [[UIButton alloc]init];
    UILabel *resultLabel = [[UILabel alloc]init];
    UIImageView *leftLine = [[UIImageView alloc]init];
    UIImageView *rightLine = [[UIImageView alloc]init];
    header.text = @"Enter Numbers.";
    xEquals.text = @"x =";
    openBracket.text = @"(MOD ";
    xEquals.textAlignment = NSTextAlignmentCenter;
    openBracket.textAlignment = NSTextAlignmentCenter;
    closeBracket.text = @")";
    closeBracket.textAlignment = NSTextAlignmentCenter;
    resultLabel.text = @"Result";
    resultLabel.textColor = [UIColor blackColor];
    leftLine.backgroundColor = [UIColor blackColor];
    rightLine.backgroundColor = [UIColor blackColor];
    self.coInput.layer.cornerRadius = 10;
    self.coInput.layer.borderWidth = 0.5;
    self.coInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.coInput.textAlignment = NSTextAlignmentCenter;
    self.coInput.keyboardType = UIKeyboardTypeNumberPad;
    self.coInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.coInput.placeholder = @"Coefficient";
    
    self.reInput.layer.cornerRadius = 10;
    self.reInput.layer.borderWidth = 0.5;
    self.reInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.reInput.textAlignment = NSTextAlignmentCenter;
    self.reInput.keyboardType = UIKeyboardTypeNumberPad;
    self.reInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.reInput.placeholder = @"Remainder";
    
    self.modInput.layer.cornerRadius = 10;
    self.modInput.layer.borderWidth = 0.5;
    self.modInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.modInput.textAlignment = NSTextAlignmentCenter;
    self.modInput.keyboardType = UIKeyboardTypeNumberPad;
    self.modInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.modInput.placeholder = @"Mod";
    
    if (IS_IPHONE5) {
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 235, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            header.frame = CGRectMake(20, 80, 280, 46);
            xEquals.frame = CGRectMake(141, 143, 26, 36);
            xEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            openBracket.frame = CGRectMake(126, 194, 46, 36);
            openBracket.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            closeBracket.frame = CGRectMake(293, 194, 7, 36);
            closeBracket.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            resultLabel.frame = CGRectMake(111, 262, 98, 40);
            self.reInput.frame = CGRectMake(180, 146, 107, 30);
            self.coInput.frame = CGRectMake(20, 146, 107, 30);
            self.modInput.frame = CGRectMake(180, 197, 107, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.outputOne.frame = CGRectMake(20, 375, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 435, 280, 35);
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:22];
            self.outputTwo.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:28];
            self.outputTwo.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.computeButton.frame = CGRectMake(220, 235 - 60, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            header.frame = CGRectMake(20, 80 - 60, 280, 46);
            xEquals.frame = CGRectMake(141, 143 - 60, 26, 36);
            xEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            openBracket.frame = CGRectMake(122, 194 - 60, 50, 36);
            openBracket.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            closeBracket.frame = CGRectMake(293, 194 - 60, 7, 36);
            closeBracket.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            resultLabel.frame = CGRectMake(111, 262 - 60, 98, 40);
            self.reInput.frame = CGRectMake(180, 146 - 60, 107, 30);
            self.coInput.frame = CGRectMake(20, 146 - 60, 107, 30);
            self.modInput.frame = CGRectMake(180, 197 - 60, 107, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.outputOne.frame = CGRectMake(20, 375 - 60, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 435 - 60, 280, 35);
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:22];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:28];
            self.outputTwo.textAlignment = NSTextAlignmentRight;
        }
    } else if (!IS_IPAD && !IS_IPHONE5){
        
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 205, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            header.frame = CGRectMake(20, 70, 280, 46);
            xEquals.frame = CGRectMake(141, 123, 26, 36);
            xEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            openBracket.frame = CGRectMake(126, 164, 46, 36);
            openBracket.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            closeBracket.frame = CGRectMake(293, 164, 7, 36);
            closeBracket.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            resultLabel.frame = CGRectMake(111, 232, 98, 40);
            self.reInput.frame = CGRectMake(180, 126, 107, 30);
            self.coInput.frame = CGRectMake(20, 126, 107, 30);
            self.modInput.frame = CGRectMake(180, 167, 107, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.outputOne.frame = CGRectMake(20, 325, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 365, 280, 35);
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:22];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:28];
            self.outputTwo.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.computeButton.frame = CGRectMake(215, 205 - 60, 90, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            header.frame = CGRectMake(20, 70 - 60, 280, 46);
            xEquals.frame = CGRectMake(141, 123 - 60, 26, 36);
            xEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            openBracket.frame = CGRectMake(126, 164 - 60, 50, 36);
            openBracket.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            closeBracket.frame = CGRectMake(293, 164 - 60, 7, 36);
            closeBracket.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            resultLabel.frame = CGRectMake(111, 232 - 60, 98, 40);
            self.reInput.frame = CGRectMake(180, 126 - 60, 107, 30);
            self.coInput.frame = CGRectMake(20, 126 - 60, 107, 30);
            self.modInput.frame = CGRectMake(180, 167 - 60, 107, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.outputOne.frame = CGRectMake(20, 325 - 60, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 365 - 60, 280, 35);
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:22];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:28];
            self.outputTwo.textAlignment = NSTextAlignmentRight;
        }
    } else if(IS_IPAD){
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(539, 456, 162, 50);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 50)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            self.reInput.frame = CGRectMake(428, 318, 266, 30);
            self.coInput.frame = CGRectMake(75, 318, 257, 30);
            self.modInput.frame = CGRectMake(487, 392, 189, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.outputOne.frame = CGRectMake(48, 655, 670, 60);
            self.outputTwo.frame = CGRectMake(48, 755, 670, 85);
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:45];
            self.outputTwo.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:55];
            self.outputTwo.textAlignment = NSTextAlignmentRight;
        }
        else{
            [self.iPadHeader removeFromSuperview];
            self.iPadHeader.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
            self.iPadHeader.frame = CGRectMake(self.iPadHeader.frame.origin.x, self.iPadHeader.frame.origin.y + 15, self.iPadHeader.frame.size.width, self.iPadHeader.frame.size.height);
            [self.iPadHeader sizeToFit];
            [self.view addSubview:self.iPadHeader];
            [self.iPadXEquals removeFromSuperview];
            self.iPadXEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
            self.iPadXEquals.frame = CGRectMake(self.iPadXEquals.frame.origin.x, self.iPadXEquals.frame.origin.y - 12, self.iPadXEquals.frame.size.width, self.iPadXEquals.frame.size.height);
            [self.iPadXEquals sizeToFit];
            [self.view addSubview: self.iPadXEquals];
            [self.iPadOpenBrackets removeFromSuperview];
            self.iPadOpenBrackets.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
            self.iPadOpenBrackets.frame = CGRectMake(self.iPadOpenBrackets.frame.origin.x, self.iPadOpenBrackets.frame.origin.y, self.iPadOpenBrackets.frame.size.width + 10, self.iPadOpenBrackets.frame.size.height);
            [self.iPadOpenBrackets sizeToFit];
            [self.view addSubview: self.iPadOpenBrackets];
            self.iPadResultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
            self.computeButton.frame = CGRectMake(539, 456, 162, 50);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 50)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            self.reInput.frame = CGRectMake(428, 318 - 10, 266, 30);
            self.coInput.frame = CGRectMake(75, 318 - 10, 257, 30);
            self.modInput.frame = CGRectMake(487, 392, 189, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.outputOne.frame = CGRectMake(48, 655, 670, 60);
            self.outputTwo.frame = CGRectMake(48, 755, 670, 85);
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:45];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:55];
            self.outputTwo.textAlignment = NSTextAlignmentRight;
            
        }
        
    }
    
    
    
    leftLine.frame = CGRectMake(20, resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2), self.view.frame.size.width / 2 - 20 - (resultLabel.frame.size.width / 2), 1);
    rightLine.frame = CGRectMake((self.view.frame.size.width / 2) + (resultLabel.frame.size.width / 2), resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2),leftLine.frame.size.width, 1);
    [self.view addSubview:header];
    [self.view addSubview:xEquals];
    [self.view addSubview:openBracket];
    [self.view addSubview:closeBracket];
    [self.view addSubview:rightLine];
    [self.view addSubview:leftLine];
    [self.view addSubview:resultLabel];
    [self.view addSubview:self.computeButton];
    [self.view addSubview:self.coInput];
    [self.view addSubview:self.reInput];
    [self.view addSubview:self.modInput];
    [self.view addSubview:self.outputOne];
    [self.view addSubview:self.outputTwo];
    self.outputTwo.alpha = 0;
    self.outputOne.alpha = 0;
    
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
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title
                                                   message:content
                                                  delegate:nil
                                         cancelButtonTitle:@"OK"
                                         otherButtonTitles:nil];
    [alert show];
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
