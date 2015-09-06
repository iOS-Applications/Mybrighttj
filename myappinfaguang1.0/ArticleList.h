//
//  ArticleList.h
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleList : NSObject
@property (nonatomic,strong)NSString *articleList_id;
@property (nonatomic,strong)NSString *date;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *commentcount;
@property (nonatomic,strong)NSString *authorid;
@property (nonatomic,strong)NSString *authorname;
@property (nonatomic,strong)NSString *views;
@property (nonatomic,strong)NSString *categoryid;
@property (nonatomic,strong)NSString *categoryname;
-(void)setData:(NSDictionary *)dic;
@end
