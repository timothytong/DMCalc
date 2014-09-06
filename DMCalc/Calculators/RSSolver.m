//
//  RSSolver.m
//  DMCalc
//
//  Created by Timothy Tong on 2014-06-19.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import "RSSolver.h"
@interface RSSolver()
@property (readwrite, nonatomic) BOOL method2;
@property (strong, nonatomic) NSMutableArray *strings;
@property (strong, nonatomic) NSMutableArray *remainderStrings;
@property (strong, nonatomic) NSMutableArray *exponentStrings;
@property (nonatomic) int numReason;
@property (nonatomic, readwrite) BOOL baseEqualsMod;
@property (nonatomic, readwrite) BOOL remainderIsOne;
@property (nonatomic, strong) NSMutableDictionary *dictionary;
@end

@implementation RSSolver
- (int)getCount{
    return [self.remainderStrings count];
}
- (NSMutableArray *)getRemainderStrings{
    return self.remainderStrings;
}
- (int)getReason{
    if (self.baseEqualsMod) {
        return 1;
    }
    else if(self.remainderIsOne){
        return 2;
    }
    else{
        return -1;
    }
}

- (long long)methodTwo:(long long)a :(long long)b :(long long)m
{
    NSLog(@"Method 2");
    return (a^b)%m;
}

- (long long)solveRS:(long long)a :(long long)b :(long long)m
{
    self.dictionary = [NSMutableDictionary dictionary];
    self.baseEqualsMod = NO;
    self.remainderIsOne = NO;
    self.canShowSolutions = YES;
    self.strings = [NSMutableArray array];
    self.remainderStrings = [NSMutableArray array];
    self.exponentStrings = [NSMutableArray array];
    
    long long r;
    long long expo = 1;
    int counter = 1;
    r = a % m;
    NSMutableArray* remainders = [[NSMutableArray alloc]init];
    [remainders addObject:[NSNumber numberWithLongLong:1]];
    [remainders addObject:[NSNumber numberWithLongLong:r]];
    counter++;
    if (a == m) {
        self.baseEqualsMod = YES;
        r = 0;
    }
    else if (a % m == 1){
        r = 1;
        self.remainderIsOne = YES;
    }
    else{
        long long lastRemainder;
        [self.remainderStrings addObject:[NSString stringWithFormat:@"%lld\u00B9\n≡ %lld",a,a%m]];
        NSLog(@"a mod m = %lld",a%m);
        [self.dictionary setObject:[NSNumber numberWithLongLong:(a%m)] forKey:[NSNumber numberWithLongLong:1]];
        while(expo != b){
            if (r * r >= 0 ) {
                lastRemainder = r;
                if(expo * 2 <= b){
                    expo *= 2;
                    r = (r * r) % m;
                    [remainders addObject:[NSNumber numberWithLongLong:r]];
                    [self.dictionary setObject:[NSNumber numberWithLongLong:r] forKey:[NSNumber numberWithLongLong:expo]];
                    //                    NSLog(@"Key - %lld, Value - %lld", expo, r);
                    counter++;
                    long long previousRemainder;
                    if (counter > 2) {
                        previousRemainder = [[remainders objectAtIndex:[remainders count] - 2]longLongValue];
                    }
                    else{
                        previousRemainder = a;
                    }
                    [self.remainderStrings addObject:[NSString stringWithFormat:@"%lld^%lld≡ %lld x %lld≡ %lld",a,expo,previousRemainder,previousRemainder,[[remainders lastObject] longLongValue]]];
                    NSLog(@"%lld^%lld ≡ %lld * %lld ≡ %lld (mod %lld)",a,expo,previousRemainder,previousRemainder,[[remainders lastObject] longLongValue],m);
                }
                else{
                    for(int i = counter; i >= 0; i--){
                        if(expo + pow(2,i) <= b){
                            expo += pow(2,i);
                            //                            NSLog(@"Using key - %.0f, value - %lld",pow(2,i),[[self.dictionary objectForKey:[NSNumber numberWithInt:pow(2,i)]]longLongValue]);
                            counter++;
                            r = (r * [[remainders objectAtIndex:i+1] longLongValue]) % m;
                            [self.dictionary setObject:[NSNumber numberWithLongLong:r] forKey:[NSNumber numberWithLongLong:expo]];
                            //                            NSLog(@"Key - %lld, Value - %lld", expo, r);
                            [remainders addObject:[NSNumber numberWithLongLong:r]];
                            long long previousRemainder = [[remainders objectAtIndex:[remainders count] - 2]longLongValue];
                            [self.remainderStrings addObject:[NSString stringWithFormat:@"%lld^%lld≡ %lld x %lld≡ %lld",a,expo,previousRemainder,[[self.dictionary objectForKey:[NSNumber numberWithInt:pow(2,i)]]longLongValue],[[remainders lastObject] longLongValue]]];
                            NSLog(@"%lld^%lld ≡ %lld * %lld ≡ %lld (mod %lld)",a,expo,previousRemainder,[[self.dictionary objectForKey:[NSNumber numberWithInt:pow(2,i)]]longLongValue],[[remainders lastObject] longLongValue],m);
                            
                            //                            NSLog(@"exp = %lld, r=%lld",expo,r);
                        }
                    }
                }
                
            }
            else{
                self.canShowSolutions = NO;
                self.method2 = YES;
                //                NSLog(@"Method two.");
                expo = b;
                r = [self methodTwo:a :b :m];
            }
        }
    }
    if (!self.method2) {
        self.canShowSolutions = YES;
        //        NSLog(@"Method one.");
    }
    else{
        self.canShowSolutions = NO;
        NSLog(@"Using method 2...");
    }
    NSLog(@"r = %lld",r);
    return r;
}


@end
