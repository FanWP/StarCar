//
//  AddWheelPicVC.m
//  TianlangStar
//
//  Created by Beibei on 16/11/27.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import "AddWheelPicVC.h"

#import "UIView+MyExtension.h"
#import "Common.h"
#import "UIViewController+Default.h"
//添加附件
#import "SectionModel.h"
#import "HouseImageHeaderView.h"
#import "HouseImageCell.h"
#import "WUAlbum.h"
#import "UIImage+Aspect.h"
#import "UIImage+FixOrientation.h"

NSString *const commImageViewCellIdentifier = @"HouseImageViewCellIdentifier";
NSString *const commImageViewHeaderIdentifier = @"HouseImageViewHeaderIdentifier";



@interface AddWheelPicVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HouseImageCellDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,WUAlbumDelegate,WUImageBrowseViewDelegate,UIViewControllerPreviewingDelegate>

//添加附件
@property (strong, nonatomic) UIView *bottomView;
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray<SectionModel*> *dataArray;
@property(nonatomic,assign) NSInteger currentSection;       //当前操作的组
@property(nonatomic,strong) UIImage *plusImage;

@property (nonatomic,strong) SectionModel *s0;

@end

@implementation AddWheelPicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BGcolor;
    
    [self creatWeelView];
    
    [self rightItem];

    
}



- (void)creatWeelView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0,10, KScreenWidth, KScreenHeight)];
    [self.view addSubview:_bottomView];
    [self createData];
    [self.bottomView addSubview:self.collectionView];
}



- (void)rightItem
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"上传" style:(UIBarButtonItemStylePlain) target:self action:@selector(finishAction)];
    
    YYLog(@"uiersgkylv;/'jO:");
}



- (void)finishAction
{
    YYLog(@"上传");
    
    [self fetchCreatWeelPicData];
}



- (void)fetchCreatWeelPicData
{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    
    parmas[@"sessionId"]  = [UserInfo sharedUserInfo].RSAsessionId;
    parmas[@"type"]  = @"1";// 1.首页 2.公司介绍图 3.公司资质 4.业绩展示 5.公司成长
    
    YYLog(@"上传轮播图parmas--%@",parmas);
    
    NSString *url = [NSString stringWithFormat:@"%@upload/releasepictureservlet",URL];
    
    [[AFHTTPSessionManager manager] POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSArray *imagesArray = [self getAllImages];
        
        for (NSArray *array in imagesArray)
        {
            for (WUAlbumAsset *imageset in array)
            {
                UIImage *image = [imageset imageWithOriginal];
                
                NSData *data = UIImageJPEGRepresentation(image, 0.5);
                
                if (data != nil)
                {
                    [formData appendPartWithFileData:data name:@"images" fileName:@"img.jpg" mimeType:@"image/jpeg"];
                }
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        YYLog(@"上传轮播图返回：%@",responseObject);
        
        NSInteger resultCode = [responseObject[@"resultCode"] integerValue];
        
        if (resultCode == 1000)
        {
            [[AlertView sharedAlertView] addAfterAlertMessage:@"添加轮播图成功" title:@"提示"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        YYLog(@"上传轮播图错误%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--添加附件
-(void)createData {
    
    _plusImage = [UIImage imageNamed:@"add"];
    
    self.s0 = [SectionModel sectionModelWith:@"" cells:nil];
    self.s0.mutableCells = [NSMutableArray array];
    
    [self.s0.mutableCells addObject:_plusImage];
    
    _dataArray = @[self.s0];
}
#pragma 附件
- (UICollectionView *)collectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    CGFloat width = (self.view.width - 30) / 3;
    layout.itemSize = CGSizeMake(width, width);
//    layout.headerReferenceSize = CGSizeMake(CGRectGetWidth(self.view.frame), 30);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.bottomView.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor grayColor];
    [_collectionView registerClass:[HouseImageCell class] forCellWithReuseIdentifier:commImageViewCellIdentifier];
    [_collectionView registerClass:[HouseImageHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:commImageViewHeaderIdentifier];
    
    if(SystemVersion >= 9.0) {
        UILongPressGestureRecognizer *collectionViewLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewLongPress:)];
        [_collectionView addGestureRecognizer:collectionViewLongPress];
        
        [self registerForPreviewingWithDelegate:self sourceView:_collectionView];
    }
    
    return _collectionView;
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
#pragma -mark 3D-Touch peek

-(UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    NSIndexPath *indexPath = [_collectionView indexPathForItemAtPoint:location];
    if(!indexPath || indexPath.section == NSNotFound || indexPath.row == NSNotFound) {
        return nil;
    }
    
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([row isEqual:_plusImage]) {
        return nil;
    }
    
    HouseImageCell *cell = (HouseImageCell*)[_collectionView cellForItemAtIndexPath:indexPath];
    CGRect sourceRect = [cell convertRect:cell.imageView.frame toView:[previewingContext sourceView]];
    [previewingContext setSourceRect:sourceRect];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    UIImage *image;
    if([row isKindOfClass:[WUAlbumAsset class]]) {
        image = [row imageWithSize:bounds.size];
    } else if([row isKindOfClass:[UIImage class]]) {
        image = row;
    } else {
        return nil;
    }
    
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor clearColor];
    viewController.userInfo = indexPath;
    viewController.view.bounds = self.view.bounds;
    
    CGRect imageRect = [image rectAspectFitRectForSize:CGSizeMake(bounds.size.width - 60, bounds.size.height - 80)];
    imageRect.origin = CGPointMake(self.view.width/2-CGRectGetWidth(imageRect)/2, self.view.height/2-CGRectGetHeight(imageRect)/2 - 64);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageRect];
    imageView.image = image;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 10;
    
    [viewController.view addSubview:imageView];
    
    return viewController;
}
//pop
-(void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    
    NSIndexPath *indexPath = (NSIndexPath*)[viewControllerToCommit userInfo];
    _currentSection = indexPath.section;
    NSArray *images = [self getImagesWithSection:indexPath.section];
    if(images) {
        WUImageBrowseView *bv = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        bv.images = images;
        bv.delegate = self;
        bv.currentPage = indexPath.row;
        [bv show:self.navigationController.view];
        //        [self setInteractivePopGestureRecognizerEnabled:NO];
    }
    
}
#pragma -mark collectionView delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    return s.mutableCells.count;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([row isEqual:_plusImage]) {
        return NO;
    }
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    [self swapData:sourceIndexPath toIndexPath:destinationIndexPath];
    
    SectionModel *s = _dataArray[destinationIndexPath.section];
    //如果目标被移动到最后一个项
    if(destinationIndexPath.row > 0 && destinationIndexPath.row == s.mutableCells.count - 1) {
        id item = s.mutableCells[s.mutableCells.count - 2];
        if([item isEqual:_plusImage]) {
            [self swapData:destinationIndexPath toIndexPath:sourceIndexPath];
            [_collectionView moveItemAtIndexPath:destinationIndexPath toIndexPath:sourceIndexPath];
        }
    }
}
/**
 *  移动数据源
 *
 *  @param sourceIndexPath      源
 *  @param destinationIndexPath 目的
 */
-(void)swapData:(NSIndexPath*)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    SectionModel *s = _dataArray[destinationIndexPath.section];
    SectionModel *sourceSection = _dataArray[sourceIndexPath.section];
    id sourceItem = sourceSection.mutableCells[sourceIndexPath.row];
    [sourceSection.mutableCells removeObject:sourceItem];
    [s.mutableCells insertObject:sourceItem atIndex:destinationIndexPath.row];
}

//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *view;
//    if([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        HouseImageHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:commImageViewHeaderIdentifier forIndexPath:indexPath];
//        SectionModel *s = _dataArray[indexPath.section];
//        headerView.titleLabel.text = s.title;
//        headerView.titleLabel.font = UIFontLarge;
//        headerView.titleLabel.textColor = [UIColor blackColor];
//        view = headerView;
//        
//    }
//    
//    return view;
//}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HouseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:commImageViewCellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    if([self isAsset:row]) {
        cell.imageView.image = nil;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.layer.borderWidth = 0;
        cell.showDelete = YES;
        WUAlbumAsset *asset = (WUAlbumAsset*)row;
        __weak typeof(cell) weakCell = cell;
        CGSize size = CGSizeMake(cell.width * 2, cell.height * 2);
        [asset requestImageWithSize:size complete:^(UIImage *image) {
            if(weakCell) {
                __strong typeof(weakCell) strongCell = weakCell;
                strongCell.imageView.image = image;
            }
        }];
    } else if([row isEqual:_plusImage]) {
        cell.imageView.image = row;
        cell.imageView.layer.borderWidth = 1;
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.showDelete = NO;
    } else if([row isKindOfClass:[UIImage class]]) {
        cell.imageView.image = row;
        cell.imageView.layer.borderWidth = 0;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.showDelete = YES;
    }
    
    return cell;
}

/**
 *  判断是否为相册资源类型
 */
-(BOOL)isAsset:(id)value {
    if([value isKindOfClass:[WUAlbumAsset class]]) {
        return YES;
    }
    return NO;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _currentSection = indexPath.section;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    SectionModel *s = _dataArray[indexPath.section];
    id row = s.mutableCells[indexPath.row];
    
    if([row isEqual:_plusImage]) {
        [WUAlbum showPickerMenu:self delegate:self];
    } else {
        
        NSArray *images = [self getImagesWithSection:_currentSection];
        if(images) {
            WUImageBrowseView *bv = [[WUImageBrowseView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            bv.images = images;
            bv.delegate = self;
            bv.currentPage = indexPath.row;
            CGRect startFrame = [cell convertRect:cell.bounds toView:self.navigationController.view];
            
            UIImage *image;
            if([self isAsset:row]) {
                image = [row imageWithSize:[[UIScreen mainScreen] bounds].size];
            } else if([row isKindOfClass:[UIImage class]]) {
                image = row;
            } else if([row isKindOfClass:[NSString class]]) {
                //http 请求
            }
            
            [bv show:self.navigationController.view startFrame:startFrame foregroundImage:image];
            //            [self setInteractivePopGestureRecognizerEnabled:NO];
        }
    }
}

/**
 *  获取选择的图片
 */
-(NSArray*)getImagesWithSection:(NSInteger)index {
    SectionModel *s = _dataArray[index];
    if(s.mutableCells.count == 0) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:s.mutableCells];
    if([s.mutableCells.lastObject isEqual:_plusImage]) {
        [array removeLastObject];
    }
    
    return [NSArray arrayWithArray:array];
}

/**
 *  获取所有图片
 */
-(NSArray*)getAllImages {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _dataArray.count; i++) {
        NSArray *images = [self getImagesWithSection:i];
        if(images || images.count > 0) {
            [array addObject:images];
        }
    }
    
    return [NSArray arrayWithArray:array];
}

#pragma -mark imageBrowseView delegate

-(CGRect)imageBrowseView:(WUImageBrowseView *)view willCloseAtIndex:(NSInteger)index {
    UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:_currentSection]];
    CGRect endFrame = [cell convertRect:cell.bounds toView:self.navigationController.view];
    //    [self setInteractivePopGestureRecognizerEnabled:YES];
    return endFrame;
}

#pragma -mark HouseImageCell delegate

-(void)houseImageCellWillDeleteCell:(HouseImageCell *)cell {
    cell.imageView.image = nil;
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    SectionModel *s = _dataArray[indexPath.section];
    [s.mutableCells removeObjectAtIndex:indexPath.row];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    
}

//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info[UIImagePickerControllerOriginalImage] fixOrientation];
    
    WUAlbumAsset *asset = [WUAlbum savePhotoWithImage:image];
    if(asset) {
        [self insertDataArray:@[asset] atSection:_currentSection];
    } else {
        //压缩图片
        NSData *data = [WUAlbumAsset compressionWithImage:image];
        UIImage *image = [UIImage imageWithData:data];
        [self insertDataArray:@[image] atSection:_currentSection];
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  完成相册选择
 *
 *  @param assets 图片资源
 */
-(void)albumFinishedSelected:(NSArray<WUAlbumAsset *> *)assets {
    [self insertDataArray:assets atSection:_currentSection];
}

/**
 *  插入到数据集
 */
-(void)insertDataArray:(NSArray*)array atSection:(NSInteger)section {
    SectionModel *s = _dataArray[section];
    [s.mutableCells insertObjects:array atIndexes:[NSIndexSet indexSetWithIndexesInRange:(NSRange){s.mutableCells.count - 1,array.count}]];
    [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
}



@end
