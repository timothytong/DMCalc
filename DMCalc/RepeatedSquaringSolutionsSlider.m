//
//  RepeatedSquaringSolutionsSlider.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-07-06.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import "RepeatedSquaringSolutionsSlider.h"
#import "Constants.h"
@interface RepeatedSquaringSolutionsSlider()
@property (strong, nonatomic) UILabel *bannerLabel;
@property (strong, nonatomic) UIScrollView *scrollview;
@property (nonatomic) int numSteps;
@property (strong, nonatomic)  UIView *content;
@property (strong, nonatomic) NSMutableArray *remainderStrings;
@end
@implementation RepeatedSquaringSolutionsSlider
- (id)initWithFrame:(CGRect)frame withNumSteps:(int)steps andStrings:(NSMutableArray *)strings
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.numSteps = steps;
        self.remainderStrings = strings;
        UIView *tabliner = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 4)];
        tabliner.backgroundColor = [UIColor blackColor];
        [self addSubview:tabliner];
        self.content = [[UIView alloc]initWithFrame:CGRectMake(0, 4, self.frame.size.width, self.frame.size.height - 4)];
        self.content.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.content];
        UIImage *cancelimg = [UIImage imageNamed:@"/cancel.png"];
        UIButton *cancelButton = [[UIButton alloc]init];
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(self.frame.size.width - 40, 10, 30, 30);
        [cancelButton setImage:cancelimg forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelButton];
        self.bannerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        self.bannerLabel.textAlignment = NSTextAlignmentCenter;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, 1)];
        line.backgroundColor = [UIColor blackColor];
        self.bannerLabel.text = @"Mod ?";
        self.bannerLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:25];
        [self.content addSubview:line];
        [self.content addSubview:self.bannerLabel];
        self.scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 41, self.frame.size.width, self.frame.size.height - 45)];
        CGFloat yDistance = 100;
        if (IS_IPAD) {
            yDistance += 100;
        }
        if (!IS_IOS7) {
            yDistance += 3;
            if (IS_IPHONE5) {
                yDistance += 1;
            }
        }
        self.scrollview.contentSize = CGSizeMake(self.frame.size.width, yDistance * self.numSteps + 10 + 115);
        self.scrollview.scrollEnabled = YES;
        self.scrollview.showsVerticalScrollIndicator = YES;
        self.scrollview.userInteractionEnabled = YES;
        [self.content addSubview:self.scrollview];
        [self populateScrollView];
    }
    return self;
}

- (void)setMod:(long long)mod{
    self.bannerLabel.text = [NSString stringWithFormat:@"MOD %lld",mod];
}

- (void)populateScrollView{
    UIImage *line = [UIImage imageNamed:@"/separator_line.png"];
    CGFloat yDistance = 90;
    if (IS_IPAD) {
        yDistance += 100;
    }
    if (!IS_IOS7) {
        yDistance += 10;
    }
    CGFloat fontsize = 19;
    if (IS_IPAD) {
        fontsize += 10;
    }
    UIView *startingView = [[UIView alloc]initWithFrame:CGRectMake(20, 10, self.frame.size.width - 40, yDistance)];
    UILabel *begin = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 40, yDistance/4)];
    begin.numberOfLines = 1;
    begin.textAlignment = NSTextAlignmentCenter;
    NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    begin.attributedText = [[NSAttributedString alloc] initWithString:@"BEGIN"
                                                             attributes:underlineAttribute];
    begin.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:fontsize];
    [startingView addSubview:begin];
    UILabel *startingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, yDistance/4, self.frame.size.width - 40, yDistance * 0.75)];
    startingLabel.numberOfLines = 3;
    startingLabel.text = [NSString stringWithFormat:@"STEP 1:\n%@",[self.remainderStrings objectAtIndex:0]];
    startingLabel.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:fontsize];
    [startingView addSubview:startingLabel];
    [self.scrollview addSubview:startingView];
    UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (yDistance + 10) + 4, self.frame.size.width - 30, 2)];
    [lineView setImage:line];
    [self.scrollview addSubview:lineView];
    for (int i = 0; i < self.numSteps - 1; i++) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(20, (i+1) * (yDistance + 10) + 10, self.frame.size.width - 40, yDistance)];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 40, yDistance)];
            label.numberOfLines = 4;
            label.text = [NSString stringWithFormat:@"STEP %d:\n%@",i+2, [self processString:[self.remainderStrings objectAtIndex:i+1]]];

            label.font = [UIFont fontWithName:APP_DEFAULT_FONT_FACE size:fontsize];
            [view addSubview:label];
            [self.scrollview addSubview:view];
            UIImageView *lineView = [[UIImageView alloc]initWithFrame:CGRectMake(15, (i+1) * (yDistance + 10) + 4, self.frame.size.width - 30, 2)];
            [lineView setImage:line];
            [self.scrollview addSubview:lineView];
        });
    }
}

- (NSString *)processString:(NSString *)rawInput{
    NSLog(@"RAW INPUT: %@",rawInput);
    NSString *returnString = @"";
    NSRange baserange = [rawInput rangeOfString:@"^"];
    NSString *base = @"";
    if (baserange.location != NSNotFound) {
//        NSLog(@"Found char ^ at location %d",baserange.location);
        base = [rawInput substringWithRange:NSMakeRange(0, baserange.location)];
    }
    NSLog(@"Base is %@",base);
    
    NSRange exprange = [rawInput rangeOfString:@"≡"];
    NSString *exp = @"";
    if (exprange.location != NSNotFound) {
//        NSLog(@"Found char ≡ at location %d", exprange.location);
        exp = [rawInput substringWithRange:NSMakeRange(baserange.location + 1, exprange.location - baserange.location-1)];
    }
    NSLog(@"Exp is %@",exp);
    
    NSString *superscripts = [self convertToSuperscript:exp];
    returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"%@%@",base,superscripts]];
    
    NSString *temp = [rawInput substringFromIndex:exprange.location + 1];
    NSRange multiplyRange = [temp rangeOfString:@"≡"];
    NSString *multiplication = @"";
    if (multiplyRange.location != NSNotFound) {
        multiplication = [temp substringToIndex:multiplyRange.location];
    }
    returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"\n≡%@",multiplication]];
    
    NSString *answer = [temp substringFromIndex:multiplyRange.location + 1];
    returnString = [returnString stringByAppendingString:[NSString stringWithFormat:@"\n≡%@",answer]];

    NSLog(@"============================================");
    return returnString;
}

- (NSString *)convertToSuperscript:(NSString *)string{
    NSString *resultString = @"";
    for (int i = 0; i < [string length]; i++) {
        if (i == [string length]-1) {
            resultString = [resultString stringByAppendingString:[self getUnicodeForSuperscript:[[string substringFromIndex:i] intValue]]];
        }
        else{
            resultString = [resultString stringByAppendingString:[self getUnicodeForSuperscript:[[string substringWithRange:NSMakeRange(i, 1)] intValue]]];
        }
    }
    return resultString;
}

- (NSString *)getUnicodeForSuperscript:(int)number
{
    switch (number) {
        case 0:
            return @"\u2070";
            break;
        case 1:
            return @"\u00B9";
            break;
        case 2:
            return @"\u00B2";
            break;
        case 3:
            return @"\u00B3";
            break;
        case 4:
            return @"\u2074";
            break;
        case 5:
            return @"\u2075";
            break;
        case 6:
            return @"\u2076";
            break;
        case 7:
            return @"\u2077";
            break;
        case 8:
            return @"\u2078";
            break;
        case 9:
            return @"\u2079";
            break;
        default:
            return @"";
            break;
    }
    return @"";
}

- (void)cancelButtonPressed:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(closeSlider)]) {
        [self.delegate closeSlider];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
