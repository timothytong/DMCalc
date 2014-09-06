//
//  Constants.h
//  DMCalc
//
//  Created by Timothy Tong on 2014-06-01.
//  Copyright (c) 2014 Timothy Tong. All rights reserved.
//

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define APP_DEFAULT_FONT_FACE @"HelveticaNeue-Light"
#define APP_DEFAULT_FONT_FACE_THIN @"HelveticaNeue-UltraLight"
#define APP_VERSION @"1.2"