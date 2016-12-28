//
//  WUAlbumGroupViewController.m
//  kztool
//
//  Created by 武探 on 16/6/23.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUAlbumGroupViewController.h"
#import <Photos/Photos.h>
#import "WUAlbumViewController.h"

@interface WUAlbumGroupCell : UITableViewCell

@property(nonatomic,strong) UIImageView *imView;

@end

@implementation WUAlbumGroupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        [self initialize];
    }
    return self;
}

-(void)initialize {
    _imView = [[UIImageView alloc] init];
    _imView.contentMode = UIViewContentModeScaleAspectFill;
    _imView.clipsToBounds = YES;
    _imView.layer.masksToBounds = YES;
    _imView.layer.cornerRadius = 4;
    _imView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_imView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    _imView.frame = CGRectMake(15, 5, CGRectGetHeight(self.frame) - 10, CGRectGetHeight(self.frame) - 10);
    self.textLabel.frame = CGRectMake(CGRectGetMaxX(_imView.frame) + 10, CGRectGetHeight(self.frame) / 2 - 10, CGRectGetWidth(self.frame) - CGRectGetMaxX(_imView.frame) - 20, 20);
}

@end







NSString *const WUAlbumGroupCellIdentifier = @"WUAlbumGroupCellIdentifier";
@interface WUAlbumGroupViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray<PHAssetCollection*> *dataArray;
@property(nonatomic,strong) NSMutableArray<UIImage*> *imageArray;
@property(nonatomic,strong) NSMutableArray<NSString*> *titleArray;

@property(nonatomic,strong) NSMutableArray<PHAssetCollection*> *resultArray;

@end

@implementation WUAlbumGroupViewController

-(instancetype)init {
    self = [super init];
    if(self) {
        _dataArray = [NSMutableArray array];
        _imageArray = [NSMutableArray array];
        _titleArray = [NSMutableArray array];
        
        _resultArray = [NSMutableArray array];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self initializeComponent];
}

-(void)initializeComponent {
    self.title = @"照片";

    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBarButtonTouch:)];
    self.navigationItem.rightBarButtonItem = cancelBarButton;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 66;
    [_tableView registerClass:[WUAlbumGroupCell class] forCellReuseIdentifier:WUAlbumGroupCellIdentifier];
    [self.view addSubview:_tableView];
    
    [self loadAlbumGroup];
}

-(void)cancelBarButtonTouch:(UIBarButtonItem*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loadAlbumGroup {
    dispatch_async(dispatch_get_main_queue(), ^{
        //系统智能相册
        PHFetchResult<PHAssetCollection *> *smartResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
        for (PHAssetCollection *collection in smartResult) {
            //如果是相机胶卷
            if(collection.assetCollectionSubtype == PHAssetCollectionSubtypeSmartAlbumUserLibrary) {
                [self.dataArray insertObject:collection atIndex:0];
            } else {
                [self.dataArray addObject:collection];
            }
        }
        
        //时刻相册
        PHFetchResult<PHAssetCollection*> *momentResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeMoment subtype:PHAssetCollectionSubtypeAny options:nil];
        if(momentResult && momentResult.count > 0) {
            for (PHAssetCollection *item in momentResult) {
                [self.dataArray addObject:item];
            }
        }
        
        //用户自定义相册
        PHFetchResult<PHAssetCollection *> *albumResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
        if(albumResult && albumResult.count > 0){
            for (PHAssetCollection *item in albumResult) {
                [self.dataArray addObject:item];
            }
        }
        
        for (PHAssetCollection *assetCollection in self.dataArray) {
//            NSString *title = assetCollection.localizedTitle == nil ? @"" : assetCollection.localizedTitle;
            NSString *title = assetCollection.localizedTitle;
            if(!title || [title isEqualToString:@""]) {
                continue;
            }
            
            PHFetchResult<PHAsset *> *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
            //如果相册内容为空
            if(!assetResult || assetResult.count == 0) {
                continue;
            } else {
                [_resultArray addObject:assetCollection];
                title = [NSString stringWithFormat:@"%@(%lu)",title,(unsigned long)assetResult.count];
                [self.titleArray addObject:title];
            }
            
            PHAsset *asset = assetResult.lastObject;
            PHImageRequestOptions *requestOptions = [[PHImageRequestOptions alloc] init];
            requestOptions.synchronous = YES;
            PHImageManager *imageManager = [PHImageManager defaultManager];
            CGFloat width = 66.0 * 2.0;
            [imageManager requestImageForAsset:asset targetSize:CGSizeMake(width, width) contentMode:PHImageContentModeAspectFill options:requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if(result) {
                    [self.imageArray addObject:result];
                } else {
                    [self.imageArray addObject:[[UIImage alloc] init]];
                }
            }];
        }
        
        [self.tableView reloadData];
        [self.dataArray removeAllObjects];
        self.dataArray = nil;
    });
}

#pragma -mark tableView delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WUAlbumGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:WUAlbumGroupCellIdentifier forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.imView.image = _imageArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WUAlbumViewController *albumController = [[WUAlbumViewController alloc] init];
    albumController.delegate = self.delegate;
    albumController.assetCollection = self.resultArray[indexPath.row];
    [self.navigationController pushViewController:albumController animated:YES];
}

@end
