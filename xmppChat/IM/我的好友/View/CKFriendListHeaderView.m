//
//  CKFriendListHeaderView.m
//  xmppChat
//
//  Created by user on 15/11/26.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKFriendListHeaderView.h"
#import "UIView+TL.h"

@interface CKFriendListHeaderView ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation CKFriendListHeaderView

+ (instancetype)friendListHeaderViewWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"CKFriendListHeaderView";
    
    CKFriendListHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (headerView == nil) {
        
        headerView = [[CKFriendListHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return headerView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
        
        [self addSubview:self.titleLabel];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 0, self.frameWidth - 10, self.frameHeight);
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.5];
        _titleLabel.textColor = [UIColor grayColor];
        
    }
    
    return _titleLabel;
}

@end
