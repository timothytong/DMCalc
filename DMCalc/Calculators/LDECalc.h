//
//  LDECalc.h
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-01.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDCalc.h"
int gcd;
int xCo1;
int yCo1;
int xCo2;
int yCo2;
int xCo3;
int yCo3;

@interface LDECalc : NSObject
{
    GCDCalc* gcdCalc;
}
-(NSArray*) solveLDE:(int)x
                    :(int)y
                    :(int)z;

-(int) getGCD;
@property(nonatomic,retain) GCDCalc* gcdCalc;
@end
