//
//  LDEViewController.h
//  DMCalc
//
//  Created by Timothy Tong on 2014-04-03.
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
#import <UIKit/UIKit.h>
#import "LDECalc.h"
#import "GCDCalc.h"

int x;
int y;
int z;
@interface LDEViewController : UIViewController

{

    LDECalc* ldeCalc;
    GCDCalc* gcdCalc;
}

-(IBAction)compute:(id)sender;

@property(nonatomic, retain) LDECalc* ldeCalc;
@property(nonatomic, retain) GCDCalc* gcdCalc;

@end