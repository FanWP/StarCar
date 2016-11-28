//
//  WUImageCollectionView.m
//  kztool
//
//  Created by 武探 on 16/6/24.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUImageCollectionView.h"
#import "WUAlbum.h"

@class WUImageCollectionViewCell;

@protocol WUImageCollectionViewCellDelegate <NSObject>

@required
-(void)imageCollectionViewCellDelete:(WUImageCollectionViewCell*)cell;

@end

@interface WUImageCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) id<WUImageCollectionViewCellDelegate> delegate;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *deleteImageView;

@end

@implementation WUImageCollectionViewCell

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
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 4;
    [self.contentView addSubview:_imageView];
    
    _deleteImageView = [[UIImageView alloc] init];
    _deleteImageView.contentMode = UIViewContentModeTopRight;
    _deleteImageView.userInteractionEnabled = YES;
    _deleteImageView.image = [WUAlbum getImageInBundle:@"delete.png"];
    [self.contentView addSubview:_deleteImageView];
    
    UITapGestureRecognizer *deleteImageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteImageViewTap:)];
    deleteImageViewTap.numberOfTapsRequired = 1;
    [_deleteImageView addGestureRecognizer:deleteImageViewTap];
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _imageView.frame = CGRectMake(5, 5, CGRectGetWidth(self.frame) - 10, CGRectGetHeight(self.frame) - 10);
    _deleteImageView.frame = CGRectMake(CGRectGetWidth(self.frame) - 30, 0, 30, 30);
}

-(void)deleteImageViewTap:(UIGestureRecognizer*)sender {
    if(self.delegate != nil) {
        [self.delegate imageCollectionViewCellDelete:self];
    }
}

@end





#define WU_COLUMN_COUNT 4;
NSString *const WUImageCollectionViewCellIdentifier = @"WUImageCollectionViewCellIdentifier";

@interface WUImageCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,WUImageCollectionViewCellDelegate,WUAlbumDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,WUImageBrowseViewDelegate>

@property(nonatomic,strong) UIImage *addImage;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray<UIImage*> *dataArray;
@property(nonatomic,strong) NSArray<WUAlbumAsset*> *assetArray;
@property(nonatomic,assign,readonly) CGFloat itemWidth;

@end

@implementation WUImageCollectionView

-(NSInteger)columnCount {
    return 4;
}

-(CGFloat)itemWidth {
    return (CGRectGetWidth(self.frame) - 10) / WU_COLUMN_COUNT;
}

-(instancetype)initWithFrame:(CGRect)frame controller:(__weak UIViewController*)controller {
    self = [super initWithFrame:frame];
    if(self) {
        self.superController = controller;
        [self initialize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {

    _addImage = [WUAlbum getImageInBundle:@"plus.png"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    _dataArray = [NSMutableArray array];
    [self sortDataArray];

    CGRect rect = self.bounds;
    rect.origin.x += 5;
    rect.size.width -= 10;
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[WUImageCollectionViewCell class] forCellWithReuseIdentifier:WUImageCollectionViewCellIdentifier];
    [self addSubview:_collectionView];
    
    if(WU_SYSTEM_VERSION >= 9.0) {
        UILongPressGestureRecognizer *collectionViewLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewLongPress:)];
        [_collectionView addGestureRecognizer:collectionViewLongPress];
    }
    
}

//重排图片
-(void)collectionViewLongPress:(UILongPressGestureRecognizer*)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *selectedIndexPath = [_collectionView indexPathForItemAtPoint:[gesture locationInView:_collectionView]];
            if(selectedIndexPath) {
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
            }
        }
            break;
        case UIGestureRecognizerStateChanged: {
            [_collectionView updateInteractiveMovementTargetPosition:[gesture locationInView:gesture.view]];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [_collectionView endInteractiveMovement];
        }
            break;
        default: {
            [_collectionView cancelInteractiveMovement];
        }
            break;
    }
}

-(void)sortDataArray {
    if([_dataArray containsObject:_addImage]) {
        [_dataArray removeObject:_addImage];
    }
    [_dataArray addObject:_addImage];
}

#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = _dataArray[indexPath.row];
    if([image isEqual:_addImage]) {
        return NO;
    }
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    UIImage *destinationItem = _dataArray[destinationIndexPath.row];
    if([destinationItem isEqual:_addImage]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    } else {
        UIImage *sourceItem = _dataArray[sourceIndexPath.row];
        [self.dataArray removeObject:sourceItem];
        [_dataArray insertObject:sourceItem atIndex:destinationIndexPath.row];
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WUImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:WUImageCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    UIImage *image = _dataArray[indexPath.row];
    cell.imageView.image = image;
    //当前为添加cell
    if([image isEqual:_addImage]) {
        cell.deleteImageView.userInteractionEnabled = NO;
        cell.deleteImageView.hidden = YES;
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.imageView.layer.borderWidth = 1;
        cell.imageView.layer.borderColor = [[UIColor colorWithRed:0.961 green:0.957 blue:0.961 alpha:1] CGColor];
    } else {//图片
        cell.deleteImageView.userInteractionEnabled = YES;
        cell.deleteImageView.hidden = NO;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.layer.borderWidth = 0;
        cell.imageView.layer.borderColor = [[UIColor clearColor] CGColor];
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image = _dataArray[indexPath.row];
    if([image isEqual:_addImage] && self.superController) {
        [WUAlbum showPickerMenu:self.superController delegate:self];
    } else {
        if(self.superController) {
            WUImageBrowseView *imageBrowseView = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            imageBrowseView.delegate = self;
            imageBrowseView.images = [self getSelectedImages];
            imageBrowseView.currentPage = indexPath.row;
            
            WUImageCollectionViewCell *cell = (WUImageCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
            CGRect rect = [_superController.navigationController.view convertRect:cell.frame fromView:cell.superview];
            [imageBrowseView show:_superController.navigationController.view startFrame:rect foregroundImage:cell.imageView.image];
        }
    }
}

-(CGRect)imageBrowseView:(WUImageCollectionView*)view willCloseAtIndex:(NSInteger)index {
    WUImageCollectionViewCell *cell = (WUImageCollectionViewCell*)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    CGRect rect = cell.frame;
    CGRect lastAnimationRect = [_collectionView convertRect:rect toView:_superController.navigationController.view];
    return lastAnimationRect;
}

//相册 完成选择
-(void)albumFinishedSelected:(NSArray<WUAlbumAsset *> *)assets {
    _assetArray = assets;
    CGSize size = CGSizeMake(100, 100);
    NSMutableArray *images = [NSMutableArray array];
    for (WUAlbumAsset *asset in _assetArray) {
        UIImage *image = [asset imageWithSize:size];
        [images addObject:image];
    }
    [_dataArray addObjectsFromArray:[NSArray arrayWithArray:images]];
    [self sortDataArray];
    [_collectionView reloadData];
    [self resizeView];
}

///重置frame
-(void)resizeView {
    NSInteger count = !_dataArray ? 0 : _dataArray.count;
    CGRect rect = self.frame;
    CGFloat height = [WUImageCollectionView getHeightWithImageCount:count viewWidth:rect.size.width];
    rect.size.height = height;
    self.frame = rect;
    
    CGRect collectionRect = _collectionView.frame;
    collectionRect.size.height = height;
    _collectionView.frame = collectionRect;
}

///获取高度,如果显示添加按钮应该是图片count + 1
+(CGFloat)getHeightWithImageCount:(NSInteger)count viewWidth:(CGFloat)viewWidth {
    NSInteger row = count / WU_COLUMN_COUNT;
    NSInteger yu = count % WU_COLUMN_COUNT;
    if(yu > 0) {
        row += 1;
    }
    CGFloat height = viewWidth / WU_COLUMN_COUNT;
    return height * row;
}

///获取已经选择的图片
-(NSArray<UIImage*>*)getSelectedImages {
    if(_dataArray && _dataArray.count > 0) {
        NSMutableArray<UIImage*> *array = [NSMutableArray array];
        for (UIImage *image in _dataArray) {
            if([image isEqual:_addImage]) {
                continue;
            }
            [array addObject:image];
        }
        return array;
    }
    return nil;
}

//MARK: 完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [_dataArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self sortDataArray];
        [self.collectionView reloadData];
        [self resizeView];
    }];
}

-(void)imageCollectionViewCellDelete:(WUImageCollectionViewCell *)cell {
    cell.imageView.image = nil;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    [_dataArray removeObjectAtIndex:indexPath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self resizeView];
}

@end
