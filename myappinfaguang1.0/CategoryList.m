//
//  CategoryList.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "CategoryList.h"
static CategoryList *categoryLst = nil;
@implementation CategoryList
-(void)setData:(NSDictionary *)dic{
    self.categoryList_id          = [dic objectForKey:@"id"];
    self.name                     = [dic objectForKey:@"name"];
    self.articlecount             = [dic objectForKey:@"articlecount"];
    self.categoryList_description = [dic objectForKey:@"description"];
}
+(id)creat{
    @synchronized (self){
        if (categoryLst == nil) {
            categoryLst = [[CategoryList alloc]init];
        }
        return categoryLst;
    }
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    @synchronized (self){
        if (categoryLst == nil) {
            categoryLst = [[super allocWithZone:zone]init];
        }
        return categoryLst;
    }
}
-(id)copyWithZone:(NSZone *)zone{
    return categoryLst;
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return categoryLst;
}
@end
