//
//  ViewController.m
//  ZZCarousel
//
//  Created by Yuan on 16/2/3.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ViewController.h"
#import "ZZCarouselControl.h"
#import "ExampleViewController1.h"
#import "ExampleViewController2.h"
#import "ExampleViewController3.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *array;

@end

@implementation ViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"ZZCarousel";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _array = @[@"Example1 : 本地图片数据轮播",@"Example2 : 网络图片数据轮播",@"Example3 : Json接口数据解析图片轮播"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        ExampleViewController1 *example1 = [[ExampleViewController1 alloc]init];
        [self.navigationController pushViewController:example1 animated:YES];
    }else if (indexPath.row == 1){
        ExampleViewController2 *example2 = [[ExampleViewController2 alloc]init];
        [self.navigationController pushViewController:example2 animated:YES];
    }else if (indexPath.row == 2){
        ExampleViewController3 *example3 = [[ExampleViewController3 alloc]init];
        [self.navigationController pushViewController:example3 animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
