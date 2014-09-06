//
//  DivModViewController.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-21.
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

#import "Constants.h"
#import "DivModViewController.h"

@interface DivModViewController ()
@property (strong, nonatomic) UITextField* dividendInput;
@property (strong, nonatomic) UITextField* divisorInput;
@property (strong, nonatomic) UILabel *outputOne;
@property (strong, nonatomic) UILabel *outputTwo;
@property (strong, nonatomic) UILabel *outputThree;
@property (strong, nonatomic) UILabel *outputFour;
@property (strong, nonatomic) UILabel *outputFive;
@property (strong, nonatomic) UIButton *computeButton;
@end

@implementation DivModViewController
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.divisorInput resignFirstResponder];
    [self.dividendInput resignFirstResponder];
}

- (IBAction)compute:(id)sender{
    int x = [[self.dividendInput text] intValue];
    int y = [[self.divisorInput text] intValue];
    
    [self.dividendInput resignFirstResponder];
    [self.divisorInput resignFirstResponder];
    
    //    self.outputOne.text = @"";
    //    self.outputTwo.text = @"";
    //    self.outputThree.text = @"";
    //    self.outputFour.text = @"";
    //    self.outputFive.text = @"";
    
    if (self.dividendInput.text.length == 0 || self.divisorInput.text.length == 0) {
        [self prompt:@"Error" :@"Empty input(s)"];
    }
    else if (y == 0) {
        [self prompt:@"Invalid Inputs" :@"Please check inputs"];
    }
    else if(abs(x) >= INT32_MAX-1||abs(y) >= INT32_MAX-1){
        [self prompt:@"Error" :[NSString stringWithFormat:@"Input bounds \n%d to %d",INT32_MIN,INT32_MAX]];
    }
    else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.outputTwo.alpha = 0;
            self.outputFour.alpha = 0;
            self.outputFive.alpha = 0;
        } completion:^(BOOL finished) {
            NSLog(@"Starting Divmod");
            int q = x / y;
            int r = x % y;
            
            self.outputOne.text = @"Quotient:";
            self.outputThree.text = @"Remainder:";
            self.outputTwo.text = [NSString stringWithFormat:@"%d", q];
            self.outputFour.text = [NSString stringWithFormat:@"%d", r];
            NSString* string = [NSString stringWithFormat:@"%d = (%d)%d+%d", x, q, y, r];
            if([string length] > 25){
                self.outputFive.text = [NSString stringWithFormat:@"(%d)%d + %d", q, y, r];
            }
            else{
                self.outputFive.text = string;
            }
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.outputOne.alpha = 1;
                self.outputThree.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.outputTwo.alpha = 1;
                    self.outputFour.alpha = 1;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.outputFive.alpha = 1;
                    } completion:^(BOOL finished) {
                    }];
                }];
            }];
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
- (void)keyboardWillShow:(NSNotification*)notification {
}

- (void)keyboardDidHide:(NSNotification*)notification {
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.computeButton = [[UIButton alloc]init];
    UILabel *header = [[UILabel alloc]init];
    UILabel *dividendLabel = [[UILabel alloc]init];
    UILabel *divisorLabel = [[UILabel alloc]init];
    UILabel *resultLabel = [[UILabel alloc]init];
    UIImageView *leftLine =[[UIImageView alloc]init];
    UIImageView *rightLine = [[UIImageView alloc]init];
    self.dividendInput = [[UITextField alloc]init];
    self.divisorInput = [[UITextField alloc]init];
    self.outputOne = [[UILabel alloc]init];
    self.outputTwo = [[UILabel alloc]init];
    self.outputThree = [[UILabel alloc]init];
    self.outputFour = [[UILabel alloc]init];
    self.outputFive = [[UILabel alloc]init];
    header.text = @"Enter Numbers.";
    dividendLabel.text = @"Dividend:";
    divisorLabel.text = @"Divisor:";
    dividendLabel.textAlignment = NSTextAlignmentRight;
    divisorLabel.textAlignment = NSTextAlignmentRight;
    resultLabel.text = @"Result";
    leftLine.backgroundColor = [UIColor blackColor];
    rightLine.backgroundColor = [UIColor blackColor];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)    name:@"UIKeyboardDidHideNotification"
                                               object:nil];
    
    self.dividendInput.layer.cornerRadius = 10;
    self.dividendInput.layer.borderWidth = 0.5;
    self.dividendInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.dividendInput.textAlignment = NSTextAlignmentCenter;
    self.dividendInput.keyboardType = UIKeyboardTypeNumberPad;
    self.dividendInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.dividendInput.placeholder = @"Integer";
    
    self.divisorInput.layer.cornerRadius = 10;
    self.divisorInput.layer.borderWidth = 0.5;
    self.divisorInput.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.divisorInput.textAlignment = NSTextAlignmentCenter;
    self.divisorInput.keyboardType = UIKeyboardTypeNumberPad;
    self.divisorInput.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.divisorInput.placeholder = @"Integer";
    if (IS_IPHONE5) {
        
        
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 226, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            header.frame = CGRectMake(20, 81, 280, 46);
            dividendLabel.frame = CGRectMake(46, 138, 98, 36);
            dividendLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:23];
            divisorLabel.frame = CGRectMake(46, 185, 98, 36);
            divisorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:23];
            resultLabel.frame = CGRectMake(111, 252, 98, 40);
            self.dividendInput.frame = CGRectMake(152, 141, 150, 30);
            self.divisorInput.frame = CGRectMake(152, 188, 150, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            
            self.outputOne.frame = CGRectMake(20, 300, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 343, 280, 30);
            self.outputThree.frame = CGRectMake(20, 380, 280, 35);
            self.outputFour.frame = CGRectMake(20, 423, 280, 30);
            self.outputFive.frame = CGRectMake(20, 460, 280, 45);
            /*
             self.outputOne.text = @"PlaceHolder";
             self.outputTwo.text = @"PlaceHolder";
             self.outputThree.text = @"PlaceHolder";
             self.outputFour.text = @"PlaceHolder";
             self.outputFive.text = @"PlaceHolder";
             */
            
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.textColor = [UIColor blackColor];
            self.outputFive.textColor = [UIColor blackColor];
            
            self.outputOne.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            self.outputThree.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            self.outputFive.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            
        }
        else{
            self.computeButton.frame = CGRectMake(220, 226 - 70, 100, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            header.frame = CGRectMake(20, 81 - 70, 280, 46);
            dividendLabel.frame = CGRectMake(46, 138 - 70, 98, 36);
            dividendLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:23];
            divisorLabel.frame = CGRectMake(46, 185 - 70, 98, 36);
            divisorLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:23];
            resultLabel.frame = CGRectMake(111, 252 - 70, 98, 40);
            self.dividendInput.frame = CGRectMake(152, 141 - 70, 150, 30);
            self.divisorInput.frame = CGRectMake(152, 188 - 70, 150, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            
            self.outputOne.frame = CGRectMake(20, 300 - 70, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 343 - 70, 280, 30);
            self.outputThree.frame = CGRectMake(20, 380 - 70, 280, 35);
            self.outputFour.frame = CGRectMake(20, 423 - 70, 280, 30);
            self.outputFive.frame = CGRectMake(20, 460 - 70, 280, 45);
            /*
             self.outputOne.text = @"PlaceHolder";
             self.outputTwo.text = @"PlaceHolder";
             self.outputThree.text = @"PlaceHolder";
             self.outputFour.text = @"PlaceHolder";
             self.outputFive.text = @"PlaceHolder";
             */
            
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.textColor = [UIColor blackColor];
            self.outputFive.textColor = [UIColor blackColor];
            
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:22];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:25];
            self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:22];
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:25];
            self.outputFive.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:20];
        }
        
    } else if (!IS_IPAD && !IS_IPHONE5){
        
        
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 226 - 29, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            header.frame = CGRectMake(20, 81 - 10, 280, 46);
            dividendLabel.frame = CGRectMake(46, 138 - 20, 98, 36);
            dividendLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:23];
            divisorLabel.frame = CGRectMake(46, 185 - 25, 98, 36);
            divisorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:23];
            resultLabel.frame = CGRectMake(111, 252 - 33, 98, 40);
            self.dividendInput.frame = CGRectMake(152, dividendLabel.frame.origin.y + 3, 150, 30);
            self.divisorInput.frame = CGRectMake(152, divisorLabel.frame.origin.y + 3, 150, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            
            self.outputOne.frame = CGRectMake(20, 300 - 45, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 343 - 53, 280, 30);
            self.outputThree.frame = CGRectMake(20, 380 - 50, 280, 35);
            self.outputFour.frame = CGRectMake(20, 423 - 58, 280, 30);
            self.outputFive.frame = CGRectMake(20, 460 - 70, 280, 45);
            
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.textColor = [UIColor blackColor];
            self.outputFive.textColor = [UIColor blackColor];
            
            self.outputOne.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            self.outputThree.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            self.outputFive.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        }
        else{
            self.computeButton.frame = CGRectMake(220 - 10, 226 - 29 - 60, 100, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            header.frame = CGRectMake(20, 81 - 10 - 60, 280, 46);
            dividendLabel.frame = CGRectMake(46, 138 - 20 - 60, 98, 36);
            dividendLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:23];
            divisorLabel.frame = CGRectMake(46, 185 - 25 - 60, 98, 36);
            divisorLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:23];
            resultLabel.frame = CGRectMake(111, 252 - 33 - 60, 98, 40);
            self.dividendInput.frame = CGRectMake(152, dividendLabel.frame.origin.y + 3, 150, 30);
            self.divisorInput.frame = CGRectMake(152, divisorLabel.frame.origin.y + 3, 150, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            
            self.outputOne.frame = CGRectMake(20, 300 - 45 - 60, 280, 35);
            self.outputTwo.frame = CGRectMake(20, 343 - 53 - 60, 280, 30);
            self.outputThree.frame = CGRectMake(20, 380 - 50 - 60, 280, 35);
            self.outputFour.frame = CGRectMake(20, 423 - 58 - 60, 280, 30);
            self.outputFive.frame = CGRectMake(20, 460 - 70 - 55, 280, 30);
            
            self.outputOne.textColor = [UIColor blackColor];
            self.outputTwo.textColor = [UIColor blackColor];
            self.outputThree.textColor = [UIColor blackColor];
            self.outputFour.textColor = [UIColor blackColor];
            self.outputFive.textColor = [UIColor blackColor];
            
            self.outputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:30];
            self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            self.outputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:30];
            self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            self.outputFive.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:20];
        }
        
    } else if (IS_IPAD){
        
        //        if (IS_IOS7) {
        self.computeButton.frame = CGRectMake(self.view.frame.size.width - 65 - 162, 490, 162, 60);
        [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 60)];
        computeButtonLabel.textAlignment = NSTextAlignmentCenter;
        computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        if (!IS_IOS7) {
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
        }
        computeButtonLabel.text = @"Compute";
        computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        [self.computeButton addSubview:computeButtonLabel];
        header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
        header.frame = CGRectMake(75, 215, 500, 70);
        dividendLabel.frame = CGRectMake(171, 313, 161, 46);
        dividendLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        divisorLabel.frame = CGRectMake(171, 393, 161, 46);
        divisorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        if (!IS_IOS7) {
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:50];
            dividendLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
            divisorLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
        }
        resultLabel.frame = CGRectMake(314, 525, 140, 70);
        self.dividendInput.frame = CGRectMake(dividendLabel.frame.size.width + dividendLabel.frame.origin.x + 15, dividendLabel.frame.origin.y + 10, 300, 30);
        self.divisorInput.frame = CGRectMake(divisorLabel.frame.size.width + divisorLabel.frame.origin.x + 15, divisorLabel.frame.origin.y + 10, 300, 30);
        resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
        if (!IS_IOS7) {
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:48];
        }
        resultLabel.textAlignment = NSTextAlignmentCenter;
        resultLabel.backgroundColor = [UIColor whiteColor];
        
        UIImageView *blank = [[UIImageView alloc]initWithFrame:CGRectMake(45, 200, self.view.frame.size.width - 90, 360)];
        blank.backgroundColor = [UIColor clearColor];
        blank.layer.borderColor = [UIColor blackColor].CGColor;
        blank.layer.borderWidth = 1.0;
        [self.view addSubview:blank];
        
        self.outputOne.frame = CGRectMake(49, 578, 670, 55);
        self.outputTwo.frame = CGRectMake(49, 641, 670, 85);
        self.outputThree.frame = CGRectMake(49, 734, 670, 55);
        self.outputFour.frame = CGRectMake(49, 802, 280, 85);
        self.outputFive.frame = CGRectMake(49, 890, 670, 70);
        
        self.outputOne.textColor = [UIColor blackColor];
        self.outputTwo.textColor = [UIColor blackColor];
        self.outputThree.textColor = [UIColor blackColor];
        self.outputFour.textColor = [UIColor blackColor];
        self.outputFive.textColor = [UIColor blackColor];
        
        self.outputOne.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
        self.outputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
        self.outputThree.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50];
        self.outputFour.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
        self.outputFive.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
        //        }
        
    }
    
    if (!IS_IPAD) {
        leftLine.frame = CGRectMake(20, resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2), self.view.frame.size.width / 2 - 20 - (resultLabel.frame.size.width / 2), 1);
        rightLine.frame = CGRectMake((self.view.frame.size.width / 2) + (resultLabel.frame.size.width / 2), resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2),leftLine.frame.size.width, 1);
        [self.view addSubview:rightLine];
        [self.view addSubview:leftLine];
    }
    
    [self.view addSubview:header];
    [self.view addSubview:dividendLabel];
    [self.view addSubview:divisorLabel];
    [self.view addSubview:resultLabel];
    
    [self.view addSubview:self.computeButton];
    [self.view addSubview:self.dividendInput];
    [self.view addSubview:self.divisorInput];
    [self.view addSubview:self.outputOne];
    [self.view addSubview:self.outputTwo];
    [self.view addSubview:self.outputThree];
    [self.view addSubview:self.outputFour];
    [self.view addSubview:self.outputFive];
    self.outputOne.alpha = 0;
    self.outputTwo.alpha = 0;
    self.outputThree.alpha = 0;
    self.outputFour.alpha = 0;
    self.outputFive.alpha = 0;
    
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
