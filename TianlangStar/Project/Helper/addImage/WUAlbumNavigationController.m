//
//  WUAlbumNavigationController.m
//  kztool
//
//  Created by 武探 on 16/6/24.
//  Copyright © 2016年 wutan. All rights reserved.
//

#import "WUAlbumNavigationController.h"
#import "WUAlbumGroupViewController.h"

@implementation WUAlbumNavigationController

-(instancetype)initWithDelegate:(__weak id<WUAlbumDelegate>)delegate {
    self = [super init];
    if(self) {
        WUAlbumGroupViewController *groupController = [[WUAlbumGroupViewController alloc] init];
        groupController.delegate = delegate;
        [self setViewControllers:@[groupController]];
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
}

-(BOOL)shouldAutorotate {
    return false;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


@end
