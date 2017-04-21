//
//  ExampleViewController3.m
//  ZZCarousel
//
//  Created by Liu on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ExampleViewController3.h"
#import "ZZCarouselControl.h"
#import "NetRequest.h"
#import "UIImageView+WebCache.h"
#import "EXampleCell3.h"

@interface ExampleViewController3()<ZZCarouselDelegate>

@property (strong, nonatomic) NSMutableArray *array;

@end


@implementation ExampleViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    ZZCarouselControl *carouselView = [[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    carouselView.cellClass = [EXampleCell3 class];
    
    carouselView.autoScrollTimeInterval = 2.0f;

    carouselView.delegate = self;
    [self.view addSubview:carouselView];
    
    _array = [NSMutableArray array];
    
    NSDictionary *param = @{
                            @"num":@"7",
                            };
    
    
    [NetRequest GETRequest:@"http://migicz.cc/carousel.php" WithParams:param WithSuccess:^(id responseObject){

        NSArray *array = (NSArray *)responseObject;
        NSLog(@"%@",array);
    
        [_array addObjectsFromArray:array];
        
        carouselView.carouselData = _array;
        /*
         *   必须实现下面重载数据方法
         */

    
    } WithFail:^(NSError *error){
        NSLog(@"%@",error);
    
    
    } WithNetState:^(){
    
    }];
    
    
    
}

- (void)carouselForItemCell:(id)cell carouselIndexItem:(id)item
{
    EXampleCell3 *dataCell = cell;
    [dataCell loadCarouselData:item];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
