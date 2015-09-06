//
//  MenuViewController.h
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryList.h"

@protocol changCategory <NSObject>

-(void)sendCategory:(CategoryList *)new_categoryList;

@end

@interface MenuViewController : UIViewController
@property (nonatomic,strong)NSArray *mydata;
@property (nonatomic,assign)id<changCategory>mydelegate;

@end
