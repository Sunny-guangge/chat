//
//  CKChatBoxMoreView.m
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatBoxMoreView.h"
#import "UIView+TL.h"

@interface CKChatBoxMoreView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControll;

@end

@implementation CKChatBoxMoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:DEFAULT_CHATBOX_COLOR];
        [self addSubview:self.topLine];
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControll];
        
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self.scrollView setFrame:CGRectMake(0, 0.5, frame.size.width, frame.size.height - 18)];
    [self.pageControll setFrame:CGRectMake(0, self.frameHeight - 18, frame.size.width, 8)];
}

- (void)setItems:(NSMutableArray *)items
{
    _items = items;
    
    self.pageControll.numberOfPages = items.count / 8 + 1;
    self.scrollView.contentSize = CGSizeMake(WIDTH_SCREEN * (items.count / 8 + 1), _scrollView.frameHeight);
    
    float w = self.frameWidth * 20 / 21 / 4 * 0.8;
    float space = w / 4;
    float h = (self.frameHeight - 20 - space * 2) / 2;
    
    float x = space, y = space;
    int i = 0, page = 0;
    
    for (CKChatBoxMoreItem *item in items) {
        
        [self.scrollView addSubview:item];
        [item setFrame:CGRectMake(x, y, w, h)];
        [item setTag:i];
        [item addTarget:self action:@selector(didSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
        i ++;
        page = i % 8 == 0 ? page + 1 : page;
        x = (i % 4 ? x + w : page * self.frameWidth) + space;
        y = (i % 8 < 4 ? space : h + space * 1.5);
        
    }
    
}


#pragma mark - UIScrollViewDelegate
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.frameWidth;
    [_pageControll setCurrentPage:page];
}


- (void)pageControllClicked:(UIPageControl *)pageControll
{
    [self.scrollView scrollRectToVisible:CGRectMake(pageControll.currentPage * WIDTH_SCREEN, 0, WIDTH_SCREEN, self.scrollView.frameHeight) animated:YES];
}

- (void)didSelectedItem:(CKChatBoxMoreItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxMoreView:didSelectItem:)]) {
        [_delegate chatBoxMoreView:self didSelectItem:(int)sender.tag];
    }
}



#pragma mark - getter
- (UIView *)topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 0.5f)];
        [_topLine setBackgroundColor:DEFAULT_LINE_GRAY_COLOR];
    }
    
    return _topLine;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setScrollsToTop:NO];
        [_scrollView setDelegate:self];
    }
    return _scrollView;
}

- (UIPageControl *)pageControll
{
    if (_pageControll == nil) {
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControll.pageIndicatorTintColor = DEFAULT_LINE_GRAY_COLOR;
        [_pageControll addTarget:self action:@selector(pageControllClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControll;
}

@end
