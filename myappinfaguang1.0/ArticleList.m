//
//  ArticleList.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "ArticleList.h"

@implementation ArticleList
-(void)setData:(NSDictionary *)dic{
    self.articleList_id = [dic objectForKey:@"id"];
    self.date           = [dic objectForKey:@"date"];
    self.title          = [dic objectForKey:@"title"];
    self.commentcount   = [dic objectForKey:@"commentcount"];
    self.authorid       = [dic objectForKey:@"authorid"];
    self.authorname     = [dic objectForKey:@"authorname"];
    self.views          = [dic objectForKey:@"views"];
    self.categoryid     = [dic objectForKey:@"categoryid"];
    self.categoryname   = [dic objectForKey:@"categoryname"];
}
@end
