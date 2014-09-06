//
//  RepeatedSquaringViewController.m
//  DMCalc
//
//  Created by Neil DragonFox on 2014-04-26.
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
#import "RepeatedSquaringViewController.h"
#import "Constants.h"
#import "RSSolver.h"
#import "RepeatedSquaringSolutionsSlider.h"

/*
 Next Version - SHOW STEPS (USE SCROLLVIEWS).
 */

@interface RepeatedSquaringViewController ()

@property (weak, nonatomic) IBOutlet UILabel *iPadHeader;
@property (strong, nonatomic) RSSolver *rssolver;
@property (strong, nonatomic) UILabel *baseLabel;
@property (strong, nonatomic) UILabel *expLabel;
@property (strong, nonatomic) UILabel *remLabel;
@property (strong, nonatomic) UILabel *modLabel;
@property (strong, nonatomic) UITextField *inputOne;
@property (strong, nonatomic) UITextField *inputTwo;
@property (strong, nonatomic) UITextField *inputThree;
@property (weak, nonatomic) IBOutlet UILabel *iPadResultLabel;
@property (strong, nonatomic) UIButton *computeButton;
@property (strong, nonatomic) UIButton *showSolutionsButton;
@property (strong, nonatomic) UIImageView *line;
@property (strong, nonatomic) RepeatedSquaringSolutionsSlider *solutionsSlider;
@end

@implementation RepeatedSquaringViewController
long long a;
long long b;
long long m;
long long r;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.inputOne resignFirstResponder];
    [self.inputTwo resignFirstResponder];
    [self.inputThree resignFirstResponder];
}

- (void)compute:(id)sender
{
    a = [self.inputOne.text longLongValue];
    b = [self.inputTwo.text longLongValue];
    m = [self.inputThree.text longLongValue];
    
    [self.inputOne resignFirstResponder];
    [self.inputTwo resignFirstResponder];
    [self.inputThree resignFirstResponder];
    
    if (self.inputOne.text.length == 0 || self.inputTwo.text.length == 0 || self.inputThree.text.length == 0 ) {
        self.baseLabel.text = @"";
        self.expLabel.text = @"";
        self.remLabel.text = @"";
        self.modLabel.text = @"";
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.showSolutionsButton.alpha = 0;
        }completion:^(BOOL finished) {
            [self prompt:@"Error" :@"Empty input(s)"];
        }];
        
    }
    else if (a == 1 || m == 0 || m == 1 || b == 0){
        self.baseLabel.text = @"";
        self.expLabel.text = @"";
        self.remLabel.text = @"";
        self.modLabel.text = @"";
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.showSolutionsButton.alpha = 0;
        }completion:^(BOOL finished) {
            [self prompt:@"Invalid Inputs" :@"Please doublecheck inputs"];
        }];
        
    }
    else{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.baseLabel.alpha = 0;
            self.remLabel.alpha = 0;
            self.modLabel.alpha = 0;
            self.expLabel.alpha = 0;
            self.showSolutionsButton.alpha = 0;
        } completion:^(BOOL finished) {
            self.rssolver = [[RSSolver alloc]init];
            r=[self.rssolver solveRS:a :b :m];
            int alength = [self.inputOne.text length];
            NSMutableString *exponent = [[NSMutableString alloc]initWithString:@""];
            for (int i = 0; i < alength; i++) {
                if (i%3!= 0) {
                    [exponent appendString:@"   "];
                }
                else{
                    [exponent appendString:@"  "];
                }
            }
            [exponent appendString:self.inputTwo.text];
            self.baseLabel.text = self.inputOne.text;
            self.expLabel.text = exponent;
            self.remLabel.text = [NSString stringWithFormat:@"= %lld", r];
            self.modLabel.text = [NSString stringWithFormat:@"(mod %@)",self.inputThree.text];
            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.baseLabel.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.expLabel.alpha = 1;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.remLabel.alpha = 1;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            self.modLabel.alpha = 1;
                        } completion:^(BOOL finished) {
                            if (IS_IPAD) {
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                    self.line.alpha = 1;
                                } completion:^(BOOL finished) {
                                }];
                            }
                            if (self.rssolver.canShowSolutions) {
                                [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                                    self.showSolutionsButton.alpha = 1;
                                } completion:^(BOOL finished) {
                                    
                                }];
                                
                            }
                        }];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *header = [[UILabel alloc]init];
    UILabel *formatLabel = [[UILabel alloc]init];
    UILabel *aEquals = [[UILabel alloc]init];
    UILabel *bEquals = [[UILabel alloc]init];
    UILabel *mEquals = [[UILabel alloc]init];
    self.baseLabel = [[UILabel alloc]init];
    self.expLabel = [[UILabel alloc]init];
    self.remLabel = [[UILabel alloc]init];
    self.modLabel = [[UILabel alloc]init];
    self.inputOne = [[UITextField alloc]init];
    self.inputTwo = [[UITextField alloc]init];
    self.inputThree = [[UITextField alloc]init];
    self.computeButton = [[UIButton alloc]init];
    self.showSolutionsButton = [[UIButton alloc]init];
    UILabel *resultLabel = [[UILabel alloc]init];
    UIImageView *leftLine = [[UIImageView alloc]init];
    UIImageView *rightLine = [[UIImageView alloc]init];
    header.text = @"Enter Numbers.";
    formatLabel.text = @"Format: a^b = r (mod m)";
    formatLabel.textAlignment = NSTextAlignmentLeft;
    aEquals.text = @"a =";
    aEquals.textAlignment = NSTextAlignmentCenter;
    bEquals.text = @"b =";
    bEquals.textAlignment = NSTextAlignmentCenter;
    mEquals.text = @"m =";
    mEquals.textAlignment = NSTextAlignmentCenter;
    resultLabel.text = @"Result";
    resultLabel.textColor = [UIColor blackColor];
    leftLine.backgroundColor = [UIColor blackColor];
    rightLine.backgroundColor = [UIColor blackColor];
    self.inputOne.layer.cornerRadius = 10;
    self.inputOne.layer.borderWidth = 0.5;
    self.inputOne.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.inputOne.textAlignment = NSTextAlignmentCenter;
    self.inputOne.keyboardType = UIKeyboardTypeNumberPad;
    self.inputOne.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputOne.placeholder = @"Base";
    
    self.inputTwo.layer.cornerRadius = 10;
    self.inputTwo.layer.borderWidth = 0.5;
    self.inputTwo.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.inputTwo.textAlignment = NSTextAlignmentCenter;
    self.inputTwo.keyboardType = UIKeyboardTypeNumberPad;
    self.inputTwo.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputTwo.placeholder = @"Exponent";
    
    self.inputThree.layer.cornerRadius = 10;
    self.inputThree.layer.borderWidth = 0.5;
    self.inputThree.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
    self.inputThree.textAlignment = NSTextAlignmentCenter;
    self.inputThree.keyboardType = UIKeyboardTypeNumberPad;
    self.inputThree.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.inputThree.placeholder = @"Mod";
    
    
    
    if (IS_IPHONE5) {
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 237, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            header.frame = CGRectMake(20, 77, 280, 31);
            formatLabel.frame = CGRectMake(20, 116, 280, 23);
            formatLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            aEquals.frame = CGRectMake(20, 147, 30, 36);
            aEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            aEquals.textAlignment = NSTextAlignmentLeft;
            bEquals.frame = CGRectMake(20, 191, 30, 36);
            bEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            bEquals.textAlignment = NSTextAlignmentLeft;
            mEquals.frame = CGRectMake(20, 231, 35, 36);
            mEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            mEquals.textAlignment = NSTextAlignmentLeft;
            resultLabel.frame = CGRectMake(111, 275, 98, 49);
            self.inputOne.frame = CGRectMake(54, 150, 145, 30);
            self.inputTwo.frame = CGRectMake(54, 194, 145, 30);
            self.inputThree.frame = CGRectMake(54, 237, 145, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.baseLabel.frame = CGRectMake(20, 354, 280, 35);
            self.expLabel.frame = CGRectMake(20, 332, 280, 35);
            self.remLabel.frame = CGRectMake(20, 381, 280, 60);
            self.modLabel.frame = CGRectMake(20, 450, 280, 45);
            self.baseLabel.textColor = [UIColor blackColor];
            self.expLabel.textColor = [UIColor blackColor];
            self.remLabel.textColor = [UIColor blackColor];
            self.modLabel.textColor = [UIColor blackColor];
            self.baseLabel.font = [UIFont fontWithName: @"HelveticaNeue-Thin" size:25];
            self.baseLabel.textAlignment = NSTextAlignmentLeft;
            self.expLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:20];
            self.expLabel.textAlignment = NSTextAlignmentLeft;
            self.remLabel.font = [UIFont fontWithName: @"HelveticaNeue-Thin" size:40];
            self.remLabel.textAlignment = NSTextAlignmentLeft;
            self.modLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:30];
            self.modLabel.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.computeButton.frame = CGRectMake(220, 237 - 60, 85, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            header.frame = CGRectMake(20, 77 - 60, 280, 31);
            formatLabel.frame = CGRectMake(20, 116 - 60, 280, 23);
            formatLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:20];
            aEquals.frame = CGRectMake(20, 147 - 60, 30, 36);
            aEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            aEquals.textAlignment = NSTextAlignmentLeft;
            bEquals.frame = CGRectMake(20, 191 - 60, 30, 36);
            bEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            bEquals.textAlignment = NSTextAlignmentLeft;
            mEquals.frame = CGRectMake(20, 231 - 60, 35, 36);
            mEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            mEquals.textAlignment = NSTextAlignmentLeft;
            resultLabel.frame = CGRectMake(111, 275 - 60, 98, 49);
            self.inputOne.frame = CGRectMake(54, 150 - 60, 145, 30);
            self.inputTwo.frame = CGRectMake(54, 194 - 60, 145, 30);
            self.inputThree.frame = CGRectMake(54, 237 - 60, 145, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.baseLabel.frame = CGRectMake(20, 354 - 60, 280, 45);
            self.expLabel.frame = CGRectMake(20, 332 - 60, 280, 35);
            self.remLabel.frame = CGRectMake(20, 386 - 60, 280, 60);
            self.modLabel.frame = CGRectMake(20, 455 - 60, 280, 45);
            self.baseLabel.textColor = [UIColor blackColor];
            self.expLabel.textColor = [UIColor blackColor];
            self.remLabel.textColor = [UIColor blackColor];
            self.modLabel.textColor = [UIColor blackColor];
            self.baseLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE size:25];
            self.baseLabel.textAlignment = NSTextAlignmentLeft;
            self.expLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:20];
            self.expLabel.textAlignment = NSTextAlignmentLeft;
            self.remLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE size:40];
            self.remLabel.textAlignment = NSTextAlignmentLeft;
            self.modLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:30];
            self.modLabel.textAlignment = NSTextAlignmentRight;        }
    } else if (!IS_IPAD && !IS_IPHONE5){
        if (IS_IOS7) {
            self.computeButton.frame = CGRectMake(220, 237, 80, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
            header.frame = CGRectMake(20, 77, 280, 31);
            formatLabel.frame = CGRectMake(20, 116, 280, 23);
            formatLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
            aEquals.frame = CGRectMake(20, 147, 30, 36);
            aEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            aEquals.textAlignment = NSTextAlignmentLeft;
            bEquals.frame = CGRectMake(20, 191, 30, 36);
            bEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            bEquals.textAlignment = NSTextAlignmentLeft;
            mEquals.frame = CGRectMake(20, 231, 35, 36);
            mEquals.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];
            mEquals.textAlignment = NSTextAlignmentLeft;
            resultLabel.frame = CGRectMake(111, 275, 98, 49);
            self.inputOne.frame = CGRectMake(54, 150, 145, 30);
            self.inputTwo.frame = CGRectMake(54, 194, 145, 30);
            self.inputThree.frame = CGRectMake(54, 237, 145, 30);
            resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            
            self.baseLabel.frame = CGRectMake(20, 354 - 25, 280, 35);
            self.expLabel.frame = CGRectMake(20, 332 - 25, 280, 35);
            self.remLabel.frame = CGRectMake(20, 380 - 20, 280, 40);
            self.modLabel.frame = CGRectMake(20, 420 - 20, 280, 35);
            self.baseLabel.textColor = [UIColor blackColor];
            self.expLabel.textColor = [UIColor blackColor];
            self.remLabel.textColor = [UIColor blackColor];
            self.modLabel.textColor = [UIColor blackColor];
            self.baseLabel.font = [UIFont fontWithName: @"HelveticaNeue-Thin" size:25];
            self.baseLabel.textAlignment = NSTextAlignmentLeft;
            self.expLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:20];
            self.expLabel.textAlignment = NSTextAlignmentLeft;
            self.remLabel.font = [UIFont fontWithName: @"HelveticaNeue-Thin" size:30];
            self.remLabel.textAlignment = NSTextAlignmentLeft;
            self.modLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:20];
            self.modLabel.textAlignment = NSTextAlignmentRight;
        }
        else{
            self.computeButton.frame = CGRectMake(215, 237 - 60, 85, 30);
            [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 85, 30)];
            computeButtonLabel.textAlignment = NSTextAlignmentCenter;
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:20];
            computeButtonLabel.text = @"Compute";
            computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
            [self.computeButton addSubview:computeButtonLabel];
            header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:30];
            header.frame = CGRectMake(20, 77 - 60, 280, 31);
            formatLabel.frame = CGRectMake(20, 116 - 60, 280, 23);
            formatLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:20];
            aEquals.frame = CGRectMake(20, 147 - 60, 30, 36);
            aEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            aEquals.textAlignment = NSTextAlignmentLeft;
            bEquals.frame = CGRectMake(20, 191 - 60, 30, 36);
            bEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            bEquals.textAlignment = NSTextAlignmentLeft;
            mEquals.frame = CGRectMake(20, 231 - 60, 35, 36);
            mEquals.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:18];
            mEquals.textAlignment = NSTextAlignmentLeft;
            resultLabel.frame = CGRectMake(111, 275 - 75, 98, 65);
            self.inputOne.frame = CGRectMake(54, 150 - 60, 145, 30);
            self.inputTwo.frame = CGRectMake(54, 194 - 60, 145, 30);
            self.inputThree.frame = CGRectMake(54, 237 - 60, 145, 30);
            resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
            resultLabel.textAlignment = NSTextAlignmentCenter;
            self.baseLabel.frame = CGRectMake(20, 354 - 25 - 60, 280, 35);
            self.expLabel.frame = CGRectMake(20, 332 - 25 - 60, 280, 35);
            self.remLabel.frame = CGRectMake(20, 380 - 20 - 60, 280, 40);
            self.modLabel.frame = CGRectMake(20, 420 - 20 - 63, 280, 35);
            self.baseLabel.textColor = [UIColor blackColor];
            self.expLabel.textColor = [UIColor blackColor];
            self.remLabel.textColor = [UIColor blackColor];
            self.modLabel.textColor = [UIColor blackColor];
            self.baseLabel.backgroundColor = [UIColor clearColor];
            self.expLabel.backgroundColor = [UIColor clearColor];
            self.remLabel.backgroundColor = [UIColor clearColor];
            self.modLabel.backgroundColor = [UIColor clearColor];
            self.baseLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE size:25];
            self.baseLabel.textAlignment = NSTextAlignmentLeft;
            self.expLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:20];
            self.expLabel.textAlignment = NSTextAlignmentLeft;
            self.remLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE size:30];
            self.remLabel.textAlignment = NSTextAlignmentLeft;
            self.modLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:20];
            self.modLabel.textAlignment = NSTextAlignmentRight;
        }
    } else if(IS_IPAD){
        //if (IS_IOS7) {
        self.computeButton.frame = CGRectMake(542, 486, 162, 50);
        [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
        UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 50)];
        computeButtonLabel.textAlignment = NSTextAlignmentCenter;
        computeButtonLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
        if (!IS_IOS7) {
            computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
        }
        computeButtonLabel.text = @"Compute";
        computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
        [self.computeButton addSubview:computeButtonLabel];
        self.inputOne.frame = CGRectMake(270, 303, 257, 30);
        self.inputTwo.frame = CGRectMake(270, 369, 257, 30);
        self.inputThree.frame = CGRectMake(270, 435, 257, 30);
        resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:35];
        resultLabel.textAlignment = NSTextAlignmentCenter;
        
        self.baseLabel.frame = CGRectMake(43, 657, 669, 45);
        self.expLabel.frame = CGRectMake(43, 609, 669, 40);
        self.remLabel.frame = CGRectMake(43, 756, 669, 55);
        self.modLabel.frame = CGRectMake(43, 864, 669, 45);
        self.baseLabel.textColor = [UIColor blackColor];
        self.expLabel.textColor = [UIColor blackColor];
        self.remLabel.textColor = [UIColor blackColor];
        self.modLabel.textColor = [UIColor blackColor];
        self.baseLabel.backgroundColor = [UIColor clearColor];
        self.expLabel.backgroundColor = [UIColor clearColor];
        self.remLabel.backgroundColor = [UIColor clearColor];
        self.modLabel.backgroundColor = [UIColor clearColor];
        self.baseLabel.font = [UIFont fontWithName: @"HelveticaNeue-Thin" size:55];
        self.baseLabel.textAlignment = NSTextAlignmentLeft;
        self.expLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:40];
        self.expLabel.textAlignment = NSTextAlignmentLeft;
        self.remLabel.font = [UIFont fontWithName: @"HelveticaNeue-Thin"  size:65];
        self.remLabel.textAlignment = NSTextAlignmentLeft;
        self.modLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE_THIN size:55];
        self.modLabel.textAlignment = NSTextAlignmentRight;
        self.line = [[UIImageView alloc]initWithFrame:CGRectMake(self.baseLabel.frame.origin.x, self.baseLabel.frame.origin.y + self.baseLabel.frame.size.height + 20,self.baseLabel.frame.size.width, 1)];
        self.line.backgroundColor = [UIColor blackColor];
        [self.view addSubview:self.line];
        self.line.alpha = 0;
        if (!IS_IOS7) {
            self.iPadHeader.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:47];
            self.baseLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE size:55];
            self.iPadResultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:47];
            self.remLabel.font = [UIFont fontWithName: APP_DEFAULT_FONT_FACE  size:65];
            self.remLabel.frame = CGRectMake(43, 756 - 20, 669, 55);
            self.modLabel.frame = CGRectMake(43, 864 - 20, 669, 45);
        }
        // }
        //else{
        /*
         [self.iPadHeader removeFromSuperview];
         self.iPadHeader.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
         self.iPadHeader.frame = CGRectMake(self.iPadHeader.frame.origin.x, self.iPadHeader.frame.origin.y + 15, self.iPadHeader.frame.size.width, self.iPadHeader.frame.size.height);
         [self.iPadHeader sizeToFit];
         [self.view addSubview:self.iPadHeader];
         [self.iPadformatLabel removeFromSuperview];
         self.iPadformatLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
         self.iPadformatLabel.frame = CGRectMake(self.iPadformatLabel.frame.origin.x, self.iPadformatLabel.frame.origin.y - 12, self.iPadformatLabel.frame.size.width, self.iPadformatLabel.frame.size.height);
         [self.iPadformatLabel sizeToFit];
         [self.view addSubview: self.iPadformatLabel];
         [self.iPadaEqualss removeFromSuperview];
         self.iPadaEqualss.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:40];
         self.iPadaEqualss.frame = CGRectMake(self.iPadaEqualss.frame.origin.x, self.iPadaEqualss.frame.origin.y, self.iPadaEqualss.frame.size.width + 10, self.iPadaEqualss.frame.size.height);
         [self.iPadaEqualss sizeToFit];
         [self.view addSubview: self.iPadaEqualss];
         self.iPadResultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:50];
         self.computeButton.frame = CGRectMake(539, 456, 162, 50);
         [self.computeButton addTarget:self action:@selector(compute:) forControlEvents:UIControlEventTouchUpInside];
         UILabel *computeButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 162, 50)];
         computeButtonLabel.textAlignment = NSTextAlignmentCenter;
         computeButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
         computeButtonLabel.text = @"Compute";
         computeButtonLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:255/255 alpha:1];
         [self.computeButton addSubview:computeButtonLabel];
         self.inputTwo.frame = CGRectMake(428, 318 - 10, 266, 30);
         self.inputOne.frame = CGRectMake(75, 318 - 10, 257, 30);
         self.inputThree.frame = CGRectMake(487, 392, 189, 30);
         resultLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
         resultLabel.textAlignment = NSTextAlignmentCenter;
         
         self.baseLabel.frame = CGRectMake(48, 655, 670, 60);
         self.expLabel.frame = CGRectMake(48, 755, 670, 85);
         self.baseLabel.textColor = [UIColor blackColor];
         self.expLabel.textColor = [UIColor blackColor];
         self.baseLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:45];
         self.expLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:55];
         self.expLabel.textAlignment = NSTextAlignmentRight;
         */
        
        //}
        
    }
    
    
    
    leftLine.frame = CGRectMake(20, resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2), self.view.frame.size.width / 2 - 20 - (resultLabel.frame.size.width / 2), 1);
    rightLine.frame = CGRectMake((self.view.frame.size.width / 2) + (resultLabel.frame.size.width / 2), resultLabel.frame.origin.y + (resultLabel.frame.size.height / 2),leftLine.frame.size.width, 1);
    [self.view addSubview:header];
    [self.view addSubview:formatLabel];
    [self.view addSubview:aEquals];
    [self.view addSubview:bEquals];
    [self.view addSubview:mEquals];
    [self.view addSubview:rightLine];
    [self.view addSubview:leftLine];
    [self.view addSubview:resultLabel];
    [self.view addSubview:self.computeButton];
    [self.view addSubview:self.inputOne];
    [self.view addSubview:self.inputTwo];
    [self.view addSubview:self.inputThree];
    [self.view addSubview:self.baseLabel];
    [self.view addSubview:self.expLabel];
    [self.view addSubview:self.remLabel];
    [self.view addSubview:self.modLabel];
    
    
    self.showSolutionsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.showSolutionsButton.frame = CGRectMake(20, ((self.modLabel.frame.size.height/2+self.modLabel.frame.origin.y)-13), 26,26);
    UIImage *solutionsimg = [UIImage imageNamed:@"/solutions.png"];
    [self.showSolutionsButton setImage:solutionsimg forState:UIControlStateNormal];
    self.showSolutionsButton.alpha = 0;
    [self.showSolutionsButton addTarget:self action:@selector(showSolutionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showSolutionsButton];
    
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

- (void)showSolutionsButtonPressed:(UIButton *)sender{
    NSLog(@"Show solutions button pressed");
    self.solutionsSlider = [[RepeatedSquaringSolutionsSlider alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height) withNumSteps:[self.rssolver getCount] andStrings:[self.rssolver getRemainderStrings]];
    [self.solutionsSlider setMod:m];
    self.solutionsSlider.delegate = self;
    [self.view addSubview:self.solutionsSlider];
    [self openSlider];
}

- (void)openSlider{
    CGFloat sliderY = 0;
    if (IS_IOS7) {
        sliderY += 64;
    }
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.solutionsSlider.frame = CGRectMake(0, sliderY, self.solutionsSlider.frame.size.width, self.solutionsSlider.frame.size.height);
    } completion:^(BOOL finished) {
        NSLog(@"Animated");
    }];
}

- (void)closeSlider{
    [UIView animateWithDuration:0.6 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.solutionsSlider.frame = CGRectMake(0, self.view.frame.size.height, self.solutionsSlider.frame.size.width, self.solutionsSlider.frame.size.height);
    } completion:^(BOOL finished) {
        NSLog(@"Animated");
    }];

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
