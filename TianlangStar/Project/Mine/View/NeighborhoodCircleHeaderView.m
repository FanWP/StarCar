//
//  NeighborhoodCircleHeaderView.m
//  IntelligenceCommunity
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 mumu. All rights reserved.
//

#import "NeighborhoodCircleHeaderView.h"

#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define MAX_TitleNumInWindow 5

@interface NeighborhoodCircleHeaderView ()

@property (nonatomic,strong) NSMutableArray *buttonsMArray; //存放button的数组
@property (nonatomic,strong) NSArray *titlesArray;  //button标题
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;  //选中后的标示线
@property (nonatomic,assign) CGFloat btn_w;  //button的宽度

@end
@implementation NeighborhoodCircleHeaderView

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        _btn_w=0.0;
#pragma mark--计算每一个button的宽度(当前一个width显示5个button)
        if (titleArray.count<MAX_TitleNumInWindow+1) {
            //当button的个数 <= 5个时,button宽度==window_Width/个数
            _btn_w=KScreenWidth/titleArray.count;
        }else{  //个数 >5 的时候,button宽度==window_Width/5
            _btn_w=KScreenWidth/MAX_TitleNumInWindow;
        }
#pragma mark--关于基础控件的赋值
        _titlesArray=titleArray;
        _defaultIndex=1;    //默认选中的button下标是1
        _titleFont=[UIFont systemFontOfSize:15];
        _buttonsMArray=[[NSMutableArray alloc] initWithCapacity:0];
        _titleNomalColor=[UIColor blackColor];
        _titleSelectColor=SFQRedColor;
        
#pragma mark--ScrollView的创建
        //step.1滚动范围等属性设置
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, self.frame.size.height)];
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        //        _bgScrollView.scrollEnabled = NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, self.frame.size.height);
        [self addSubview:_bgScrollView];
        //step.2与界面的分隔线,高度为1
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, _btn_w*titleArray.count, 1)];
        line.backgroundColor=[UIColor lightGrayColor];
        [_bgScrollView addSubview:line];
        //step.3选中某个button是的标示线(红色线)
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 2, _btn_w, 2)];
//                _selectLine=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-10, _btn_w, 2)];
        _selectLine.backgroundColor=_titleSelectColor;
        [_bgScrollView addSubview:_selectLine];
        
#pragma mark--根据标题数组的count值创建button并添加到scrollView上面
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height - 2);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.titleLabel.font=_titleFont;
            [_bgScrollView addSubview:btn];
            [_buttonsMArray addObject:btn];
            if (i==0) {
                _titleBtn=btn;
                btn.selected=YES;
            }
            self.block=block;
            
        }
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {  //点击button后的block回调,可根据点击的button.tag做相应操作
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{  //为选中的button设置状态(字体颜色、标示线)
        _titleBtn.selected=!_titleBtn.selected;
        _titleBtn=btn;
        _titleBtn.selected=YES;
        _defaultIndex=btn.tag;
    }
    
#pragma mark--计算偏移量(让选中的button始终位于屏幕中间)
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {    //当index<2,即选中了前两个button,则不让scrollView偏移
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-KScreenWidth;
    if (offsetX>maxOffsetX) {   //设置最大偏移量,保证最后5个button的位置铺满屏幕
        offsetX=maxOffsetX;
    }
#pragma mark--让scrollView随着选中的button下标改变偏移量
    [UIView animateWithDuration:.2 animations:^{
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame=CGRectMake(btn.frame.origin.x, self.frame.size.height-2, btn.frame.size.width, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
}
#pragma mark--基本属性赋值
-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}
#pragma mark--当修改相关属性的值的时候,同时更改button对应的属性的值
-(void)updateView{
    for (UIButton *btn in _buttonsMArray) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
            _selectLine.mj_x = btn.mj_x;
        }else{
            btn.selected=NO;
        }
    }
}

@end
