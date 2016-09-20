//
//  LYLRotateImage.m
//  RotateImage
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LYLRotateImage.h"
#import "LYLRotateImageCell.h"

#define COLLECTION_CELL @"RotateCell"

@interface LYLRotateImage ()<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


@end


@implementation LYLRotateImage

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviewsWithFrame:frame];
    }
    return self;
}

- (void)addSubviewsWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.clipsToBounds = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[LYLRotateImageCell class] forCellWithReuseIdentifier:COLLECTION_CELL];
    
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height-30, self.frame.size.width/2, 30)];
    self.pageControl.backgroundColor = [UIColor redColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPage = 0;
    self.pageControl.userInteractionEnabled = NO;
    [self addSubview:self.pageControl];
    
}


- (void)setSourceArray:(NSMutableArray *)sourceArray{
    _sourceArray = sourceArray;
    self.pageControl.numberOfPages = _sourceArray.count;
    if (self.sourceArray.count != 1) {
        [self setUpTimer];
    } else {
        self.collectionView.scrollEnabled = NO;
    }
    [self.collectionView reloadData];
}

#pragma mark 添加定时器
- (void)setUpTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clickOnTimer) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)clickOnTimer{
    if (self.sourceArray.count == 0) return;
    int currentIndex = _collectionView.contentOffset.x / _collectionView.frame.size.width;
//    NSLog(@"_totalItemsCount = %f   targetIndex = %f  currentIndex = %d", _collectionView.contentOffset.x, _collectionView.frame.size.width, currentIndex);
    int targetIndex = currentIndex + 1;
    if (targetIndex == self.sourceArray.count) {
        targetIndex = 0;
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}




#pragma mark UICollectionViewFlowLayout  Delegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.sourceArray.count+2;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LYLRotateImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:COLLECTION_CELL forIndexPath:indexPath];
    if ([[self.sourceArray firstObject] isKindOfClass:[NSString class]]) {
//        NSLog(@"数组里面是字符串");
    } else if ([[self.sourceArray firstObject] isKindOfClass:[UIImage class]]) {
//        NSLog(@"数租里面存放的是UIImage");
        cell.rotateImage.image = self.sourceArray[indexPath.row];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectItemAtItem:)]) {
        [_delegate didSelectItemAtItem:indexPath.row];
    }
}

#pragma mark UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int itemIndex = (scrollView.contentOffset.x + self.collectionView.frame.size.width*0.5) / self.collectionView.frame.size.width;
    if (!self.sourceArray.count) return; // 解决清除timer时偶尔出现的问题
    int indexCurrentPage = itemIndex % self.sourceArray.count;
    self.pageControl.currentPage = indexCurrentPage;
    NSLog(@"scroller  = %f", scrollView.contentOffset.x);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"拖拽  = %f", scrollView.contentOffset.x);
    [_timer invalidate]; // 关闭定时器  fire(启动)
    _timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"拖拽完成,开始减速!");
    [self setUpTimer];
}




#pragma mark 解决当父View释放时,当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [_timer invalidate];
        _timer = nil;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
