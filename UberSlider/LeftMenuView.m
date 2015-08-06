//
//  LeftMenuView.m
//  UberSlider
//
//  Created by YiHui on 15/8/6.
//  Copyright (c) 2015年 Afer. All rights reserved.
//


#import "LeftMenuView.h"
#import "MenuTableViewCell.h"
#define LEAD_SPACE 15.0

@implementation LeftMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scr = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scr.contentSize = CGSizeMake(frame.size.width, 568);
        [self addSubview:scr];
        scr.bounces = NO;
        scr.showsVerticalScrollIndicator = NO;

        
        
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 100)];
        topView.backgroundColor = [UIColor colorWithWhite:0.110 alpha:1.000];
        [scr addSubview:topView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(LEAD_SPACE, 20, 40, 40)];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.layer.cornerRadius = imageView.bounds.size.width / 2.0;
        [imageView setClipsToBounds:YES];
        [topView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(LEAD_SPACE, CGRectGetMaxY(imageView.frame) + 10, 200, 20)];
        label.text = @"老王不要抖我";
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
        [topView addSubview:label];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(topView.bounds), frame.size.width, 385)];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 55;
        tableView.scrollEnabled = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [scr addSubview:tableView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(tableView.frame), frame.size.width, 1)];
        lineView.backgroundColor = [UIColor colorWithWhite:0.637 alpha:1.000];
        [scr addSubview:lineView];
        
        UIButton *aboutButton = [[UIButton alloc] initWithFrame:CGRectMake(LEAD_SPACE, CGRectGetMaxY(lineView.frame) + 5, 200, 30)];
        [aboutButton setTitle:@"关于" forState:(UIControlStateNormal)];
        [aboutButton setTitleColor:[UIColor colorWithWhite:0.814 alpha:1.000] forState:(UIControlStateNormal)];
        aboutButton.titleLabel.font = [UIFont systemFontOfSize:13];
        aboutButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        aboutButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [scr addSubview:aboutButton];
        _cellNameArray = @[@"付款",@"历史记录",@"帮助",@"优惠乘车机会",@"优惠",@"通知",@"设置"];
        [tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _cellNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.cImageView.image = [UIImage imageNamed:@"123"];
    cell.cLabel.text = _cellNameArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}





















@end
