//
//  Comment.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(void)setData:(NSDictionary *)dic{
        self.commentid          = [dic objectForKey:@"commentid"];
        self.commentauthor      = [dic objectForKey:@"commentauthor"];
        self.commentauthoremail = [dic objectForKey:@"commentauthoremail"];
        self.commentdate        = [dic objectForKey:@"commentdate"];
        self.commentcontent     = [dic objectForKey:@"commentcontent"];
}
@end
