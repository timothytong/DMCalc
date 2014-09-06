//
//  ViewController.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-03-31.
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
#import "ViewController.h"

#import "Constants.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UIButton *gcdButton;
@property (weak, nonatomic) IBOutlet UIButton *ldeButton;
@property (weak, nonatomic) IBOutlet UIButton *modButton;
@property (weak, nonatomic) IBOutlet UILabel *gcdLabel;
@property (weak, nonatomic) IBOutlet UILabel *ldeLabel;
@property (weak, nonatomic) IBOutlet UILabel *modLabel;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (strong, nonatomic) UIButton *ios6AboutButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //Adjust label/button positions for 3.5-inch devices running iOS 7
    
    if (!IS_IPHONE5 &&!IS_IPAD &&IS_IOS7) {
        NSLog(@"3.5 Inch, iOS 7");
        [self.gcdButton removeFromSuperview];
        [self.gcdLabel removeFromSuperview];
        [self.ldeButton removeFromSuperview];
        [self.ldeLabel removeFromSuperview];
        [self.modButton removeFromSuperview];
        [self.modLabel removeFromSuperview];
        [self.aboutButton removeFromSuperview];
        self.gcdButton.frame = CGRectMake(self.gcdButton.frame.origin.x,self.gcdButton.frame.origin.y - 30,self.gcdButton.frame.size.width,self.gcdButton.frame.size.height);
        self.gcdLabel.frame = CGRectMake(self.gcdLabel.frame.origin.x,self.gcdLabel.frame.origin.y - 30,self.gcdLabel.frame.size.width,self.gcdLabel.frame.size.height);
        self.ldeButton.frame = CGRectMake(self.ldeButton.frame.origin.x,self.ldeButton.frame.origin.y - 30,self.ldeButton.frame.size.width,self.ldeButton.frame.size.height);
        self.ldeLabel.frame = CGRectMake(self.ldeLabel.frame.origin.x,self.ldeLabel.frame.origin.y - 30,self.ldeLabel.frame.size.width,self.ldeLabel.frame.size.height);
        self.modButton.frame = CGRectMake(self.modButton.frame.origin.x,self.modButton.frame.origin.y - 30,self.modButton.frame.size.width,self.modButton.frame.size.height);
        self.modLabel.frame = CGRectMake(self.modLabel.frame.origin.x,self.modLabel.frame.origin.y - 30,self.modLabel.frame.size.width,self.modLabel.frame.size.height);
        self.aboutButton.frame = CGRectMake(self.aboutButton.frame.origin.x,self.aboutButton.frame.origin.y - 90,self.aboutButton.frame.size.width,self.aboutButton.frame.size.height);
        [self.view addSubview:self.aboutButton];
        [self.view addSubview:self.gcdButton];
        [self.view addSubview:self.gcdLabel];
        [self.view addSubview:self.ldeButton];
        [self.view addSubview:self.ldeLabel];
        [self.view addSubview:self.modButton];
        [self.view addSubview:self.modLabel];
    }
    
    //Adjust label/button positions for 3.5-inch devices running iOS 6
    else if (!IS_IPHONE5 &&!IS_IPAD && !IS_IOS7) {
        NSLog(@"3.5 Inch, iOS 6");
        [self.gcdButton removeFromSuperview];
        [self.gcdLabel removeFromSuperview];
        [self.ldeButton removeFromSuperview];
        [self.ldeLabel removeFromSuperview];
        [self.modButton removeFromSuperview];
        [self.modLabel removeFromSuperview];
        [self.header removeFromSuperview];
        [self.aboutButton removeFromSuperview];
        self.header.frame = CGRectMake(self.header.frame.origin.x,self.header.frame.origin.y - 80,self.header.frame.size.width,self.header.frame.size.height);
        self.header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
        self.header.numberOfLines = 2;
        self.gcdButton.frame = CGRectMake(self.gcdButton.frame.origin.x,self.gcdButton.frame.origin.y - 110,self.gcdButton.frame.size.width,self.gcdButton.frame.size.height);
        //        UIImage *gcdbuttonimage = [UIImage imageNamed:@"ios-6-gcd-button.png"];
        //        UIImage *highlightedgcdbuttonimage = [UIImage imageNamed:@"ios-6-gcd-button-highlighted.png"];
        //        UIImageView *gcdbuttonimageview = [[UIImageView alloc]initWithFrame:self.gcdButton.frame];
        //        [gcdbuttonimageview setImage:gcdbuttonimage];
        //[self.gcdButton setImage:gcdbuttonimage forState:UIControlStateNormal];
        //        gcdbuttonimageview.userInteractionEnabled = NO;
        //        UIButton *newGCDButton = [[UIButton alloc]initWithFrame:self.gcdButton.frame];
        //        [newGCDButton setImage:gcdbuttonimage forState:UIControlStateNormal];
        //        [newGCDButton setImage:highlightedgcdbuttonimage forState:UIControlStateHighlighted];
        //        [newGCDButton addTarget:self action: @selector(slideToGCDViewController:) forControlEvents:UIControlEventTouchUpInside];
        self.gcdLabel.frame = CGRectMake(self.gcdLabel.frame.origin.x,self.gcdLabel.frame.origin.y - 110,self.gcdLabel.frame.size.width,self.gcdLabel.frame.size.height);
        self.ldeButton.frame = CGRectMake(self.ldeButton.frame.origin.x,self.ldeButton.frame.origin.y - 100,self.ldeButton.frame.size.width,self.ldeButton.frame.size.height);
        self.ldeLabel.frame = CGRectMake(self.ldeLabel.frame.origin.x,self.ldeLabel.frame.origin.y - 100,self.ldeLabel.frame.size.width,self.ldeLabel.frame.size.height);
        self.modButton.frame = CGRectMake(self.modButton.frame.origin.x,self.modButton.frame.origin.y - 90,self.modButton.frame.size.width,self.modButton.frame.size.height);
        self.modLabel.frame = CGRectMake(self.modLabel.frame.origin.x,self.modLabel.frame.origin.y - 90,self.modLabel.frame.size.width,self.modLabel.frame.size.height);
        self.ios6AboutButton = [[UIButton alloc]init];
                self.ios6AboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ios6AboutButton.frame = CGRectMake(self.view.frame.size.width - 95, self.view.frame.size.height - 35 - 40, 90, 30);
        UILabel *ios6AboutButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        ios6AboutButtonLabel.textColor = [UIColor blackColor];
        ios6AboutButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:18];
        ios6AboutButtonLabel.text = @"ABOUT";
        ios6AboutButtonLabel.textAlignment = NSTextAlignmentRight;
        [self.ios6AboutButton addSubview:ios6AboutButtonLabel];
        [self.ios6AboutButton addTarget:self action:@selector(slideToAboutViewController:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.ios6AboutButton];
        [self.view addSubview:self.header];
        [self.view addSubview:self.gcdButton];
        //        [self.view addSubview:gcdbuttonimageview];
        //[self.view addSubview:newGCDButton];
        [self.view addSubview:self.gcdLabel];
        [self.view addSubview:self.ldeButton];
        [self.view addSubview:self.ldeLabel];
        [self.view addSubview:self.modButton];
        [self.view addSubview:self.modLabel];
    }
    
    //Adjust label/button positions for 4-inch devices running iOS 6
    else if (IS_IPHONE5 && !IS_IOS7) {
        NSLog(@"4 Inch, iOS 6");
        [self.gcdButton removeFromSuperview];
        [self.gcdLabel removeFromSuperview];
        [self.ldeButton removeFromSuperview];
        [self.ldeLabel removeFromSuperview];
        [self.modButton removeFromSuperview];
        [self.modLabel removeFromSuperview];
        [self.header removeFromSuperview];
        [self.aboutButton removeFromSuperview];
        self.header.frame = CGRectMake(self.header.frame.origin.x,self.header.frame.origin.y - 45,self.header.frame.size.width,self.header.frame.size.height);
        self.header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:35];
        self.header.numberOfLines = 2;
        self.gcdButton.frame = CGRectMake(self.gcdButton.frame.origin.x,self.gcdButton.frame.origin.y - 55,self.gcdButton.frame.size.width,self.gcdButton.frame.size.height);
        self.gcdLabel.frame = CGRectMake(self.gcdLabel.frame.origin.x,self.gcdLabel.frame.origin.y - 55,self.gcdLabel.frame.size.width,self.gcdLabel.frame.size.height);
        self.ldeButton.frame = CGRectMake(self.ldeButton.frame.origin.x,self.ldeButton.frame.origin.y - 40,self.ldeButton.frame.size.width,self.ldeButton.frame.size.height);
        self.ldeLabel.frame = CGRectMake(self.ldeLabel.frame.origin.x,self.ldeLabel.frame.origin.y - 40,self.ldeLabel.frame.size.width,self.ldeLabel.frame.size.height);
        self.modButton.frame = CGRectMake(self.modButton.frame.origin.x,self.modButton.frame.origin.y - 25,self.modButton.frame.size.width,self.modButton.frame.size.height);
        self.modLabel.frame = CGRectMake(self.modLabel.frame.origin.x,self.modLabel.frame.origin.y - 25,self.modLabel.frame.size.width,self.modLabel.frame.size.height);
                [self.view addSubview:self.header];
        self.ios6AboutButton = [[UIButton alloc]init];
                self.ios6AboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ios6AboutButton.frame = CGRectMake(self.view.frame.size.width - 95, self.view.frame.size.height - 35 - 40, 90, 30);
        UILabel *ios6AboutButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        ios6AboutButtonLabel.textColor = [UIColor blackColor];
        ios6AboutButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:18];
        ios6AboutButtonLabel.text = @"ABOUT";
        ios6AboutButtonLabel.textAlignment = NSTextAlignmentRight;
        [self.ios6AboutButton addSubview:ios6AboutButtonLabel];
        [self.ios6AboutButton addTarget:self action:@selector(slideToAboutViewController:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.ios6AboutButton];
        [self.view addSubview:self.gcdButton];
        [self.view addSubview:self.gcdLabel];
        [self.view addSubview:self.ldeButton];
        [self.view addSubview:self.ldeLabel];
        [self.view addSubview:self.modButton];
        [self.view addSubview:self.modLabel];

    }
    
    //Adjust label/button positions for iPads running iOS 6
    else if (IS_IPAD && !IS_IOS7) {
        NSLog(@"iPad, iOS 6");
        [self.gcdButton removeFromSuperview];
        [self.gcdLabel removeFromSuperview];
        [self.ldeButton removeFromSuperview];
        [self.ldeLabel removeFromSuperview];
        [self.modButton removeFromSuperview];
        [self.modLabel removeFromSuperview];
        [self.header removeFromSuperview];
        [self.aboutButton removeFromSuperview];
        self.header.frame = CGRectMake(self.header.frame.origin.x,self.header.frame.origin.y - 45,self.header.frame.size.width,self.header.frame.size.height);
        self.header.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:60];
        self.header.numberOfLines = 1;
        self.gcdButton.frame = CGRectMake(self.gcdButton.frame.origin.x,self.gcdButton.frame.origin.y - 55,self.gcdButton.frame.size.width,self.gcdButton.frame.size.height);
        self.gcdLabel.frame = CGRectMake(self.gcdLabel.frame.origin.x,self.gcdLabel.frame.origin.y - 55,self.gcdLabel.frame.size.width,self.gcdLabel.frame.size.height);
        self.ldeButton.frame = CGRectMake(self.ldeButton.frame.origin.x,self.ldeButton.frame.origin.y - 40,self.ldeButton.frame.size.width,self.ldeButton.frame.size.height);
        self.ldeLabel.frame = CGRectMake(self.ldeLabel.frame.origin.x,self.ldeLabel.frame.origin.y - 40,self.ldeLabel.frame.size.width,self.ldeLabel.frame.size.height);
        self.modButton.frame = CGRectMake(self.modButton.frame.origin.x,self.modButton.frame.origin.y - 25,self.modButton.frame.size.width,self.modButton.frame.size.height);
        self.modLabel.frame = CGRectMake(self.modLabel.frame.origin.x,self.modLabel.frame.origin.y - 25,self.modLabel.frame.size.width,self.modLabel.frame.size.height);
        self.ios6AboutButton = [[UIButton alloc]init];

        self.ios6AboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.ios6AboutButton.frame = CGRectMake(self.view.frame.size.width - 100, self.view.frame.size.height - 35 - 45, 90, 30);
        UILabel *ios6AboutButtonLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
        ios6AboutButtonLabel.textColor = [UIColor blackColor];
        ios6AboutButtonLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:22];
        ios6AboutButtonLabel.text = @"ABOUT";
        ios6AboutButtonLabel.textAlignment = NSTextAlignmentRight;
        [self.ios6AboutButton addSubview:ios6AboutButtonLabel];
        [self.ios6AboutButton addTarget:self action:@selector(slideToAboutViewController:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.ios6AboutButton];
        [self.view addSubview:self.header];
        [self.view addSubview:self.gcdButton];
        [self.view addSubview:self.gcdLabel];
        [self.view addSubview:self.ldeButton];
        [self.view addSubview:self.ldeLabel];
        [self.view addSubview:self.modButton];
        [self.view addSubview:self.modLabel];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)slideToGCDViewController:(id)sender{
    [self performSegueWithIdentifier:@"switchToGCD" sender:self];
}

- (void)slideToAboutViewController:(id)sender{
    [self performSegueWithIdentifier:@"switchToAbout" sender:self];
}

/* Detect 4 inch and 3.5 inch displays
 if ((int)[[UIScreen mainScreen] bounds].size.height == 568)
 {
 // This is iPhone 5 screen
 } else {
 // This is iPhone 4/4s screen <-- height = 480
 }
 */

@end
