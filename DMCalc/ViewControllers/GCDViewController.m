//
//  GCDViewController.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-04.
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
#import "GCDViewController.h"
#import "Constants.h"
@interface GCDViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ipadHeader;
@property (weak, nonatomic) IBOutlet UILabel *extraLabel;

@property (strong, nonatomic) UIButton *computeButton;

@property (strong, nonatomic) UITextField *xIn;
@property (strong, nonatomic) UITextField *yIn;
@property (strong, nonatomic) UILabel *result;
@end

@implementation GCDViewController
@synthesize gcdCalc;
int x;
int y;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.xIn resignFirstResponder];
    [self.yIn resignFirstResponder];
}

- (void)compute:(id)sender
{
    x = [self.xIn.text intValue];
    y = [self.yIn.text intValue];
    
    [self.xIn resignFirstResponder];
    [self.yIn resignFirstResponder];
    
    if(x == 0 && y == 0) {
        [self prompt:@"Invalid Inputs" :@"Please double-check inputs. \nInput(s) cannot be both 0"];
    }
    else if(abs(x) >= INT32_MAX-1||abs(y) >= INT32_MAX-1){
        [self prompt:@"Error" :[NSString stringWithFormat:@"Input bounds [%d to %d]",INT32_MIN,INT32_MAX]];
    }
    else{
        gcdCalc = [[GCDCalc alloc]init];
        int gcd = [gcdCalc calculateGCD:x :y];
        if (gcd == 0) {
            [self prompt:@"Invalid Inputs" :@"Please double-check inputs. \nInput(s) cannot be 0"];
            self.result.text = @"";
        }
        else{
            self.self.extraLabel.text = [NSString stringWithFormat:@"GCD(%d, %d) =",x, y];
            self.result.text = [NSString stringWithFormat:@"%d", gcd];
        }
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
    self.xIn = [[UITextField alloc]init];
    self.xIn.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.yIn = [[UITextField alloc]init];
    self.yIn.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.result = [[UILabel alloc]init];
    self.computeButton = [[UIButton alloc]init];
    self.computeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UILabel *lineOneLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 90, self.view.frame.size.width - 40, 30)];
    if (!IS_IOS7 && !IS_IPAD) {
        lineOneLabel.frame = CGRectMake(20, 20, self.view.frame.size.width-40, 30);
    }
    [lineOneLabel setText:@"Enter Numbers."];
    lineOneLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
    lineOneLabel.textColor = [UIColor blackColor];
    
    CGFloat yOffset = 35;
    CGFloat height = 20;
    CGFloat fontSize = 20;
    if (IS_IPAD) {
        //Change for iPad
        fontSize = 40;
    }
    
    UILabel *lineTwoLabel;
    if (!IS_IPAD) {
        lineTwoLabel = [[UILabel alloc]init];
    }
    
    
    [lineTwoLabel setText:@"GCD of"];
    if (IS_IOS7) {
        lineTwoLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:fontSize];
        lineTwoLabel.frame = CGRectMake(20, lineOneLabel.frame.origin.y + yOffset + 5, self.view.frame.size.width - 40, height);
    }
    else{
        lineTwoLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:fontSize];
        lineTwoLabel.frame = CGRectMake(20, lineOneLabel.frame.origin.y + yOffset + 10, self.view.frame.size.width - 40, height);
    }
    UILabel *comma = [[UILabel alloc]init];
    comma.text = @",";
    if (IS_IPAD) {
        UIImageView *blank = [[UIImageView alloc]initWithFrame:CGRectMake(45, 230, self.view.frame.size.width - 90, 360)];
        blank.backgroundColor = [UIColor clearColor];
        blank.layer.borderColor = [UIColor blackColor].CGColor;
        blank.layer.borderWidth = 1.0;
        [self.view addSubview:blank];
        lineOneLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
        lineOneLabel.frame = CGRectMake(65, 250, self.view.frame.size.width -140, 50);
    }
    UILabel *resultLabel = [[UILabel alloc]init];
    [resultLabel setText:@"Result"];
    resultLabel.backgroundColor = [UIColor clearColor];
    resultLabel.textColor =[UIColor blackColor];
    
    if (!IS_IPAD && !IS_IPHONE5) {
        comma.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:25];
        
        [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
        
        
        if (IS_IOS7) {
            NSLog(@"3.5 inch, iOS 7");
            self.computeButton.frame = CGRectMake(213, 213, 85, 30);
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 + 103, 100, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            self.xIn.frame = CGRectMake(20, 170, 130, 30);
            self.yIn.frame = CGRectMake(170, 170, 130, 30);
            comma.frame = CGRectMake(152, 170, 30, 30);
            self.xIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:18];
            self.yIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:18];
            self.xIn.layer.borderWidth = 0.5;
            self.xIn.layer.cornerRadius = 10;
            self.yIn.layer.borderWidth = 0.5;
            self.yIn.layer.cornerRadius = 10;
            
            self.result.frame = CGRectMake(20, self.view.frame.size.height - 130, self.view.frame.size.width - 40, 30);
            self.result.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
            self.result.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:self.result];
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 + 13, 100, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:35];
            
        }
        else{
            NSLog(@"3.5 inch, iOS 6");
            self.computeButton.frame = CGRectMake(213, 213 - 60, 85, 30);
            
            [self.result removeFromSuperview];
            self.xIn.frame = CGRectMake(20, 100, 130, 30);
            self.yIn.frame = CGRectMake(170, 100, 130, 30);
            comma.frame = CGRectMake(152, 98, 30, 30);
            self.xIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xIn.layer.borderWidth = 0.5;
            self.xIn.layer.cornerRadius = 10;
            self.yIn.layer.borderWidth = 0.5;
            self.yIn.layer.cornerRadius = 10;
            
            self.result.frame = CGRectMake(20, self.view.frame.size.height - 170, self.view.frame.size.width - 40, 40);
            self.result.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
            self.result.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:self.result];
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 37, 100, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:35];
            
        }
        CGFloat linesYSubtraction = 17;
        if (IS_IOS7) {
            linesYSubtraction = -33;
        }
        [self.view addSubview:comma];
        UIImageView *leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height/2 - linesYSubtraction, self.view.frame.size.width/2 - 70, 1)];
        [leftLine setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:leftLine];
        
        UIImageView *rightLine = [[UIImageView alloc]initWithFrame:
                                  CGRectMake(self.view.frame.size.width/2 + 50, self.view.frame.size.height/2 - linesYSubtraction, self.view.frame.size.width/2 - 70, 1)];
        [rightLine setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:rightLine];
        UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
        computeButtonLabel.textAlignment = NSTextAlignmentCenter;
        computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        if (!IS_IOS7) {
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
        }
        computeButtonLabel.text = @"Compute";
        computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        [self.computeButton addSubview:computeButtonLabel];
        [self.view addSubview:self.computeButton];
    }
    else if(IS_IPHONE5){
        
        
        if (IS_IOS7) {
            NSLog(@"4 inch, iOS 7");
            self.computeButton.frame = CGRectMake(213, 213, 85, 30);
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 + 103, 100, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            self.xIn.frame = CGRectMake(20, 170, 130, 30);
            self.yIn.frame = CGRectMake(170, 170, 130, 30);
            comma.frame = CGRectMake(152, 170, 30, 30);
            self.xIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:18];
            self.yIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:18];
            self.xIn.layer.borderWidth = 0.5;
            self.xIn.layer.cornerRadius = 10;
            self.yIn.layer.borderWidth = 0.5;
            self.yIn.layer.cornerRadius = 10;
            
            self.result.frame = CGRectMake(20, self.view.frame.size.height - 190, self.view.frame.size.width - 40, 40);
            self.result.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
            self.result.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:self.result];
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 20, 100, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:35];
            [self.view addSubview:self.computeButton];
            
        }
        else{
            NSLog(@"4 inch, iOS 6");
            self.computeButton.frame = CGRectMake(213, 213 - 60, 85, 30);
            [self.result removeFromSuperview];
            self.xIn.frame = CGRectMake(20, 115, 130, 30);
            self.yIn.frame = CGRectMake(170, 115, 130, 30);
            comma.frame = CGRectMake(152, 114, 30, 30);
            self.xIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xIn.layer.borderWidth = 0.5;
            self.xIn.layer.cornerRadius = 10;
            self.yIn.layer.borderWidth = 0.5;
            self.yIn.layer.cornerRadius = 10;
            self.result.frame = CGRectMake(20, self.view.frame.size.height - 200, self.view.frame.size.width - 40, 40);
            self.result.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
            self.result.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:self.result];
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 50, self.view.frame.size.height/2 - 37, 100, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:35];
            [self.view addSubview:self.computeButton];
        }
        CGFloat linesYSubtraction = 17;
        if (IS_IOS7) {
            linesYSubtraction = 0;
        }
        [self.view addSubview:comma];
        UIImageView *leftLine = [[UIImageView alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height/2 - linesYSubtraction, self.view.frame.size.width/2 - 70, 1)];
        [leftLine setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:leftLine];
        
        UIImageView *rightLine = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 + 50, self.view.frame.size.height/2 - linesYSubtraction, self.view.frame.size.width/2 - 70, 1)];
        [rightLine setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:rightLine];
        UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
        computeButtonLabel.textAlignment = NSTextAlignmentCenter;
        computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        if (!IS_IOS7) {
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
        }
        computeButtonLabel.text = @"Compute";
        computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        [self.computeButton addSubview:computeButtonLabel];
        [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.computeButton];
        
    }
    else {
        self.computeButton.frame = CGRectMake(542, 510, 162, 50);
        UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 50)];
        computeButtonLabel.textAlignment = NSTextAlignmentCenter;
        computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        if (!IS_IOS7) {
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
        }
        computeButtonLabel.text = @"Compute";
        computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        [self.computeButton addSubview:computeButtonLabel];
        [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.computeButton];
        if (IS_IOS7) {
            NSLog(@"iPad, iOS 7");
            self.xIn.frame = CGRectMake(self.view.frame.size.width / 2 - 135, 365, 270, 30);
            self.yIn.frame = CGRectMake(self.view.frame.size.width / 2 - 135, 460, 270, 30);
            self.xIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xIn.layer.borderWidth = 0.5;
            self.xIn.layer.cornerRadius = 10;
            self.yIn.layer.borderWidth = 0.5;
            self.yIn.layer.cornerRadius = 10;
            self.xIn.layer.borderColor = [UIColor grayColor].CGColor;
            self.yIn.layer.borderColor = [UIColor grayColor].CGColor;
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 80, 590 - 20, 160, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:50];
            resultLabel.backgroundColor = [UIColor whiteColor];
            self.result.frame = CGRectMake(50, self.view.frame.size.height - 220, self.view.frame.size.width - 100, 100);
            self.result.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:60];
            self.result.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:self.result];
        }
        else{
            NSLog(@"iPad, iOS 6");
            [self.ipadHeader removeFromSuperview];
            
            self.ipadHeader.frame = CGRectMake(self.ipadHeader.frame.origin.x, self.ipadHeader.frame.origin.y - 60, self.ipadHeader.frame.size.width, self.ipadHeader.frame.size.height);
            [self.extraLabel removeFromSuperview];
            self.extraLabel.textAlignment = NSTextAlignmentLeft;
            self.extraLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
            
            self.xIn.frame = CGRectMake(self.view.frame.size.width / 2 - 135, 365, 270, 30);
            self.yIn.frame = CGRectMake(self.view.frame.size.width / 2 - 135, 460, 270, 30);
            self.xIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.yIn.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            self.xIn.layer.borderWidth = 0.5;
            self.xIn.layer.cornerRadius = 10;
            self.yIn.layer.borderWidth = 0.5;
            self.yIn.layer.cornerRadius = 10;
            self.xIn.layer.borderColor = [UIColor grayColor].CGColor;
            self.yIn.layer.borderColor = [UIColor grayColor].CGColor;
            resultLabel.frame = CGRectMake(self.view.frame.size.width/2 - 80, 590 - 20, 160, 40);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:50];
            resultLabel.backgroundColor = [UIColor whiteColor];
            self.result.frame = CGRectMake(50, self.view.frame.size.height - 220, self.view.frame.size.width - 100, 100);
            self.result.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:60];
            self.result.textAlignment = NSTextAlignmentRight;
            [self.view addSubview:self.result];
            [self.view addSubview:self.ipadHeader];
            [self.view addSubview:self.extraLabel];
        }
    }
    resultLabel.textAlignment = NSTextAlignmentCenter;
    self.xIn.textAlignment = NSTextAlignmentCenter;
    self.yIn.textAlignment = NSTextAlignmentCenter;
    self.xIn.keyboardType = UIKeyboardTypeNumberPad;
    self.yIn.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:lineOneLabel];
    [self.view addSubview:lineTwoLabel];
    [self.view addSubview:resultLabel];
    [self.view addSubview:self.xIn];
    [self.view addSubview:self.yIn];
    [self.view addSubview:self.result];
    
    //    [self.xIn becomeFirstResponder];
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
