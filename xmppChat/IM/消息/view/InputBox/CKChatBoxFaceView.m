//
//  CKChatBoxFaceView.m
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatBoxFaceView.h"
#import "CKChatBoxFaceMenuView.h"
#import "UIView+TL.h"
#import "CKFaceHelper.h"
#import "CKChatBoxFacePageView.h"
#import "CKFaceHelper.h"

#define HEIGHT_BOTTOM_VIEW  36.0f

@interface CKChatBoxFaceView ()<CKChatBoxFaceMenuViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) CKFaceGroup *curGroup;
@property (nonatomic,assign) int curPage;

@property (nonatomic,strong) UIView *topLine;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) CKChatBoxFaceMenuView  *faceMenuView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *facePageViewArray;

@end

@implementation CKChatBoxFaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:DEFAULT_CHATBOX_COLOR];
        [self addSubview:self.topLine];
        [self addSubview:self.pageControl];
        [self addSubview:self.scrollView];
        [self addSubview:self.faceMenuView];
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    [self.scrollView setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - HEIGHT_BOTTOM_VIEW)];
    [self.pageControl setFrame:CGRectMake(0, self.scrollView.frameHeight + 3, frame.size.width, 8)];
    for (CKChatBoxFacePageView *pageView in self.facePageViewArray) {
        [self.scrollView addSubview:pageView];
    }
}

#pragma mark - CKChatBoxFaceMenuViewDelegate
- (void) chatBoxFaceMenuViewAddButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxFaceViewAddButtonDown)]) {
        [_delegate chatBoxFaceViewAddButtonDown];
    }
}
- (void) chatBoxFaceMenuViewSendButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxFaceViewSendButtonDown)]) {
        [_delegate chatBoxFaceViewSendButtonDown];
    }
}
- (void) chatBoxFaceMenuView: (CKChatBoxFaceMenuView *)chatBoxFaceMenuView didSelectedFaceMenuIndex:(NSInteger)index
{
    _curGroup = [[[CKFaceHelper shareFaceHelper] faceGroupArray] objectAtIndex:index];
    
    if (_curGroup.facesArray == nil) {
        _curGroup.facesArray = [[CKFaceHelper shareFaceHelper] getFaceArrayByGroupID:_curGroup.groupID];
    }
    [self reloadScrollView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / self.frameWidth;
    if (page > _curPage && (page * WIDTH_SCREEN - scrollView.contentOffset.x) < WIDTH_SCREEN * 0.2) {
        //向右翻
        [self showFacePageAtIndex:page];
    }
    else if(page < _curPage && (scrollView.contentOffset.x - page * WIDTH_SCREEN) < WIDTH_SCREEN * 0.2)
    {
        [self showFacePageAtIndex:page];
    }
}

#pragma mark - Event Response
- (void)didSelectedFace:(UIButton *)sender
{
    if (sender.tag == -1) {
        
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxFaceViewDeleteButtonDown)]) {
            [_delegate chatBoxFaceViewDeleteButtonDown];
        }
        
    }else
    {
        CKFace *face = [_curGroup.facesArray objectAtIndex:sender.tag];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxFaceViewDidSelectedFace:type:)]) {
            [_delegate chatBoxFaceViewDidSelectedFace:face type:_curGroup.faceType];
        }
    }
}

- (void)pageControlClicked:(UIPageControl *)pageControl
{
    [self showFacePageAtIndex:pageControl.currentPage];
    [self.scrollView scrollRectToVisible:CGRectMake(pageControl.currentPage * WIDTH_SCREEN, 0, WIDTH_SCREEN, self.scrollView.frameHeight) animated:YES];
}

#pragma mark - Private Methods
- (void)reloadScrollView
{
    int page = (int)(self.curGroup.facesArray.count / (self.curGroup.faceType == CKFaceTypeEmoji ? 20 : 8)) + (int)(self.curGroup.facesArray.count % (self.curGroup.faceType == CKFaceTypeEmoji ? 20 : 8));
    [self.pageControl setNumberOfPages:page];
    [self.scrollView setContentSize:CGSizeMake(WIDTH_SCREEN * page, self.scrollView.frameHeight)];
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, WIDTH_SCREEN, self.scrollView.frameHeight) animated:NO];
    _curPage = -1;
    [self showFacePageAtIndex:0];
}

- (void)showFacePageAtIndex:(NSUInteger)index
{
    if (index == _curPage) {
        return;
    }
    [self.pageControl setCurrentPage:index];
    int count = _curGroup.faceType == CKFaceTypeEmoji ? 20 : 8;
    if (_curPage == -1) {
        CKChatBoxFacePageView *pageView1 = [self.facePageViewArray objectAtIndex:0];
        [pageView1 showFaceGroup:_curGroup fromIndex:0 count:0];
        [pageView1 setOrigin:CGPointMake(-WIDTH_SCREEN, 0)];
        [pageView1 addTarget:self action:@selector(didSelectedFace:) forControlEvents:UIControlEventTouchUpInside];
        CKChatBoxFacePageView *pageView2 = [self.facePageViewArray objectAtIndex:1];
        [pageView1 showFaceGroup:_curGroup fromIndex:0 count:count];
        [pageView2 setOrigin:CGPointMake(0, 0)];
        [pageView2 addTarget:self action:@selector(didSelectedFace:) forControlEvents:UIControlEventTouchUpInside];
        CKChatBoxFacePageView *pageView3 = [self.facePageViewArray objectAtIndex:2];
        [pageView3 showFaceGroup:_curGroup fromIndex:count count:count];
        [pageView3 addTarget:self action:@selector(didSelectedFace:) forControlEvents:UIControlEventTouchUpInside];
        [pageView3 setOrigin:CGPointMake(WIDTH_SCREEN, 0)];
    }
    else {
        if (_curPage < index) {
            CKChatBoxFacePageView *pageView1 = [self.facePageViewArray objectAtIndex:0];
            [pageView1 showFaceGroup:_curGroup fromIndex:(int)(index + 1) * count count:count];
            [pageView1 setOrigin:CGPointMake((index + 1) * WIDTH_SCREEN, 0)];
            [self.facePageViewArray removeObjectAtIndex:0];
            [self.facePageViewArray addObject:pageView1];
        }
        else {
            CKChatBoxFacePageView *pageView3 = [self.facePageViewArray objectAtIndex:2];
            [pageView3 showFaceGroup:_curGroup fromIndex:(int)(index - 1) count:count];
            [pageView3 setOrigin:CGPointMake((index - 1) * WIDTH_SCREEN, 0)];
            [self.facePageViewArray removeObjectAtIndex:2];
            [self.facePageViewArray insertObject:pageView3 atIndex:0];
        }
    }
    _curPage = (int)index;
}

#pragma mark - getter
- (UIView *)topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, 0.5)];
        [_topLine setBackgroundColor:DEFAULT_LINE_GRAY_COLOR];
    }
    return _topLine;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setScrollsToTop:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setDelegate:self];
        [_scrollView setPagingEnabled:YES];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControl.pageIndicatorTintColor = DEFAULT_LINE_GRAY_COLOR;
        [_pageControl addTarget:self action:@selector(pageControlClicked:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _pageControl;
}

- (NSMutableArray *)facePageViewArray
{
    if (_facePageViewArray == nil) {
        
    }
    return _facePageViewArray;
}

- (CKChatBoxFaceMenuView *)faceMenuView
{
    if (_faceMenuView == nil) {
        _faceMenuView = [[CKChatBoxFaceMenuView alloc] initWithFrame:CGRectMake(0, self.frameHeight - HEIGHT_BOTTOM_VIEW, WIDTH_SCREEN, HEIGHT_BOTTOM_VIEW)];
        [_faceMenuView setDelegate:self];
        [_faceMenuView setFaceGroupArray:[[CKFaceHelper shareFaceHelper] faceGroupArray]];
    }
    return _faceMenuView;
}

@end
