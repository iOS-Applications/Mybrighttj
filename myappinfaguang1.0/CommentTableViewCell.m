//
//  CommentTableViewCell.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "CommentTableViewCell.h"


#import "MyTools.h"
@implementation CommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self viewCreat];
    }
    return self;
}
- (void)viewCreat{
    _myNameLab = [[UILabel alloc]init];
    _myNameLab.translatesAutoresizingMaskIntoConstraints = NO;
    _myNameLab.font = [UIFont systemFontOfSize:18];
    _myNameLab.textColor = UIColorFromRGB(MYCOLOR);
    [self addSubview:_myNameLab];
    
    NSArray *_mylabH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_myNameLab]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myNameLab)];
    NSArray *_mylabV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_myNameLab(==20)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myNameLab)];
    [self addConstraints:_mylabH];
    [self addConstraints:_mylabV];
    
    
    _myTimeLab = [[UILabel alloc]init];
    _myTimeLab.translatesAutoresizingMaskIntoConstraints = NO;
    _myTimeLab.font = [UIFont systemFontOfSize:13];
    _myTimeLab.textColor = [UIColor grayColor];
    [self addSubview:_myTimeLab];
    
    NSArray *_myTimeLabH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_myTimeLab]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myTimeLab)];
    NSArray *_myTimeLabV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_myNameLab]-10-[_myTimeLab(==20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myNameLab,_myTimeLab)];
    [self addConstraints:_myTimeLabH];
    [self addConstraints:_myTimeLabV];
    
    
    _myContentLab = [[UILabel alloc]init];
    _myContentLab.translatesAutoresizingMaskIntoConstraints = NO;
    _myContentLab.font = [UIFont systemFontOfSize:18];
    _myContentLab.textColor = [UIColor blackColor];
    _myContentLab.numberOfLines = 0;
    [self addSubview:_myContentLab];
    
    NSArray *_myContentLabH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[_myContentLab]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myContentLab)];
    NSArray *_myContentLabV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_myTimeLab]-10-[_myContentLab]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myTimeLab,_myContentLab)];
    [self addConstraints:_myContentLabH];
    [self addConstraints:_myContentLabV];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
