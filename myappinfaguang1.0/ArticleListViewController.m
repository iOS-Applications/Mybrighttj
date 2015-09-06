//
//  ViewController.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "ArticleListViewController.h"

#import "MyTools.h"

#import "ArticleList.h"

#import "ContentViewController.h"

#import "CategoryList.h"

#import <MJRefresh.h>

#import "MenuViewController.h"

#import "PresentingAnimator.h"
#import "DismissingAnimator.h"

#import "ArticleListTableViewCell.h"


#import "StarViewController.h"

#import <UIScrollView+EmptyDataSet.h>
@interface ArticleListViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerTransitioningDelegate,changCategory,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>
{
    AFHTTPRequestOperationManager *manager;
    MBProgressHUD *HUD;
    
}
@property (nonatomic,strong)UITableView *mytable;
@property (nonatomic,strong)NSMutableArray *mydata;
@property (nonatomic,strong)UIScrollView *myscroll;
@property (nonatomic,strong)CategoryList *categoryList;
@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewCreat];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewCreat{
    
    
    _mydata = [NSMutableArray array];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _myscroll = [[UIScrollView alloc]init];
    _myscroll.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    _mytable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
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
    _mytable.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getList:_categoryList.categoryList_id];
        [_mytable.header endRefreshing];
    }];
    
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUD];
    
    manager = [AFHTTPRequestOperationManager manager];

    [self getMenu];

    
    
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu"] style:UIBarButtonItemStylePlain target:self action:@selector(showMenu)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"star"] style:UIBarButtonItemStylePlain target:self action:@selector(lookStar)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.title = @"发光的我";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];//修改标题颜色

}
- (void)lookStar{
    StarViewController *star = [[StarViewController alloc]init];
    [self.navigationController pushViewController:star animated:YES];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"empty"];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"居然加载失败了呢.";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    NSString *text = @"点我重试";;
    UIFont *font = [UIFont boldSystemFontOfSize:20.0];
    UIColor *textColor = UIColorFromRGB(MYCOLOR);
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    BOOL flag = HaveNetWork;
    if (flag) {
        [self getMenu];
    }else{
        [self.view makeToast:@"网络未连接" duration:1.0f position:CSToastPositionCenter];
    }
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

- (void)showMenu{
    [manager GET:Url_categoryList parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MenuViewController *modalViewController = [MenuViewController new];
        modalViewController.mydata = [[responseObject objectForKey:@"data"] objectForKey:@"categoryList"];
        modalViewController.transitioningDelegate = self;
        modalViewController.modalPresentationStyle = UIModalPresentationCustom;
        modalViewController.mydelegate = self;
        [self.navigationController presentViewController:modalViewController
                                                animated:YES
                                              completion:NULL];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.view makeToast:@"出错了呢" duration:1.0f position:CSToastPositionCenter];
    }];
    
}
-(void)getMenu{
    
    [manager GET:Url_categoryList parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _categoryList = [[CategoryList alloc]init];
        [_categoryList setData:[[[responseObject objectForKey:@"data"] objectForKey:@"categoryList"] firstObject]];
        [self getList:_categoryList.categoryList_id];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.view makeToast:@"出错了呢" duration:1.0f position:CSToastPositionCenter];

    }];
}
- (void)sendCategory:(CategoryList *)new_categoryList{
    _categoryList = new_categoryList;
    [self getList:_categoryList.categoryList_id];
}
- (void)getList:(NSString *)new_index{
    
    
    
    [HUD show:YES];
    
    
    
    NSDictionary *parameters = @{@"categoryId": new_index,
                                 @"page": @"0",
                                 @"pageSize": [NSString stringWithFormat:@"%zi",[_categoryList.articlecount intValue]*2]};
    [manager POST:Url_articleList parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [HUD hide:YES];
        NSLog(@">>>>%@",responseObject);
        [_mydata removeAllObjects];
        [_mydata addObjectsFromArray:[[responseObject objectForKey:@"data"] objectForKey:@"articleList"]];
        
        
        for (int i = 0,count = 0; i < [[[responseObject objectForKey:@"data"] objectForKey:@"articleList"] count]; i++) {
            if (i%2!=0) {
                NSLog(@"<<<<<<%d",i);
                
                [_mydata removeObjectAtIndex:i-count];
                count ++;
            }
        }
        [_mytable reloadData];
        NSLog(@"---------%zi",_mydata.count);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.labelText = @"加载失败";
        
        [HUD hide:YES afterDelay:1.0f];
    }];
}
#pragma mark table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mydata.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenifier = @"cell";
    ArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (!cell) {
        cell = [[ArticleListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
    }
    
    ArticleList *articleList = [[ArticleList alloc]init];
    NSDictionary *dic = [_mydata objectAtIndex:indexPath.row];
    [articleList setData:dic];
    
    cell.myTitltLab.text = articleList.title;
    cell.myDateLab.text = articleList.date;
    cell.myOtherLab.text = [NSString stringWithFormat:@"阅读:(%@) 评论(%@)",articleList.views,articleList.commentcount];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ArticleList *articleList = [[ArticleList alloc]init];
    NSDictionary *dic = [_mydata objectAtIndex:indexPath.row];
    [articleList setData:dic];
    ContentViewController *content = [[ContentViewController alloc]init];
    content.articleList = articleList;
    
    
    CATransition *transtion = [CATransition animation];//创建动画对象
    transtion.duration = 1;//持续时间
    transtion.type = @"rippleEffect";
    [self.navigationController.view.layer addAnimation:transtion forKey:@"animation"];
    [self.navigationController pushViewController:content animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
