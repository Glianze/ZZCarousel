//
//  EXampleCell2.m
//  ZZCarousel
//
//  Created by 袁亮 on 2017/4/14.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import "EXampleCell2.h"
#import "UIImageView+WebCache.h"

@implementation EXampleCell2

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
}

- (void)loadCarouselData:(id)data
{
    if ([(NSString *)data isKindOfClass:[NSString class]]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)data]];
    }else if ([(UIImage *)data isKindOfClass:[UIImage class]]){
        _imageView.image = (UIImage *)data;
    }else if ([(NSDictionary *)data isKindOfClass:[NSDictionary class]]){
        [_imageView sd_setImageWithURL:[NSURL URLWithString:[(NSDictionary *)data objectForKey:@"picUrl"]]];
    }
}

@end
