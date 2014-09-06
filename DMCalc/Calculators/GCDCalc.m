//
//  GCDCalc.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-01.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import "GCDCalc.h"

@implementation GCDCalc

- (int) calculateGCD:(int)x
                    :(int)y
{
    quotients = [[NSMutableArray alloc]init];
    int a = abs(x);
    int b = abs(y);
    if(a == 0 && b == 0){
        return -1;
    }
    if(a == 0 || b == 0){
//        [quotients addObject: [NSNumber numberWithInt:0]];
        return 0;
    }
    if(x == y){
//        [quotients addObject: [NSNumber numberWithInt:1]];
        return abs(x);
    }
    else if (x > y) {
        a = x;
        b = y;
    }
    else{
        a = y;
        b = x;
    }
    int r = 1;
    int q;
    while(r != 0){
        q = a / b;
        [quotients addObject: [NSNumber numberWithInt:q]];
        r = a % b;
        a = b;
        b = r;
    }
    return a;
}

- (NSMutableArray*) getQuotients
{
    return quotients;
}
@end
