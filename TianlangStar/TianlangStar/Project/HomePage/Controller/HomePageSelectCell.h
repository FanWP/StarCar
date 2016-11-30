//
//  HomePageSelectCell.h
//  TianlangStar
//
//  Created by Beibei on 16/11/14.
//  Copyright © 2016年 yysj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopPicBottomLabelButton;
@interface HomePageSelectCell : UITableViewCell

// 保养维护
@property (nonatomic,strong) TopPicBottomLabelButton *maintenanceButton;
// 商品
@property (nonatomic,strong) TopPicBottomLabelButton *productButton;
// 车辆信息
@property (nonatomic,strong) TopPicBottomLabelButton *carInfoButton;

@end
