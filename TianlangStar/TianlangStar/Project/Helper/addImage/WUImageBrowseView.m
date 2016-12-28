//
//  WUImageBrowseView.m
//  kztool
//
//  Created by 武探 on 16/6/24.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUImageBrowseView.h"
#import "WUPreviewViewController.h"
#import "UIImage+Aspect.h"
#import "WUAlbumAsset.h"

#define WUIMAGE_DEFAULT_FRAME CGRectMake(-15, 0, CGRectGetWidth(self.frame) + 30, CGRectGetHeight(self.frame))

NSString *const WUImageBrowseViewCellIdentifier = @"WUImageBrowseViewCellIdentifier";

@interface WUImageBrowseView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WUPreviewImageCellDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIPageControl *pageControl;

@end

@implementation WUImageBrowseView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    self.backgroundColor = [UIColor blackColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:WUIMAGE_DEFAULT_FRAME collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[WUPreviewImageCell class] forCellWithReuseIdentifier:WUImageBrowseViewCellIdentifier];
    [self addSubview:_collectionView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.hidesForSinglePage = YES;
    [self addSubview:_pageControl];
}

-(void)setImages:(NSArray *)images {
    _images = images;
    _pageControl.numberOfPages = images.count;
    [_collectionView reloadData];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = WUIMAGE_DEFAULT_FRAME;
    self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 40, CGRectGetWidth(self.frame), 20);
}

#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(!_images) {
        return 0;
    }
    return _images.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WUPreviewImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WUImageBrowseViewCellIdentifier forIndexPath:indexPath];
    [cell setImageZoom:1];
    cell.delegate = self;
    id imageItem = _images[indexPath.row];
    
    if([imageItem isKindOfClass:[WUAlbumAsset class]]) {
        cell.imageView.image = [imageItem imageWithSize:[[UIScreen mainScreen] bounds].size];
        [cell layout];
    } else if([imageItem isKindOfClass:[UIImage class]]) {
        cell.imageView.image = imageItem;
        [cell layout];
    } else if([imageItem isKindOfClass:[NSString class]]) {
        //url类型，如果使用SDWebImage，请修改这里
        __weak typeof(cell) weakCell = cell;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:imageItem] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error || !data) {
                return;
            }
            UIImage *image = [UIImage imageWithData:data];
            if(weakCell) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    weakCell.imageView.image = image;
                    [weakCell layout];
                });
            }
        }];
        
        [dataTask resume];
    }
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / CGRectGetWidth(scrollView.frame);
    _pageControl.currentPage = page;
}

-(void)show:(UIView*)view startFrame:(CGRect)startFrame foregroundImage:(UIImage*)image {
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor blackColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:startFrame];
    imageView.image = image;
    imageView.clipsToBounds = YES;
    [backView addSubview:imageView];
    
    [view addSubview:backView];
    
    CGRect tf = [image rectAspectFitRectForSize:view.frame.size];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(CGRectGetWidth(self.frame) / 2 - CGRectGetWidth(tf) / 2, CGRectGetHeight(self.frame) / 2 - CGRectGetHeight(tf) / 2, CGRectGetWidth(tf), CGRectGetHeight(tf));
    } completion:^(BOOL finished) {
        [backView removeFromSuperview];
        [view addSubview:self];
        self.pageControl.currentPage = self.currentPage;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }];
}

-(void)show:(UIView*)view {
    [view addSubview:self];
    self.pageControl.currentPage = self.currentPage;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

-(void)previewImageCellDidSelected:(WUPreviewImageCell*)cell {
    if(self.delegate && [self.delegate respondsToSelector:@selector(imageBrowseView:willCloseAtIndex:)]) {
        self.backgroundColor = [UIColor clearColor];
        NSArray<UIView*> *controls = [self subviews];
        for (UIView *view in controls) {
            [view removeFromSuperview];
        }
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = cell.imageView.image;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.frame = cell.imageView.frame;
        [self addSubview:imageView];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        CGRect rect = [self.delegate imageBrowseView:self willCloseAtIndex:indexPath.row];
        if(CGRectEqualToRect(CGRectZero, rect)) {
            [self dissmiss];
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                imageView.frame = rect;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }
    } else {
        [self dissmiss];
    }
}

-(void)dissmiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
