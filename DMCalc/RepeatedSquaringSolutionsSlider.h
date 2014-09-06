//
//  RepeatedSquaringSolutionsSlider.h
//  DMCalc
//
//  Created by Timothy Tong on 2014-07-06.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RepeatedSquaringSolutionsSliderDelegate<NSObject>
- (void)closeSlider;
@end

@interface RepeatedSquaringSolutionsSlider : UIView
@property (nonatomic, strong) id<RepeatedSquaringSolutionsSliderDelegate>delegate;
@property(nonatomic, assign) long long mod;
- (id)initWithFrame:(CGRect)frame withNumSteps:(int)steps andStrings:(NSMutableArray *)strings;
- (void)setMod:(long long)mod;
@end
