//
//  WUPreviewViewController.m
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUPreviewViewController.h"
#import "UIImage+Aspect.h"
#import <Photos/Photos.h>

@interface WUPreviewImageCell()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *imageScrollView;

@end

@implementation WUPreviewImageCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    _imageScrollView = [[UIScrollView alloc] init];
    _imageScrollView.delegate = self;
    _imageScrollView.bounces = YES;
    _imageScrollView.maximumZoomScale = 2;
    _imageScrollView.minimumZoomScale = 1;
    [self.contentView addSubview:_imageScrollView];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = true;
    [_imageScrollView addSubview:_imageView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [_imageScrollView addGestureRecognizer:singleTap];

    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.numberOfTouchesRequired = 1;
    [_imageView addGestureRecognizer:doubleTap];
    [singleTap requireGestureRecognizerToFail:doubleTap];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    [self layout];
}

-(void)layout {
    _imageScrollView.frame = CGRectMake(15, 0, CGRectGetWidth(self.frame) - 30, CGRectGetHeight(self.frame));
    if(_imageView.image) {
        CGRect rect = [_imageView.image rectAspectFitRectForSize:_imageScrollView.frame.size];
        _imageView.frame = rect;
    } else {
        _imageView.frame = _imageScrollView.bounds;
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.bounds.size.width > scrollView.contentSize.width ? (scrollView.bounds.size.width - scrollView.contentSize.width) / 2 : 0.0;
    CGFloat offsetY = scrollView.bounds.size.height > scrollView.contentSize.height ? (scrollView.bounds.size.height - scrollView.contentSize.height) / 2 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width / 2 + offsetX, scrollView.contentSize.height / 2 + offsetY);
}

-(void)setImageZoom:(CGFloat)scale {
    [_imageScrollView setZoomScale:scale animated:NO];
}

#pragma -mark 点击图片

-(void)singleTap:(UIGestureRecognizer*)sender {
    if(self.delegate && [self.delegate respondsToSelector:@selector(previewImageCellDidSelected:)]) {
        [self.delegate previewImageCellDidSelected:self];
    }
}

-(void)doubleTap:(UIGestureRecognizer*)sender {
    CGFloat scale = _imageScrollView.zoomScale;
    scale = scale < 2.0 ? 2.0 : 1;
    [_imageScrollView setZoomScale:scale animated:YES];
}


@end





NSString *const WUWUPreviewViewCellIdentifier = @"WUWUPreviewViewCellIdentifier";
@interface WUPreviewViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WUPreviewImageCellDelegate>

@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) UICollectionView *collectionView;

@end

@implementation WUPreviewViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)initializeComponent {
    self.title = @"预览";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-15, 0, CGRectGetWidth(self.view.bounds) + 30, CGRectGetHeight(self.view.bounds)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.alwaysBounceVertical = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[WUPreviewImageCell class] forCellWithReuseIdentifier:WUWUPreviewViewCellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 40, CGRectGetWidth(self.view.frame), 20)];
    self.pageControl.numberOfPages = _dataArray.count;
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.hidesForSinglePage = YES;
    [self.view addSubview:self.pageControl];
}

#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    WUPreviewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WUWUPreviewViewCellIdentifier forIndexPath:indexPath];
    [cell setImageZoom:1];
    cell.delegate = self;
    PHAsset *asset = _dataArray[indexPath.row];
    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestImageForAsset:asset targetSize:CGSizeMake(CGRectGetWidth(cell.frame) * 2, CGRectGetHeight(cell.frame)) contentMode:PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.imageView.image = result;
        [cell layout];
    }];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = page;
}

#pragma -mark Preview delegate

-(void)previewImageCellDidSelected:(WUPreviewImageCell *)cell {
    BOOL isHiden = self.navigationController.navigationBarHidden;
    [self.navigationController setNavigationBarHidden:!isHiden animated:YES];
    [self setNeedsStatusBarAppearanceUpdate];
}

-(BOOL)prefersStatusBarHidden {
    return self.navigationController.navigationBarHidden;
}

@end
