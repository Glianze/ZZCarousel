//
//  ZZCarouselControl.h
//  ZZCarousel
//
//  Created by Yuan on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 The ZZCarouselControl protocol
 */
@protocol ZZCarouselDelegate <NSObject>

@required

- (void)carouselForItemCell:(id)cell carouselIndexItem:(id)item;

@optional
- (void)didSelectCarouselItemAtIndex:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, ZZCarouselPageAlignment) {
    ZZCarouselPageAlignmentLeft = 0,
    ZZCarouselPageAlignmentRight,
    ZZCarouselPageAlignmentCenter,
};

typedef NS_ENUM(NSInteger, ZZCarouselScrollDirection) {
    ZZCarouselScrollDirectionLeft = 0,
    ZZCarouselScrollDirectionRight,
};

/**
 The ZZCarouselControl core class.
 Using UICollectionView realized the real infinite carousel.
 */

@interface ZZCarouselControl : UIView

@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

@property (nonatomic, strong) NSArray *carouselData;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) UIColor *defaultPageColor;

@property (nonatomic, strong) UIColor *currentPageColor;

@property (nonatomic, assign) ZZCarouselPageAlignment pageAlignment;

@property (nonatomic, assign) ZZCarouselScrollDirection scrollDirection;

@property (nonatomic, strong) Class cellClass;

@property (nonatomic,   weak) id<ZZCarouselDelegate> delegate;

- (void)carouselDidSelectIndexBlock:(void(^)(NSInteger index))carouselBlock;

@end

