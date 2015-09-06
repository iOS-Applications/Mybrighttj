//
//  ContentViewController.m
//  myappinfaguang1.0
//
//  Created by XuLee on 15/8/25.
//  Copyright (c) 2015年 XuLee. All rights reserved.
//

#import "ContentViewController.h"

#import "MyTools.h"

#import "ArticleById.h"

#import "GTMBase64.h"

#import "CommentViewController.h"

#import "CoreFMDB.h"

#import <POP.h>
@interface ContentViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
{
    AFHTTPRequestOperationManager *manager;
    MBProgressHUD *HUD;
    UIButton *topBtn;
}
@property (nonatomic,strong)NSDictionary *mydic;
@property (nonatomic,strong)ArticleById *articleById;

@property (nonatomic,strong)UIWebView *myWebView;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self viewCreat];
    
    [self registerWatch];
    // Do any additional setup after loading the view.
}
- (void)viewCreat{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    
    
    
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"heart"] style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    [bar1 setTintColor:[UIColor whiteColor]];
    UIBarButtonItem *bar2 = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"comment"] style:UIBarButtonItemStylePlain target:self action:@selector(lookComment)];
    [bar2 setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItems = @[bar2,bar1];
    
    
    
    _myWebView = [[UIWebView alloc]init];
    _myWebView.translatesAutoresizingMaskIntoConstraints = NO;
    _myWebView.delegate = self;
    [self.view addSubview:_myWebView];
    NSArray *_myWebViewH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_myWebView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myWebView)];
    NSArray *_myWebViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_myWebView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_myWebView)];
    [self.view addConstraints:_myWebViewH];
    [self.view addConstraints:_myWebViewV];
    
    
    _myWebView.scrollView.backgroundColor = [UIColor whiteColor];

    
    manager = [AFHTTPRequestOperationManager manager];
    
    
    BOOL flag = HaveNetWork;
    if (flag) {
        NSDictionary *parameters = @{@"articleId":_articleList.articleList_id};
        [manager POST:Url_articleById parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            _articleById = [[ArticleById alloc]init];
            _mydic = [[responseObject objectForKey:@"data"] objectForKey:@"articleInfo"];
            [_articleById setData:_mydic];
            NSString *beforeTitle = [NSString stringWithFormat:@"<h1><span style=\"color: #1E90FF;\">%@</span></h1><br><span style=\"color: #808080;\">发表时间:%@</span><br><span style=\"color: #808080;\">点击量:%@</span><br><span style=\"color: #808080;\">作者:%@</span></br><br></br>",_articleById.title,_articleById.date,_articleById.views,_articleById.authorname];
            // 解码
            NSData *data = [GTMBase64 decodeString:[_mydic objectForKey:@"content"]];
            // 使用UTF8编码方式初始化数据库
            _articleById.content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            [_myWebView loadHTMLString:[NSString stringWithFormat:@"%@%@",beforeTitle,_articleById.content] baseURL:nil];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            [self.view makeToast:@"出错了呢" duration:1.0f position:CSToastPositionCenter];
        }];
    }else{
        [self.view makeToast:@"网络未连接" duration:1.0f position:CSToastPositionCenter];
    }
    
    
    
    

    topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    topBtn.translatesAutoresizingMaskIntoConstraints = NO;
    UIImage *topImage = [[UIImage imageNamed:@"top"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [topBtn setBackgroundImage:topImage forState:UIControlStateNormal];
    [topBtn addTarget:self action:@selector(toTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topBtn];
    NSArray *topH = [NSLayoutConstraint
                     constraintsWithVisualFormat:@"H:[topBtn(==50)]-0-|"
                     options:0
                     metrics:nil
                     views:NSDictionaryOfVariableBindings(topBtn)];
    NSArray *topV = [NSLayoutConstraint
                     constraintsWithVisualFormat:@"V:[topBtn(==50)]-0-|"
                     options:0
                     metrics:nil
                     views:NSDictionaryOfVariableBindings(topBtn)];
    [self.view addConstraints:topH];
    [self.view addConstraints:topV];

}
- (void)toTop{
    [_myWebView.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
- (void)save{


    //创建表
    BOOL res =  [CoreFMDB executeUpdate:@"create table if not exists save(id integer primary key autoIncrement, articleById_id text, title text , date text , views text , commentcount text);"];
    if(res){
        NSLog(@"创表执行成功");
        
        NSInteger count = [CoreFMDB countTable:[NSString stringWithFormat:@"save where articleById_id = '%@';",_articleById.articleById_id]];
        NSLog(@"----->>>%zi",count);
        if (count == 0) {
            //添加数据
            BOOL res2= [CoreFMDB executeUpdate:[NSString stringWithFormat:@"insert into save (articleById_id,title,commentcount,views,date) values('%@','%@','%@','%@','%@');",_articleById.articleById_id,_articleById.title,_articleById.commentcount,_articleById.views,_articleById.date]];
            
            if(res2){
                NSLog(@"添加数据成功");
                [self.view makeToast:@"收藏成功" duration:1.0f position:CSToastPositionCenter];
            }else{
                [self.view makeToast:@"收藏失败" duration:1.0f position:CSToastPositionCenter];
            }
        }else{
            [self.view makeToast:@"您已经添加收藏了" duration:1.0f position:CSToastPositionCenter];
        }
        
        
        
    }else{
        NSLog(@"创表执行失败");
    }
    
    
   
}

- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)lookComment{
    CommentViewController *comment = [[CommentViewController alloc]init];
    comment.commentArr = _articleById.comments;
    [self.navigationController pushViewController:comment animated:YES];
}
#pragma mark - UIWebView
- (void)webViewDidStartLoad:(UIWebView *)webView{
    HUD = [[MBProgressHUD alloc]initWithView:self.view];
    
    [HUD show:YES];
    
    [self.view addSubview:HUD];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    HUD.customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"no"]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.labelText = @"加载失败";
    
    [HUD hide:YES afterDelay:1.0f];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [HUD hide:YES];
    
    NSString *js = [NSString stringWithFormat:@"var script = document.createElement('script');"
                    "script.type = 'text/javascript';"
                    "script.text = \"function ResizeImages() { "
                    "var myimg,oldwidth,oldheight;"
                    "var maxwidth=%lf;" // 图片宽度
                    "for(i=0;i <document.images.length;i++){"
                    "myimg = document.images[i];"
                    "if(myimg.width > maxwidth){"
                    "oldheight = myimg.height;"
                    "oldwidth = myimg.width;"
                    "myimg.width = maxwidth * 0.9;"
                    "myimg.height = oldheight * (maxwidth/oldwidth) * 0.9;"
                    "}"
                    "}"
                    "}\";"
                    "document.getElementsByTagName('head')[0].appendChild(script);", WIDTH];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
 
}


-(void)registerWatch{
    //第一个参数：被观察的对象，第二个参数：观察者的对象，第三个参数：被观察的对象的属性或者变量名，第四个参数：接收到变化的通知时，给我们展示的内容
    [_myWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    CGFloat y = [object contentOffset].y;
    
    if (y>HEIGHT) {
        [self hiddenBar];
    }else{
        [self showBar];
    }

}
-(void)showBar{
    topBtn.hidden = YES;
    self.navigationController.navigationBarHidden = NO;
}
-(void)hiddenBar{
    topBtn.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
}
-(void)dealloc{
    //移除kvo
    [_myWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
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
