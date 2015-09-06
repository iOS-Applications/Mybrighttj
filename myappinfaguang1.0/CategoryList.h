//
//  CategoryList.h
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryList : NSObject<NSCopying,NSMutableCopying>

@property (nonatomic,strong)NSString *categoryList_id;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *articlecount;
@property (nonatomic,strong)NSString *categoryList_description;

-(void)setData:(NSDictionary *)dic;
+(id)creat;
@end
