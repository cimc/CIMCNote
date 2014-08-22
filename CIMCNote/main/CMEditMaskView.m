//
//  CMEditMaskView.m
//  CIMCNote
//
//  Created by cloudzou on 8/9/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMEditMaskView.h"

@interface CMEditMaskView  ()

@property (nonatomic,strong) UIButton* saveNoteButton;
@property (nonatomic,strong) UIButton* cancelNoteButton;
@property (nonatomic,strong) UIButton* deleteNoteButton;

@end

@implementation CMEditMaskView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:0.5];
    
    _saveNoteButton = [[UIButton alloc] initForAutoLayout];
    [self addSubview:_saveNoteButton];
    
    //self.saveNoteButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonSave46.png"]];
    [_saveNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonSave184.png"] forState:UIControlStateNormal];
    [_saveNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonSaveDown184.png"] forState:UIControlStateSelected];
    
    [_saveNoteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_saveNoteButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    
    [_saveNoteButton autoSetDimension:ALDimensionWidth toSize:92];
    [_saveNoteButton autoSetDimension:ALDimensionHeight toSize:92];
    [_saveNoteButton addTarget:self action:@selector(saveNoteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _cancelNoteButton = [[UIButton alloc] initForAutoLayout];
    [self addSubview:_cancelNoteButton];
    
    [_cancelNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonCancel184.png"] forState:UIControlStateNormal];
    [_cancelNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonCancelDown184.png"] forState:UIControlStateSelected];
    
    [_cancelNoteButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_saveNoteButton withOffset:10];
    [_cancelNoteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_cancelNoteButton autoSetDimension:ALDimensionHeight toSize:92];
    [_cancelNoteButton autoSetDimension:ALDimensionWidth toSize:92];
    [_cancelNoteButton addTarget:self action:@selector(cancelNoteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _deleteNoteButton = [[UIButton alloc] initForAutoLayout];
    [self addSubview:_deleteNoteButton];
    
    [_deleteNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonDelete184.png"] forState:UIControlStateNormal];
    [_deleteNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonDeleteDown184.png"] forState:UIControlStateSelected];
    
    [_deleteNoteButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_cancelNoteButton withOffset:10];
    [_deleteNoteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_deleteNoteButton autoSetDimension:ALDimensionHeight toSize:92];
    [_deleteNoteButton autoSetDimension:ALDimensionWidth toSize:92];
    
    [_deleteNoteButton addTarget:self action:@selector(deleteNoteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _propertyNoteButton = [[UIButton alloc] initForAutoLayout];
    [self addSubview:_propertyNoteButton];
    
    [_propertyNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonProperties184.png"] forState:UIControlStateNormal];
    [_propertyNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonPropertiesDown184.png"] forState:UIControlStateSelected];
    
    [_propertyNoteButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_deleteNoteButton withOffset:10];
    [_propertyNoteButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [_propertyNoteButton autoSetDimension:ALDimensionHeight toSize:92];
    [_propertyNoteButton autoSetDimension:ALDimensionWidth toSize:92];
    
    [_propertyNoteButton addTarget:self action:@selector(setNoteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)saveNoteButtonAction:(UIButton*)sender
{
    [self.delegate saveNoteTextAction:self];
}

- (void)cancelNoteButtonAction:(UIButton*)sender
{
    [self.delegate cancelNoteTextAction:self];
}
- (void)deleteNoteButtonAction:(UIButton*)sender
{
    [self.delegate deleteNoteTextAction:self];
}

- (void)setNoteButtonAction:(UIButton*)sedner
{
    [self.delegate setNoteTextAction:self];
}
@end
