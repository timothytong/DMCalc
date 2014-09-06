//
//  GCDCalc.h
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-01.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import <Foundation/Foundation.h>
NSMutableArray *quotients;

@interface GCDCalc : NSObject
{
}

- (int) calculateGCD:(int)x
                    :(int)y;

- (NSMutableArray*) getQuotients;
@end
