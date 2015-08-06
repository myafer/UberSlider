//
//  MenuTableViewCell.m
//  UberSlider
//
//  Created by YiHui on 15/8/6.
//  Copyright (c) 2015年 Afer. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 17, 21, 21)];
        [self addSubview:_cImageView];
        
        _cLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_cImageView.frame) + 10, 17, 160, 21)];
        _cLabel.textColor = [UIColor whiteColor];
        _cLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_cLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    return self;
}

@end
