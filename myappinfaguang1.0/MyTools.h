//
//  MyTools.h
//  myappinSchool1.0
//
//  Created by XuLee on 15/7/22.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AFHTTPRequestOperationManager.h>

#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import <SystemConfiguration/SCNetworkReachability.h>

#define HEIGHT     [[UIScreen mainScreen] bounds].size.height //获取屏幕的高度
#define WIDTH      [[UIScreen mainScreen] bounds].size.width  //获取屏幕的宽度

#define LEFTWIDTH WIDTH/3*2

#define Url_categoryList  @"http://www.brighttj.com/api/index.php/api/category/categoryList"
#define Url_articleList   @"http://www.brighttj.com/api/index.php/api/article/articleByCategoryId"
#define Url_articleViewed @"http://www.brighttj.com/brighttj/index.php/api/article/articleViewed"
#define Url_articleById   @"http://www.brighttj.com/api/index.php/api/article/articleById"

#pragma mark 16进制颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define MYCOLOR 0x1E90FF
#define HaveNetWork [MyTools connectedToNetwork]

@interface MyTools : NSObject
+ (BOOL)connectedToNetwork;

@end
