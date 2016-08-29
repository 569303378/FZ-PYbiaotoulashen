//
//  RootViewController.m
//  PYbiaotoulashen
//
//  Created by Apple on 16/7/28.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "RootViewController.h"
#import "UIBarButtonItem+UIBarButtonItem.h"
@interface RootViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self PYView];

    // 导航栏左边的内容
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"fanhui.png" highImage:@"11" target:self action:@selector(fanhuiItem)];
    self.navigationItem.leftBarButtonItem = moonItem;
    self.myTableView.showsVerticalScrollIndicator = NO;//滚动条
}
#pragma mark ======== 导航栏左边的内容
- (void)fanhuiItem {
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma mark ======== 加载视图
- (void)PYView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, self.view.frame.size.width, self.view.frame.size.height + 64)];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.imageView.image = [UIImage imageNamed:@"3.jpg"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.myTableView.tableHeaderView = view;
    [self.myTableView addSubview:self.imageView];
    [self.view addSubview:_myTableView];
}

#pragma mark ======== tad代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"11";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据偏移量改变导航条的透明度
    CGFloat yOffset = scrollView.contentOffset.y;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    CGFloat alpha = scrollView.contentOffset.y / 72 > 1 ? 1:(scrollView.contentOffset.y + 28) / 100;
    [self.navigationController.navigationBar setBackgroundImage:[self getImageWithAlpha:alpha] forBarMetrics:(UIBarMetricsDefault)];
    /**
     *  对表头效果拉伸的出来,yOffset 初始状态 ： -200.000000
     */
    NSLog(@"%f", scrollView.contentOffset.y);
    if (yOffset <= -64) {

        CGRect f = self.imageView.frame;
        //下拉的偏移量赋给
        f.origin.y = yOffset;
        //加上下拉的偏移量得到一个新的高度
        f.size.height =  -yOffset + 200;
        //x位置 f.size.height/kImageOriginHight * ScreenWidth 通过高度比例得到宽度的值，然后减去原来宽度，边长的宽度 除以2得到x轴位置
        f.origin.x = -(f.size.height*self.view.frame.size.width/200 -  self.view.frame.size.width)/2;
        ////f.size.height/kImageOriginHight * ScreenWidth 通过高度比例得到宽度的值，
        f.size.width = f.size.height*self.view.frame.size.width/200;
        self.imageView.frame = f;
    }
    //关闭毛玻璃属性
    if (scrollView.contentOffset.y >= 72) {
        self.navigationController.navigationBar.translucent = NO;

    }
    //开启毛玻璃属性
    if(scrollView.contentOffset.y < 72 + 64) {
        self.navigationController.navigationBar.translucent = YES;
    }
    //隐藏黑线
    if (scrollView.contentOffset.y < 72 + 64) {
        UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
        //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
        blackLineImageView.hidden = YES;
        //隐藏导航栏返回按钮
//        self.navigationItem.hidesBackButton = YES;

    } else {
        UIImageView* blackLineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
        //隐藏黑线（在viewWillAppear时隐藏，在viewWillDisappear时显示）
        blackLineImageView.hidden = NO;
//        self.navigationItem.hidesBackButton = NO;

    }
}

#pragma mark ======== 隐藏黑线
-(UIImageView *)findHairlineImageViewUnder:(UIView *)view
{
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0)
    {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


/**
 *  根据透明度去绘制一个图片，也可以省略此处用一个透明的图片，没这个效果好
 */
-(UIImage *)getImageWithAlpha:(CGFloat)alpha{
    
    UIColor *color=[UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    
    CGSize colorSize=CGSizeMake(1, 1);
    
    UIGraphicsBeginImageContext(colorSize);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    
    UIImage *img=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return img;
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
