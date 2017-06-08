//
//  ZZCarouselControl.m
//  ZZCarousel
//
//  Created by Yuan on 16/2/15.
//  Copyright © 2016年 Ace. All rights reserved.
//

#import "ZZCarouselControl.h"

#define THIS_WIDTH self.frame.size.width
#define THIS_HEIGHT self.frame.size.height

@interface ZZCarouselControl()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *coreView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic,   copy) void(^carouselBlock)(NSInteger index);
@end

@implementation ZZCarouselControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self makeCoreUI:frame];
        [self makePageUI:frame];
        
    }
    return self;
}

- (void)instance
{
    _autoScrollTimeInterval = 0;
    _scrollDirection = ZZCarouselScrollDirectionLeft;
}

- (void) makeCoreUI:(CGRect)frame
{
    _backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, THIS_WIDTH, THIS_HEIGHT)];
    _backgroundView.layer.masksToBounds = YES;
    _backgroundView.layer.borderWidth = 0;
    _backgroundView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_backgroundView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(THIS_WIDTH, THIS_HEIGHT);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    self.coreView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, THIS_WIDTH, THIS_HEIGHT) collectionViewLayout:flowLayout];
    self.coreView.showsHorizontalScrollIndicator = NO;
    self.coreView.dataSource = self;
    self.coreView.delegate = self;
    self.coreView.backgroundColor = [UIColor clearColor];
    self.coreView.pagingEnabled = YES;
    self.coreView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    [self addSubview:self.coreView];
}

- (void) makePageUI:(CGRect)frame
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, THIS_HEIGHT - 20, THIS_WIDTH, 20)];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
}

- (void)setCarouselData:(NSArray *)carouselData
{
    _carouselData = [self remakeCarouselData:carouselData];
    
    [self setPageControlNumber:_carouselData.count - 2];
    
    [self settingPageAlignment];
    
    [self.coreView reloadData];
}

- (NSArray *)remakeCarouselData:(NSArray *)data
{
    NSArray *carousel_data = data;
    NSMutableArray *remake_data = [NSMutableArray array];
    [remake_data removeAllObjects];
    id firstImage = carousel_data.firstObject;
    id lastImage = carousel_data.lastObject;
    [remake_data addObject:lastImage];
    for (id item in carousel_data) {
        [remake_data addObject:item];
    }
    [remake_data addObject:firstImage];
    return [remake_data copy];
}

- (void)setCellClass:(Class)cellClass
{
    _cellClass = cellClass;
    [self.coreView registerClass:_cellClass forCellWithReuseIdentifier:NSStringFromClass(_cellClass)];
}

- (void)setPageControlNumber:(NSInteger)page
{
    self.pageControl.numberOfPages = page;
}

- (void)setPageAlignment:(ZZCarouselPageAlignment)pageAlignment
{
    _pageAlignment = pageAlignment;
    
    [self settingPageAlignment];
}

- (void)setScrollDirection:(ZZCarouselScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
}

- (void)settingPageAlignment
{
    CGSize pointSize = [_pageControl sizeForNumberOfPages:_carouselData.count];
    
    CGFloat page_x = 0.f;
    
    if (_pageAlignment == ZZCarouselPageAlignmentLeft) {
        page_x = (_pageControl.bounds.size.width - pointSize.width) / 2 ;
    }else if (_pageAlignment == ZZCarouselPageAlignmentRight){
        page_x = -(_pageControl.bounds.size.width - pointSize.width) / 2 ;
    }else if (_pageAlignment == ZZCarouselPageAlignmentCenter){
        page_x = 0.f;
    }
    
    [_pageControl setBounds:CGRectMake(page_x, _pageControl.bounds.origin.y, _pageControl.bounds.size.width, _pageControl.bounds.size.height)];
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self createTimer];
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if (placeholderImage != nil) {
        self.backgroundView.image = placeholderImage;
    }
}

#pragma mark ```create timer start scroll```
- (void)createTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(autoCarouselScroll) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)autoCarouselScroll
{
    CGFloat offsetX = 0.f;
    NSInteger result = (NSInteger)self.coreView.contentOffset.x % (NSInteger)THIS_WIDTH;
    NSInteger positionNum = (NSInteger)self.coreView.contentOffset.x / (NSInteger)THIS_WIDTH;
    if (result != 0) {
        offsetX = THIS_WIDTH * positionNum + THIS_WIDTH;
    } else {
        if (_scrollDirection == ZZCarouselScrollDirectionLeft) {
            offsetX = self.coreView.contentOffset.x + THIS_WIDTH;
        } else if (_scrollDirection == ZZCarouselScrollDirectionRight) {
            offsetX = self.coreView.contentOffset.x - THIS_WIDTH;
        }
    }
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.coreView setContentOffset:offset animated:YES];
}

#pragma mark ```collectionview datasource and delegate```
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _carouselData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [_cellClass new];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(_cellClass) forIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:@selector(carouselForItemCell:carouselIndexItem:)]) {
        [self.delegate carouselForItemCell:cell carouselIndexItem:_carouselData[indexPath.row]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row - 1;
    if ([self.delegate respondsToSelector:@selector(didSelectCarouselItemAtIndex:)]) {
        [self.delegate didSelectCarouselItemAtIndex:index];
    }
    
    if (self.carouselBlock) {
        self.carouselBlock(index);
    }
}

- (void)carouselDidSelectIndexBlock:(void (^)(NSInteger))carouselBlock
{
    self.carouselBlock = carouselBlock;
}

#pragma mark ```scrollview core delegate```
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x / THIS_WIDTH - 1;
    self.pageControl.currentPage = page;
    if (scrollView.contentOffset.x > THIS_WIDTH * (_carouselData.count - 2)) {
        self.pageControl.currentPage = 0;
    } else if (self.coreView.contentOffset.x < 0) {
        self.pageControl.currentPage = _carouselData.count - 3;
    }
    
    if (scrollView.contentOffset.x <= 0) {
        scrollView.contentOffset = CGPointMake(THIS_WIDTH * (_carouselData.count - 2), 0);
    } else if (scrollView.contentOffset.x >= THIS_WIDTH * (_carouselData.count - 1)) {
        scrollView.contentOffset = CGPointMake(THIS_WIDTH, 0);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_autoScrollTimeInterval != 0){
        [self createTimer];
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [_timer invalidate];
    }
}

- (void)dealloc
{
    _timer = nil;
}

@end
