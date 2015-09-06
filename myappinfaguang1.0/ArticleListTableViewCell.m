//
//  ArticleListTableViewCell.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "ArticleListTableViewCell.h"
#import "MyTools.h"
@implementation ArticleListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self viewCreat];
    }
    return self;
}
- (void)viewCreat{
    _myTitltLab = [[UILabel alloc]init];
    _myTitltLab.translatesAutoresizingMaskIntoConstraints = NO;
    _myTitltLab.font = [UIFont systemFontOfSize:18];
    _myTitltLab.textColor = UIColorFromRGB(MYCOLOR);
    _myTitltLab.numberOfLines = 0;
    [self addSubview:_myTitltLab];
    
    NSArray *_mylabH = [NSLayoutConstraint
                        constraintsWithVisualFormat:@"H:|-10-[_myTitltLab]-10-|"
                        options:0
                        metrics:nil
                        views:NSDictionaryOfVariableBindings(_myTitltLab)];
    NSArray *_mylabV = [NSLayoutConstraint
                        constraintsWithVisualFormat:@"V:|-10-[_myTitltLab(==60)]|"
                        options:0
                        metrics:nil
                        views:NSDictionaryOfVariableBindings(_myTitltLab)];
    [self addConstraints:_mylabH];
    [self addConstraints:_mylabV];
    
    
    

    
    _myDateLab = [[UILabel alloc]init];
    _myDateLab.translatesAutoresizingMaskIntoConstraints = NO;
    _myDateLab.font = [UIFont systemFontOfSize:13];
    _myDateLab.textColor = [UIColor grayColor];
    _myDateLab.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_myDateLab];
    
    NSArray *_myDateLabH = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"H:|-20-[_myDateLab(==width)]"
                            options:0
                            metrics:@{@"width":@(WIDTH/2-20)}
                            views:NSDictionaryOfVariableBindings(_myDateLab)];
    NSArray *_myDateLabV = [NSLayoutConstraint
                            constraintsWithVisualFormat:@"V:[_myTitltLab]-10-[_myDateLab(==20)]"
                            options:0
                            metrics:nil
                            views:NSDictionaryOfVariableBindings(_myTitltLab,_myDateLab)];
    [self addConstraints:_myDateLabH];
    [self addConstraints:_myDateLabV];
    
    _myOtherLab = [[UILabel alloc]init];
    _myOtherLab.translatesAutoresizingMaskIntoConstraints = NO;
    _myOtherLab.font = [UIFont systemFontOfSize:13];
    _myOtherLab.textColor = [UIColor grayColor];
    _myOtherLab.textAlignment = NSTextAlignmentRight;
    [self addSubview:_myOtherLab];
    
    NSArray *_myOtherLabH = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"H:[_myDateLab]-0-[_myOtherLab(==width)]-20-|"
                             options:0
                             metrics:@{@"width":@(WIDTH/2-20)}
                             views:NSDictionaryOfVariableBindings(_myDateLab,_myOtherLab)];
    NSArray *_myOtherLabV = [NSLayoutConstraint
                             constraintsWithVisualFormat:@"V:[_myTitltLab]-10-[_myOtherLab(==20)]"
                             options:0
                             metrics:nil
                             views:NSDictionaryOfVariableBindings(_myTitltLab,_myOtherLab)];
    [self addConstraints:_myOtherLabH];
    [self addConstraints:_myOtherLabV];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
