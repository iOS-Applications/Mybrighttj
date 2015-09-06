//
//  StarViewController.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/27.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "StarViewController.h"

#import <UIScrollView+EmptyDataSet.h>

#import "ArticleListTableViewCell.h"

#import "CoreFMDB.h"

#import "Star.h"

#import "ContentViewController.h"
#import "ArticleList.h"

#import "MBProgressHUD.h"
@interface StarViewController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
@property (nonatomic,strong)UITableView *mytable;
@property (nonatomic,strong)NSMutableArray *mydata;
@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewCreat];
    // Do any additional setup after loading the view.
}
- (void)viewCreat{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _mydata    = [NSMutableArray array];
    
    _mytable = [[UITableView alloc]init];
    _mytable.translatesAutoresizingMaskIntoConstraints = NO;
    _mytable.delegate = self;
    _mytable.dataSource = self;
    _mytable.emptyDataSetDelegate = self;
    _mytable.emptyDataSetSource = self;
    [self.view addSubview:_mytable];
    
    _mytable.tableFooterView = [UIView new];
    NSArray *_mytableH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mytable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mytable)];
    NSArray *_mytableV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_mytable]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mytable)];
    [self.view addConstraints:_mytableH];
    [self.view addConstraints:_mytableV];
    
    [self initData];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"还没有收藏哦";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return [UIImage imageNamed:@"empty"];
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initData{
    //查询数据
    [CoreFMDB executeQuery:@"select * from save;" queryResBlock:^(FMResultSet *set) {
        [_mydata removeAllObjects];
        while ([set next]) {
            Star *star = [Star new];
            star.articleById_id = [set stringForColumn:@"articleById_id"];
            star.title = [set stringForColumn:@"title"];
            star.views = [set stringForColumn:@"views"];
            star.commentcount = [set stringForColumn:@"commentcount"];
            star.date = [set stringForColumn:@"date"];
            
            [_mydata addObject:star];
            NSLog(@"%@-%@",[set stringForColumn:@"name"],[set stringForColumn:@"age"]);
        }
        
        [_mytable reloadData];
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mydata.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenifier = @"cell";
    ArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (!cell) {
        cell = [[ArticleListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
    }
    Star *star = [_mydata objectAtIndex:indexPath.row];
    cell.myTitltLab.text = star.title;
    cell.myDateLab.text = star.date;
    cell.myOtherLab.text = [NSString stringWithFormat:@"阅读:(%@) 评论(%@)",star.views,star.commentcount];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Star *star = [_mydata objectAtIndex:indexPath.row];
    ArticleList *articleList = [ArticleList new];
    articleList.articleList_id = star.articleById_id;
    ContentViewController *content = [[ContentViewController alloc]init];
    content.articleList = articleList;
    [self.navigationController pushViewController:content animated:YES];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"移除";
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPathr{
    return 110;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Star *star = [_mydata objectAtIndex:indexPath.row];
    

    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [HUD show:YES];
    
    [self.view addSubview:HUD];

    BOOL res2= [CoreFMDB executeUpdate:[NSString stringWithFormat:@"delete from save where articleById_id = '%@';",star.articleById_id]];
    
    if(res2){
        NSLog(@"添加数据成功");
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yes"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.labelText = @"移除成功";
        
        [HUD hide:YES afterDelay:1.0f];
        
        
        [_mydata removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [_mytable reloadData];
    }else{
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.labelText = @"移除失败";
        
        [HUD hide:YES afterDelay:1.0f];
        
        
        NSLog(@"添加数据失败");
    }
    
    
    
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
