//
//  CommentViewController.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "CommentViewController.h"
#import "MyTools.h"
#import "Comment.h"
#import "CommentTableViewCell.h"
#import <UIScrollView+EmptyDataSet.h>
@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic,strong)UITableView *mytable;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewCreat];
    // Do any additional setup after loading the view.
}
- (void)viewCreat{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"评论列表";
    
    _mytable = [[UITableView alloc]init];
    _mytable.translatesAutoresizingMaskIntoConstraints = NO;
    _mytable.delegate = self;
    _mytable.dataSource = self;
    [self.view addSubview:_mytable];
    _mytable.tableFooterView = [UIView new];
    _mytable.emptyDataSetSource = self;
    _mytable.emptyDataSetDelegate = self;
    NSArray *_mytableH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mytable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mytable)];
    NSArray *_mytableV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_mytable]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mytable)];
    [self.view addConstraints:_mytableH];
    [self.view addConstraints:_mytableV];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"还没有评论哦";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"empty"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _commentArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenifier = @"cell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (!cell) {
        cell = [[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = [_commentArr objectAtIndex:indexPath.row];
    Comment *comment = [Comment new];
    [comment setData:dic];
    cell.myNameLab.text = comment.commentauthor;;
    cell.myTimeLab.text = comment.commentdate;
    cell.myContentLab.text = comment.commentcontent;
    
    NSLog(@"--------%@",cell.myContentLab);
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [_commentArr objectAtIndex:indexPath.row];
    Comment *comment = [Comment new];
    [comment setData:dic];
    
    
    CGSize size = [comment.commentcontent boundingRectWithSize:CGSizeMake(WIDTH-40, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil].size;
    return size.height+80;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
