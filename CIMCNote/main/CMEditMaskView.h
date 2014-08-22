//
//  CMEditMaskView.h
//  CIMCNote
//
//  Created by cloudzou on 8/9/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMEditMaskView;
@protocol CMEditMaskViewDelegate <NSObject>
@optional
- (void)saveNoteTextAction:(CMEditMaskView*)editMaskView;
- (void)cancelNoteTextAction:(CMEditMaskView*)editMaskView;
- (void)deleteNoteTextAction:(CMEditMaskView*)editMaskView;
- (void)setNoteTextAction:(CMEditMaskView*)editMaskView;
@end

@interface CMEditMaskView : UIView

@property (nonatomic,strong) UIButton* propertyNoteButton;
@property (nonatomic, weak) id<CMEditMaskViewDelegate> delegate;

@end
