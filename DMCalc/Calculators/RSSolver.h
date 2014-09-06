//
//  RSSolver.h
//  DMCalc
//
//  Created by Timothy Tong on 2014-06-19.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSolver : NSObject
@property (nonatomic, readwrite) BOOL canShowSolutions;
- (long long)solveRS:(long long)a :(long long)b :(long long)m;
- (NSMutableArray *)getRemainderStrings;
- (int)getCount;
@end

