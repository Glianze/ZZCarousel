# ZZCarousel

### 轮播器优势：

* 可以自定义Cell
* 支持SDWebImage
* 支持cocoapods
* 基于UICollectionView，完美轮播器
* 点击轮播器delegte，block

### 属性说明

``` objective-c
// 自动滚动间隔时间
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
// 数据源
@property (nonatomic, strong) NSArray *carouselData;
// 占位背景图
@property (nonatomic, strong) UIImage *placeholderImage;
// UIPageControl 颜色
@property (nonatomic, strong) UIColor *defaultPageColor;
// UIPageControl 颜色
@property (nonatomic, strong) UIColor *currentPageColor;
// UIPageControl 对齐方式 ， 枚举类型
@property (nonatomic, assign) ZZCarouselPageAlignment pageAlignment;
// 滚动方向
@property (nonatomic, assign) ZZCarouselScrollDirection scrollDirection;
// 设置轮播器自定义Cell
@property (nonatomic, strong) Class cellClass;
```

### 使用方法

```  objective-c
// 初始化
ZZCarouselControl *carouselView = [[ZZCarouselControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3)];
// 指定UIPageControl对齐方式
carouselView.pageAlignment = ZZCarouselPageAlignmentRight;
// 如下为必须实现项。 传递轮播器数据源， 注册自定义Cell
carouselView.carouselData = _array;
carouselView.cellClass = [EXampleCell1 class];
carouselView.autoScrollTimeInterval = 2.0f;
carouselView.placeholderImage = [UIImage imageNamed:@"placeholder"];
// 注意实现<ZZCarouselDelegate>协议方法
carouselView.delegate = self;
[self.view addSubview:carouselView];

// 如下代理方法为必须实现方法
- (void)carouselForItemCell:(id)cell carouselIndexItem:(id)item
{
    EXampleCell1 *dataCell = cell;
    [dataCell loadCarouselData:item];
}
```

### 安装方法

* 手动安装：拖拽ZZCarousel文件夹到工程内即可
* 自动安装：pod 'ZZCarousel', '~> 1.0.1'



