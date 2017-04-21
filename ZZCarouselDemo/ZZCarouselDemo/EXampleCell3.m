//
//  EXampleCell3.m
//  ZZCarousel
//
//  Created by 袁亮 on 2017/4/14.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "EXampleCell3.h"
#import "UIImageView+WebCache.h"

@implementation EXampleCell3

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self makeCoreCell:frame];
        
    }
    return self;
}

- (void)makeCoreCell:(CGRect)frame
{
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.borderWidth = 0;
    _imageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_imageView];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:label];
}

- (void)loadCarouselData:(id)data
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:[(NSDictionary *)data objectForKey:@"image"]]];
}

@end
