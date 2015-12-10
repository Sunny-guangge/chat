//
//  CKChatBoxFacePageView.m
//  xmppChat
//
//  Created by user on 15/12/10.
//  Copyright © 2015年 user. All rights reserved.
//

#import "CKChatBoxFacePageView.h"
#import "UIView+TL.h"

@interface CKChatBoxFacePageView ()

@property (nonatomic,strong) UIButton *delButton;
@property (nonatomic,strong) NSMutableArray *faceViewArray;

@end

@implementation CKChatBoxFacePageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.delButton];
    }
    
    return self;
}

- (void)showFaceGroup:(CKFaceGroup *)group fromIndex:(int)fromIndex count:(int)count
{
    int index = 0;
    float spaceX = 12;
    float spaceY = 10;
    int row = (group.faceType == CKFaceTypeEmoji ? 3 : 2);
    int col = (group.faceType == CKFaceTypeEmoji ? 7 : 4);
    float w = (WIDTH_SCREEN - spaceX * 2) / col;
    float h = (self.frameHeight - spaceY * (row - 1)) / row;
    float x = spaceX;
    float y = spaceY;
    
    for (int i = fromIndex; i < fromIndex + count; i ++) {
        UIButton *button;
        if (index < self.faceViewArray.count) {
            button = [self.faceViewArray objectAtIndex:index];
        }
        else
        {
            button = [[UIButton alloc] init];
            [button addTarget:_target action:_action forControlEvents:_controEvents];
            [self addSubview:button];
            [self.faceViewArray addObject:button];
        }
        index ++;
        
        if (i >= group.facesArray.count || i < 0) {
            [button setHidden:YES];
        }
        else
        {
            CKFace *face = [group.facesArray objectAtIndex:i];
            button.tag = i;
            [button setImage:[UIImage imageNamed:face.faceName] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(x, y, w, h)];
            [button setHidden:YES];
            x = (index % col == 0 ? spaceX : x + w);
            y = (index % col == 0 ? y + h : y);
        }
    }
    
    [_delButton setHidden:fromIndex >= group.facesArray.count];
    [_delButton setFrame:CGRectMake(x, y, w, h)];
}


- (void)addTarget:(id)target action:(nonnull SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    _target = target;
    _action = action;
    _controEvents = controlEvents;
    [self.delButton addTarget:_target action:_action forControlEvents:_controEvents];
    for (UIButton *button in self.faceViewArray) {
        [button addTarget:target action:action forControlEvents:controlEvents];
    }
}

#pragma mark - Getter
- (NSMutableArray *)faceViewArray
{
    if (_faceViewArray == nil) {
        _faceViewArray = [[NSMutableArray alloc] init];
    }
    return _faceViewArray;
}

- (UIButton *)delButton
{
    if (_delButton == nil) {
        _delButton = [[UIButton alloc] init];
        _delButton.tag = -1;
        [_delButton setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
    }
    return _delButton;
}

@end
