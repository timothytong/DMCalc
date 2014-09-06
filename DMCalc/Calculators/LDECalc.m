//
//  LDECalc.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-01.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import "LDECalc.h"

@implementation LDECalc
@synthesize gcdCalc;

-(NSArray*) solveLDE:(int)x
                    :(int)y
                    :(int)z
{
    NSArray* results;
    gcdCalc = [[GCDCalc alloc]init];
    gcd = [gcdCalc calculateGCD:x :y];
    if(z % gcd != 0){
        return nil;
    }
    else{
        NSArray* quotients = [[NSMutableArray alloc]initWithArray:[gcdCalc getQuotients]];
        int multiplier = z / gcd;
        //        NSLog(@"%d",[quotients count]);
        if (quotients == nil) {
            return nil;
        }
        else{
            if(x > y){
                xCo1 = 0;
                yCo1 = 1;
                xCo3 = 1;
                yCo3 = -1 * [[quotients objectAtIndex:0]intValue];
                //                NSLog(@"xCo3: %d yCo2: %d", xCo3, yCo3);
                if ([quotients count] == 1) {
                    NSLog(@"x>y");
                    return [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:z/y], nil];
                }
                else{
                    for (int i = 1; i < [quotients count] - 1; i++) {
                        //                        NSLog(@"q = %d", [[quotients objectAtIndex:i]intValue]);
                        //                        NSLog(@"xCo1: %d yCo1: %d", xCo1, yCo1);
                        //                        NSLog(@"xCo2: %d yCo2: %d", xCo2, yCo2);
                        //                        NSLog(@"xCo3: %d yCo3: %d", xCo3, yCo3);
                        //                        NSLog(@"Operation start");
                        xCo2 = xCo3;
                        yCo2 = yCo3;
                        xCo3 *= -[[quotients objectAtIndex:i]intValue];
                        xCo3 += xCo1;
                        yCo3 *= -[[quotients objectAtIndex:i]intValue];
                        yCo3 += yCo1;
                        xCo1 = xCo2;
                        yCo1 = yCo2;
                        //                        NSLog(@"Operation complete");
                        //                        NSLog(@"xCo3: %d yCo3: %d", xCo3, yCo3);
                    }
                    NSLog(@"%d", xCo3);
                    return [[NSArray alloc]initWithObjects: [NSNumber numberWithInt:(xCo3 * multiplier)], [NSNumber numberWithInt: (yCo3 * multiplier)], nil];
                    
                }
            }
            else if (x < y){
                xCo1 = 1;
                yCo1 = 0;
                xCo3 = -1 * [[quotients objectAtIndex:0]intValue];
                yCo3 = 1;
                if ([quotients count] == 1) {
                    NSLog(@"x<y");
                    return [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:z/x], [NSNumber numberWithInt:0], nil];
                }
                else{
                    for (int i = 1; i < [quotients count] - 1; i++) {
                        xCo2 = xCo3;
                        yCo2 = yCo3;
                        xCo3 *= -[[quotients objectAtIndex:i]intValue];
                        xCo3 += xCo1;
                        yCo3 *= -[[quotients objectAtIndex:i]intValue];
                        yCo3 += yCo1;
                        xCo1 = xCo2;
                        yCo1 = yCo2;
                    }
                    NSLog(@"%d", xCo3);
                    return [[NSArray alloc]initWithObjects: [NSNumber numberWithInt:(xCo3 * multiplier)], [NSNumber numberWithInt: (yCo3 * multiplier)], nil];
                }
            }
            else{
                return nil;
            }
        }
    }
    // results = [[NSArray alloc]initWithObjects:[NSNumber numberWithInt:x], [NSNumber numberWithInt:y], nil];
    return results;
}

-(int) getGCD
{
    return gcd;
}
// if results is NULL prompt "We are only interested in distinct non-zero coefficients".
@end
