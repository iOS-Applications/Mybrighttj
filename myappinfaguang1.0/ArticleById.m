//
//  ArticleById.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "ArticleById.h"

@implementation ArticleById
-(void)setData:(NSDictionary *)dic{
    self.articleById_id     = [dic objectForKey:@"id"];
    self.date               = [dic objectForKey:@"date"];
    self.title              = [dic objectForKey:@"title"];
    self.commentcount       = [dic objectForKey:@"commentcount"];
    self.authorid           = [dic objectForKey:@"authorid"];
    self.authorname         = [dic objectForKey:@"authorname"];
    self.views              = [dic objectForKey:@"views"];
    self.comments           = [dic objectForKey:@"comments"];
}
@end
