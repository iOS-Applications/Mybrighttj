//
//  Comment.h
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic,strong)NSString *commentid;;
@property (nonatomic,strong)NSString *commentauthor;
@property (nonatomic,strong)NSString *commentauthoremail;
@property (nonatomic,strong)NSString *commentdate;
@property (nonatomic,strong)NSString *commentcontent;

-(void)setData:(NSDictionary *)dic;

@end
