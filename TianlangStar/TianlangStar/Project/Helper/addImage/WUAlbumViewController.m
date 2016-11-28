//
//  WUAlbumViewController.m
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUAlbumViewController.h"
#import <Photos/Photos.h>
#import "WUPreviewViewController.h"
#import "WUAlbumAsset.h"

@interface WUImageCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *selectedImageView;

@end

@implementation WUImageCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {

    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self.contentView addSubview:_imageView];
    
    _selectedImageView = [[UIImageView alloc] init];
    _selectedImageView.contentMode = UIViewContentModeCenter;
    _selectedImageView.hidden = YES;
    _selectedImageView.image = [[WUAlbum getImageInBundle:@"checked.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.contentView addSubview:_selectedImageView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.selectedImageView.frame = CGRectMake(CGRectGetWidth(self.frame) - 25, 5, 20, 20);
}

-(void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.selectedImageView.hidden = !selected;
}

@end




NSString *const WUAlbumViewCellIdentifier = @"WUAlbumViewCellIdentifier";
@interface WUAlbumViewController()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray<PHAsset*> *dataArray;
//@property(nonatomic,strong) NSMutableArray<UIImage*> *imageArray;

@property(nonatomic,strong) UIToolbar *toolbar;
@property(nonatomic,strong) UIBarButtonItem *previewBarButtonItem;
@property(nonatomic,strong) UIBarButtonItem *finishBarButtonItem;

//@property(nonatomic,assign) CGFloat progressValue;


@end

@implementation WUAlbumViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}

-(void)initializeComponent {

    self.view.backgroundColor= [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
//    _imageArray = [NSMutableArray array];

    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBarButtonTouch:)];
    self.navigationItem.rightBarButtonItem = cancelBarButton;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat itemWidth = (CGRectGetWidth(self.view.frame) - 15.0 - 10.0) / 4.0;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(self.view.frame) - 10, CGRectGetHeight(self.view.frame)) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.bounces = true;
    self.collectionView.scrollEnabled = true;
    self.collectionView.alwaysBounceVertical = true;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.collectionView registerClass:[WUImageCell class] forCellWithReuseIdentifier:WUAlbumViewCellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 49, CGRectGetWidth(self.view.frame), 49)];
    self.toolbar.barStyle = UIBarStyleDefault;
    self.toolbar.translucent = YES;
    
    self.previewBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(previewBarButtonItemTouch:)];
    self.previewBarButtonItem.enabled = NO;
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.finishBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishBarButtonItemTouch:)];
    self.finishBarButtonItem.enabled = NO;
    
    self.toolbar.items = @[_previewBarButtonItem,flex,_finishBarButtonItem];
    [self.view addSubview:self.toolbar];
    
    [self loadAlbumAsset];
}

-(void)cancelBarButtonTouch:(UIBarButtonItem *) sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//预览
-(void)previewBarButtonItemTouch:(UIBarButtonItem *) sneder {
    WUPreviewViewController *previewController = [[WUPreviewViewController alloc] init];
    previewController.dataArray = [self getSelectedItems];
    [self.navigationController pushViewController:previewController animated:YES];
}

//完成选择
-(void)finishBarButtonItemTouch:(UIBarButtonItem *) sender {
    if(self.delegate) {
        NSArray<NSIndexPath *> *items = [_collectionView indexPathsForSelectedItems];
//        NSMutableArray<UIImage*> *images = [NSMutableArray array];
//        for (NSIndexPath *indexPath in items) {
//            PHAsset *asset = _dataArray[indexPath.row];
//            PHImageManager *manager = [PHImageManager defaultManager];
//            PHImageRequestOptions *opt = [[PHImageRequestOptions alloc] init];
//            opt.synchronous = YES;
//            [manager requestImageDataForAsset:asset options:opt resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//                UIImage *image = [UIImage imageWithData:imageData];
//                [images addObject:image];
//            }];
//        }
        
//        [self.delegate albumFinishedSelected:images];
        
        NSMutableArray<WUAlbumAsset*> *assets = [NSMutableArray array];
        for (NSIndexPath *indexPath in items) {
            PHAsset *asset = _dataArray[indexPath.row];
            WUAlbumAsset *at = [[WUAlbumAsset alloc] initWithAsset:asset];
            [assets addObject:at];
        }
        
        [self.delegate albumFinishedSelected:[NSArray arrayWithArray:assets]];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

//加载图片
-(void)loadAlbumAsset {
    if(self.assetCollection == nil) {
        return;
    }
    
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//    self.progressValue = 0;
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        __strong typeof(weakSelf) strongSelf = self;
        
        PHFetchOptions *options = [[PHFetchOptions alloc] init];
        options.sortDescriptors = @[[[NSSortDescriptor alloc] initWithKey:@"creationDate" ascending:NO]];
        PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:strongSelf.assetCollection options:options];
        if(!result || result.count == 0) {
            return;
        }
        
//        PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
//        requestOptions.synchronous = YES;
//        CGFloat width = ((CGRectGetWidth(self.view.frame) - 15 - 10) / 4) * 2;
//        CGSize size = CGSizeMake(width, width);
        
//        CGFloat baseMin = 1.0 / (CGFloat)result.count;
//        if(baseMin < 0.01) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [strongSelf increaseProgress];
//            });
//        }
        
        for (int i = 0; i < result.count; i++) {
//            strongSelf.progressValue = baseMin * (CGFloat)(i + 1);
            PHAsset *asset = result[i];
//            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                if(result) {
//                    [self.imageArray addObject:result];
//                } else {
//                    [self.imageArray addObject:[[UIImage alloc] init]];
//                }
//            }];
            
            [strongSelf.dataArray addObject:asset];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.collectionView reloadData];
        });
    });
}

//-(void)increaseProgress {
//    [SVProgressHUD showProgress:self.progressValue status:@"请稍后..."];
//    if(self.progressValue >= 1) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
//            [SVProgressHUD dismiss];
//        });
//    } else {
//        [self performSelector:@selector(increaseProgress) withObject:nil afterDelay:0.3];
//    }
//}

#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WUImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WUAlbumViewCellIdentifier forIndexPath:indexPath];
    PHAsset *asset = _dataArray[indexPath.row];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    CGSize size = CGSizeMake(CGRectGetWidth(cell.bounds) * 2, CGRectGetHeight(cell.bounds) * 2);
    
    __weak typeof(cell) weakCell = cell;
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        __strong typeof(weakCell) strongCell = weakCell;
        strongCell.imageView.image = result;
    }];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSIndexPath*> *selecteds = [collectionView indexPathsForSelectedItems];
    if(_maxSelectCount > 0 && selecteds && selecteds.count > _maxSelectCount) {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
    
    selecteds = [collectionView indexPathsForSelectedItems];
    
    if(selecteds && selecteds.count > 0) {
        _previewBarButtonItem.enabled = YES;
        _finishBarButtonItem.enabled = YES;
        [self refreshFinishBarItemTitle:selecteds.count];
    } else {
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSIndexPath*> *selecteds = [collectionView indexPathsForSelectedItems];
    if(selecteds && selecteds.count > 0) {
        [self refreshFinishBarItemTitle:selecteds.count];
    } else {
        _previewBarButtonItem.enabled = NO;
        _finishBarButtonItem.enabled = NO;
        [self refreshFinishBarItemTitle:0];
    }
}

-(void)refreshFinishBarItemTitle:(NSInteger)number {
    NSString *title = @"完成";
    if(number > 0) {
        title = [NSString stringWithFormat:@"%@(%ld)",title,(long)number];
    }
    _finishBarButtonItem.title = title;
}

-(NSArray<PHAsset*> *)getSelectedItems {
    NSArray<NSIndexPath*> *selecteds = [_collectionView indexPathsForSelectedItems];
    NSMutableArray<PHAsset*> *array = [NSMutableArray array];
    if(selecteds && selecteds.count > 0) {
        for (NSIndexPath *indexPath in selecteds) {
            [array addObject:_dataArray[indexPath.row]];
        }
    }
    
    return array;
}

@end
