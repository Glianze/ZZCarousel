//
//  ExampleViewController2.m
//  ZZCarousel
//
//  Created by Liu on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ExampleViewController2.h"
#import "ZZCarouselControl.h"
#import "UIImageView+WebCache.h"
#import "EXampleCell2.h"

@interface ExampleViewController2()<ZZCarouselDelegate>

@property (strong, nonatomic) NSArray *array;

@end

@implementation ExampleViewController2
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _array = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];
    
    
    ZZCarouselControl *carouselView = [[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
    carouselView.cellClass = [EXampleCell2 class];
    
    carouselView.carouselData = _array;

    carouselView.delegate = self;
    carouselView.autoScrollTimeInterval = 2.0f;
    [self.view addSubview:carouselView];
    
    [carouselView carouselDidSelectIndexBlock:^(NSInteger index) {
        NSLog(@"%lu",index);
    }];
}

- (void)carouselForItemCell:(id)cell carouselIndexItem:(id)item
{
    EXampleCell2 *dataCell = cell;
    [dataCell loadCarouselData:item];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
