//
//  CMNoteView.h
//  CIMCNote
//
//  Created by duguo on 8/5/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMNoteView : UIView

@property (nonatomic, strong) NSString* originContent;
@property (nonatomic, assign) int zIndex;
@property (nonatomic, assign) CGPoint newPoint;
@property (nonatomic, assign) NSInteger bgNum;

- (id)initWithPoint:(CGPoint)point content:(NSString*)content zIndex:(NSInteger)zIndex bgNum:(NSInteger)bgNum;

- (void)addTarget:(id)target doubleTapNoteTextView:(SEL)action;
- (void)addTarget:(id)target singleTagpNoteTextView:(SEL)action;

- (void)becomeFirstResponder;
- (void)resignFirstResponder;
- (void)updateOriginContent;
- (void)restoreOriginContent;
- (void)restoreCenter;

- (void)updateBgImageView:(NSString*)bgNum;

+ (void)resetZindex:(NSInteger)zIndex;

@end
