//
//  AboutViewController.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-06-02.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import "AboutViewController.h"
#import "Constants.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;
@property (weak, nonatomic) IBOutlet UILabel *paragraphOne;
@property (weak, nonatomic) IBOutlet UILabel *paragraphTwo;
@property (weak, nonatomic) IBOutlet UILabel *paragraphThree;
@property (weak, nonatomic) IBOutlet UILabel *paragraphFour;
@property (weak, nonatomic) IBOutlet UILabel *paragraphFive;
@property (weak, nonatomic) IBOutlet UILabel *crLabel;

@end

@implementation AboutViewController

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
    NSLog(@"AboutViewController");
    [self.aboutLabel removeFromSuperview];
    self.aboutLabel.text = [NSString stringWithFormat: @"About (v%@)",APP_VERSION];
    [self.view addSubview:self.aboutLabel];
    if (IS_IPAD && !IS_IOS7) {
        NSLog(@"iPad, iOS 6");
        [self.aboutLabel removeFromSuperview];
        self.aboutLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE_THIN size:60];
        [self.view addSubview:self.aboutLabel];
        
        [self.crLabel removeFromSuperview];
        self.crLabel.frame = CGRectMake(self.crLabel.frame.origin.x, self.crLabel.frame.origin.y - 65, self.crLabel.frame.size.width, self.crLabel.frame.size.height);
        [self.view addSubview:self.crLabel];
    }
    else if (!IS_IPHONE5 && !IS_IPAD) {
        if (!IS_IOS7) {
            NSLog(@"3.5 inch, iOS 6");
            [self.aboutLabel removeFromSuperview];
            self.aboutLabel.frame = CGRectMake(self.aboutLabel.frame.origin.x, self.aboutLabel.frame.origin.y - 70, self.aboutLabel.frame.size.width, self.aboutLabel.frame.size.height);
            self.aboutLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
            [self.paragraphOne removeFromSuperview];
            self.paragraphOne.frame = CGRectMake(self.paragraphOne.frame.origin.x, self.paragraphOne.frame.origin.y - 90, self.paragraphOne.frame.size.width, self.paragraphOne.frame.size.height);
            
            [self.paragraphTwo removeFromSuperview];
            self.paragraphTwo.frame = CGRectMake(self.paragraphTwo.frame.origin.x, self.paragraphTwo.frame.origin.y - 100, self.paragraphTwo.frame.size.width, self.paragraphTwo.frame.size.height);
            
            [self.paragraphThree removeFromSuperview];
            self.paragraphThree.frame = CGRectMake(self.paragraphThree.frame.origin.x, self.paragraphThree.frame.origin.y - 110, self.paragraphThree.frame.size.width, self.paragraphThree.frame.size.height);
            [self.paragraphThree sizeToFit];
            
            [self.paragraphFour removeFromSuperview];
            self.paragraphFour.frame = CGRectMake(self.paragraphFour.frame.origin.x, self.paragraphFour.frame.origin.y - 110, self.paragraphFour.frame.size.width, self.paragraphFour.frame.size.height);
            [self.paragraphFour sizeToFit];
            
            [self.paragraphFive removeFromSuperview];
            self.paragraphFive.frame = CGRectMake(self.paragraphFive.frame.origin.x, self.paragraphFive.frame.origin.y - 110, self.paragraphFive.frame.size.width, self.paragraphFive.frame.size.height);
            [self.paragraphFive sizeToFit];
            
            [self.crLabel removeFromSuperview];
            self.crLabel.frame = CGRectMake(self.crLabel.frame.origin.x, self.crLabel.frame.origin.y - 155, self.crLabel.frame.size.width, self.crLabel.frame.size.height);
            
            [self.view addSubview:self.aboutLabel];
            [self.view addSubview:self.paragraphOne];
            [self.view addSubview:self.paragraphTwo];
            [self.view addSubview:self.paragraphThree];
            [self.view addSubview:self.paragraphFour];
            [self.view addSubview:self.paragraphFive];
            [self.view addSubview:self.crLabel];
        }
        else{
            NSLog(@"3.5 inch, iOS 7");
            [self.aboutLabel removeFromSuperview];
            self.aboutLabel.frame = CGRectMake(self.aboutLabel.frame.origin.x, self.aboutLabel.frame.origin.y - 5, self.aboutLabel.frame.size.width, self.aboutLabel.frame.size.height);
            self.aboutLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
            [self.paragraphOne removeFromSuperview];
            self.paragraphOne.frame = CGRectMake(self.paragraphOne.frame.origin.x, self.paragraphOne.frame.origin.y - 20, self.paragraphOne.frame.size.width, self.paragraphOne.frame.size.height);
            
            [self.paragraphTwo removeFromSuperview];
            self.paragraphTwo.frame = CGRectMake(self.paragraphTwo.frame.origin.x, self.paragraphTwo.frame.origin.y - 40, self.paragraphTwo.frame.size.width, self.paragraphTwo.frame.size.height);
            
            [self.paragraphThree removeFromSuperview];
            self.paragraphThree.frame = CGRectMake(self.paragraphThree.frame.origin.x, self.paragraphThree.frame.origin.y - 50, self.paragraphThree.frame.size.width, self.paragraphThree.frame.size.height);
            [self.paragraphThree sizeToFit];
            
            [self.paragraphFour removeFromSuperview];
            self.paragraphFour.frame = CGRectMake(self.paragraphFour.frame.origin.x, self.paragraphFour.frame.origin.y - 40, self.paragraphFour.frame.size.width, self.paragraphFour.frame.size.height);
            [self.paragraphFour sizeToFit];
            
            [self.paragraphFive removeFromSuperview];
            self.paragraphFive.frame = CGRectMake(self.paragraphFive.frame.origin.x, self.paragraphFive.frame.origin.y - 40, self.paragraphFive.frame.size.width, self.paragraphFive.frame.size.height);
            [self.paragraphFive sizeToFit];
            
            [self.crLabel removeFromSuperview];
            self.crLabel.frame = CGRectMake(self.crLabel.frame.origin.x, self.crLabel.frame.origin.y - 90, self.crLabel.frame.size.width, self.crLabel.frame.size.height);
            
            [self.view addSubview:self.aboutLabel];
            [self.view addSubview:self.paragraphOne];
            [self.view addSubview:self.paragraphTwo];
            [self.view addSubview:self.paragraphThree];
            [self.view addSubview:self.paragraphFour];
            [self.view addSubview:self.paragraphFive];
            [self.view addSubview:self.crLabel];
        }
    }
    else if (IS_IPHONE5 && !IS_IOS7) {

            NSLog(@"4 inch, iOS 6");
            [self.aboutLabel removeFromSuperview];
            self.aboutLabel.frame = CGRectMake(self.aboutLabel.frame.origin.x, self.aboutLabel.frame.origin.y - 50, self.aboutLabel.frame.size.width, self.aboutLabel.frame.size.height);
            self.aboutLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:40];
            [self.paragraphOne removeFromSuperview];
            self.paragraphOne.frame = CGRectMake(self.paragraphOne.frame.origin.x, self.paragraphOne.frame.origin.y - 40, self.paragraphOne.frame.size.width, self.paragraphOne.frame.size.height);
            
            [self.paragraphTwo removeFromSuperview];
            self.paragraphTwo.frame = CGRectMake(self.paragraphTwo.frame.origin.x, self.paragraphTwo.frame.origin.y - 40, self.paragraphTwo.frame.size.width, self.paragraphTwo.frame.size.height);
            
            [self.paragraphThree removeFromSuperview];
            self.paragraphThree.frame = CGRectMake(self.paragraphThree.frame.origin.x, self.paragraphThree.frame.origin.y - 30, self.paragraphThree.frame.size.width, self.paragraphThree.frame.size.height);
            [self.paragraphThree sizeToFit];
            
            [self.paragraphFour removeFromSuperview];
            self.paragraphFour.frame = CGRectMake(self.paragraphFour.frame.origin.x, self.paragraphFour.frame.origin.y - 20, self.paragraphFour.frame.size.width, self.paragraphFour.frame.size.height);
            [self.paragraphFour sizeToFit];
            
            [self.paragraphFive removeFromSuperview];
            self.paragraphFive.frame = CGRectMake(self.paragraphFive.frame.origin.x, self.paragraphFive.frame.origin.y - 25, self.paragraphFive.frame.size.width, self.paragraphFive.frame.size.height);
            [self.paragraphFive sizeToFit];
            
            [self.crLabel removeFromSuperview];
            self.crLabel.frame = CGRectMake(self.crLabel.frame.origin.x, self.crLabel.frame.origin.y - 65, self.crLabel.frame.size.width, self.crLabel.frame.size.height);
            
            [self.view addSubview:self.aboutLabel];
            [self.view addSubview:self.paragraphOne];
            [self.view addSubview:self.paragraphTwo];
            [self.view addSubview:self.paragraphThree];
            [self.view addSubview:self.paragraphFour];
            [self.view addSubview:self.paragraphFive];
            [self.view addSubview:self.crLabel];
        
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
