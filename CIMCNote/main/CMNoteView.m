//
//  CMNoteView.m
//  CIMCNote
//
//  Created by duguo on 8/5/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMNoteView.h"
#import "CMNoteTextView.h"
#import "UIImage+MaskImage.h"

#define kNoteWidth 400.0f
#define kNoteHeight 400.0f

@interface CMNoteView  ()
@property (nonatomic, strong) CMNoteTextView* noteTextView;
@property (nonatomic, assign) CGPoint startedPoint;
@property (nonatomic, strong) UIImageView* bgImageView;
@end


static int zIndexNum;

@implementation CMNoteView

- (id)init
{
    self = [super init];
    if (self) {
        zIndexNum += 1;
        
        self.zIndex = zIndexNum;
        [self generateRand];
        [self initView];
    }
    return self;
}


- (id)initWithPoint:(CGPoint)point content:(NSString*)content zIndex:(NSInteger)zIndex bgNum:(NSInteger)bgNum
{
    CGRect frame = CGRectMake(0, 0, kNoteWidth, kNoteHeight);
    self = [super initWithFrame:frame];
    if (self) {
        self.newPoint = point;
        self.originContent = content;
        self.zIndex = zIndex;
        self.bgNum = bgNum;
        self.center = point;
        
        [self initViewWithCenter:point];
        
        if (bgNum > zIndexNum) {
            zIndexNum = bgNum;
        }
    }
    
    return self;
}

- (void)generateRand
{
    int x = arc4random() % 100;
    self.bgNum = x % 4;
}

- (void)generateImageView
{
    NSString* noteName = [NSString stringWithFormat:@"note%d.jpg",self.bgNum];
    NSString* noteMaskName = [NSString stringWithFormat:@"note%d_mask.png",self.bgNum];
    
    self.bgImageView = [[UIImageView alloc] initForAutoLayout];
    self.bgImageView.image = [UIImage maskImage:[UIImage imageNamed:noteName] withMask:[UIImage imageNamed:noteMaskName]];
}

- (void) initViewWithCenter:(CGPoint)center
{
    [self generateImageView];
    
    [self addSubview: self.bgImageView];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.bgImageView autoSetDimension:ALDimensionWidth toSize:400];
    [self.bgImageView autoSetDimension:ALDimensionHeight toSize:400];
    
    self.noteTextView = [[CMNoteTextView alloc] initForAutoLayout];
    [self.noteTextView setBackgroundColor:[UIColor clearColor]];
    self.noteTextView.text = self.originContent;
    
    self.noteTextView.font = [UIFont systemFontOfSize:24.0f];
    
    [self addSubview:self.noteTextView];
    
    [self.noteTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.noteTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    [self.noteTextView autoSetDimension:ALDimensionWidth toSize:300];
    [self.noteTextView autoSetDimension:ALDimensionHeight toSize:300];
}

- (void) initView
{
    [self generateImageView];

    [self addSubview: self.bgImageView];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.bgImageView autoSetDimension:ALDimensionWidth toSize:400];
    [self.bgImageView autoSetDimension:ALDimensionHeight toSize:400];
    
    self.noteTextView = [[CMNoteTextView alloc] initForAutoLayout];
    [self.noteTextView setBackgroundColor:[UIColor clearColor]];
    self.noteTextView.text = self.originContent;
    
    [self addSubview:self.noteTextView];

    [self.noteTextView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [self.noteTextView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:40];
    [self.noteTextView autoSetDimension:ALDimensionWidth toSize:300];
    [self.noteTextView autoSetDimension:ALDimensionHeight toSize:300];

}

- (void)resignFirstResponder
{
    [self.noteTextView resignFirstResponder];
}

- (void)becomeFirstResponder
{
    [self.noteTextView setEditable:YES];
    [self.noteTextView becomeFirstResponder];
}


- (void)updateOriginContent
{
    self.originContent = self.noteTextView.text;
}

- (void)restoreOriginContent
{
    self.noteTextView.text = self.originContent;
}

- (void)restoreCenter
{
//    if (!self.translatesAutoresizingMaskIntoConstraints) {
//        self.translatesAutoresizingMaskIntoConstraints = YES;
//        self.newPoint = CGPointMake(220.0f, 220.0f);
//    }

    self.center = self.newPoint;
}

- (void)updateBgImageView:(NSString*)bgNum
{
    [self.bgImageView removeFromSuperview];
    self.bgNum = [bgNum intValue];
    [self generateImageView];
    
    [self addSubview: self.bgImageView];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
    [self.bgImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.bgImageView autoSetDimension:ALDimensionWidth toSize:kNoteWidth];
    [self.bgImageView autoSetDimension:ALDimensionHeight toSize:kNoteHeight];
    
    [self bringSubviewToFront:self.noteTextView];
}

- (void)addTarget:(id)target doubleTapNoteTextView:(SEL)action
{
    UITapGestureRecognizer* doubleGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action: action];
    
    doubleGesture.numberOfTapsRequired = 2;
    doubleGesture.numberOfTouchesRequired = 1;
    [self.noteTextView addGestureRecognizer:doubleGesture];
}

- (void)addTarget:(id)target singleTagpNoteTextView:(SEL)action
{
    UITapGestureRecognizer* singleGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action: action];
    singleGesture.numberOfTapsRequired = 1;
    singleGesture.numberOfTouchesRequired = 1;
    [self.noteTextView addGestureRecognizer:singleGesture];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.translatesAutoresizingMaskIntoConstraints = YES;
    [self.superview bringSubviewToFront:self];
    UITouch* touch = [touches anyObject];
    self.startedPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    CGPoint movedPoint = [touch locationInView:self];
    CGFloat offsetX = movedPoint.x - self.startedPoint.x;
    CGFloat offsetY = movedPoint.y - self.startedPoint.y;
    
    CGPoint newCenter = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
    
    CGFloat halfx = CGRectGetMidX(self.bounds);
    newCenter.x = MAX(halfx,newCenter.x);
    newCenter.x = MIN(self.superview.bounds.size.width - halfx, newCenter.x);
    
    float halfy = CGRectGetMidY(self.bounds);
    newCenter.y = MAX(halfy,newCenter.y);
    newCenter.y = MIN(self.superview.bounds.size.height - halfy, newCenter.y);
    
    self.center = newCenter;

    self.newPoint = newCenter;
    
    if (self.zIndex < zIndexNum) {
        zIndexNum += 1;
        self.zIndex = zIndexNum;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

+ (void)resetZindex:(NSInteger)zIndex
{
    zIndexNum = zIndex;
}

@end
