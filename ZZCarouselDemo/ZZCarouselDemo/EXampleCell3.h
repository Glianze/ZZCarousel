//
//  EXampleCell3.h
//  ZZCarousel
//
//  Created by 袁亮 on 2017/4/14.
//  Copyright © 2017年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXampleCell3 : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *address_label;

- (void)loadCarouselData:(id)data;

@end
