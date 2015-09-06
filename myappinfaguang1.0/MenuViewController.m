//
//  MenuViewController.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/26.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "MenuViewController.h"

#import "MyTools.h"
@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *mytable;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewCreat];
    // Do any additional setup after loading the view.
}
- (void)viewCreat{
    self.view.backgroundColor = UIColorFromRGB(MYCOLOR);
    
    
    
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 16.f;
    _mytable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mytable.translatesAutoresizingMaskIntoConstraints = NO;
    _mytable.delegate = self;
    _mytable.dataSource = self;
    _mytable.showsHorizontalScrollIndicator = NO;
    _mytable.showsVerticalScrollIndicator = NO;
    _mytable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mytable];
    NSArray *_mytableH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mytable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mytable)];
    NSArray *_mytableV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_mytable]-50-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mytable)];
    [self.view addConstraints:_mytableH];
    [self.view addConstraints:_mytableV];
    
    
    [self addDismissButton];
}
- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[dismissButton]-0-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_mytable,dismissButton)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[_mytable]-0-[dismissButton]-0-|"
                               options:0
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_mytable,dismissButton)]];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mydata.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idenifier = @"CategoryTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenifier];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    }
    

    NSDictionary *dic = [_mydata objectAtIndex:indexPath.row];
    
    CategoryList *category = [[CategoryList alloc]init];
    [category setData:dic];
    cell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",category.name,category.articlecount];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.textColor = UIColorFromRGB(MYCOLOR);
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = [_mydata objectAtIndex:indexPath.row];
    CategoryList *category = [[CategoryList alloc]init];
    [category setData:dic];
    [_mydelegate sendCategory:category];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
