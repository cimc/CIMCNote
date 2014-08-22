//
//  CMMainViewController.m
//  CIMCNote
//
//  Created by duguo on 8/5/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMMainViewController.h"
#import "CMNoteView.h"
#import "CMEditMaskView.h"
#import "CMNOteData.h"
#import "WYPopoverController.h"
#import "CMNoteBgSettingsViewController.h"

#define kNoteData @"noteData"


@interface CMMainViewController () <CMEditMaskViewDelegate,WYPopoverControllerDelegate,CMNoteBgSettingsDelegate>

@property (nonatomic, strong) WYPopoverController*   settingsPopoverController;
@property (nonatomic, strong) NSMutableArray*  noteArray;
@property (nonatomic, strong) NSMutableArray*  rectArray;
@property (nonatomic, strong) CMNoteView* currentEditNoteView;
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation CMMainViewController

- (id)init
{
    if (self = [super init]) {
        _noteArray = [NSMutableArray array];
        _rectArray = [NSMutableArray array];
        _isEditing = FALSE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1.jpg"]];
    
    UIButton* newNoteButton = [[UIButton alloc] initForAutoLayout];
    [self.view addSubview:newNoteButton];
    
    [newNoteButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40.0f];
    [newNoteButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:40.0f];
    
    [newNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonNew92.png"] forState:UIControlStateNormal];
    [newNoteButton setBackgroundImage:[UIImage imageNamed:@"buttonNew92.png"] forState:UIControlStateSelected];
    [newNoteButton addTarget:self action:@selector(createNoteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self loadNoteViews];
}

- (void)loadNoteViews
{
    NSArray* array = [self loadNoteArrayData];
    if (array != NULL && array.count != 0){
        
        NSArray* resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            CMNoteData* noteData1 = (CMNoteData*)obj1;
            CMNoteData* noteData2 = (CMNoteData*)obj2;
            NSNumber* zIndex1 = [NSNumber numberWithInt:noteData1.zIndex];
            NSNumber* zIndex2 = [NSNumber numberWithInt:noteData2.zIndex];
            
            NSComparisonResult result = [zIndex1 compare:zIndex2];
            
            return result == NSOrderedDescending;
        }];
        
        CMNoteData* noteData = (CMNoteData*)[resultArray lastObject];
        
        [CMNoteView resetZindex:noteData.zIndex];
        
        for (CMNoteData* noteData in resultArray) {
            CGPoint point = CGPointMake(noteData.pointX, noteData.pointY);
            
            CMNoteView* noteView = [[CMNoteView alloc] initWithPoint:point content:noteData.content zIndex:noteData.zIndex bgNum:noteData.bgNum];
            noteView.center = CGPointMake(noteData.pointX, noteData.pointY);
            
            [noteView addTarget:self doubleTapNoteTextView:@selector(handleNoteTextViewDoubleTapGesture:)];
            [noteView addTarget:self singleTagpNoteTextView:@selector(handleNoteTextViewSingleTapGesture:)];
            
            [self.view addSubview:noteView];
            [self.noteArray addObject:noteView];
        }
    }

}

- (void)createNoteButtonAction:(id)sender
{
    [self.noteArray addObject:[self createNoteView]];
}


- (UIView*)createNoteView
{
    CMNoteView* noteView = [[CMNoteView alloc] initForAutoLayout];
    [self.view addSubview:noteView];
    
    CMNoteView* lastNoteView = [self.noteArray lastObject];
    if (lastNoteView)
    {
        [noteView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:lastNoteView withOffset:20];
        [noteView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:lastNoteView withOffset:20];
        
        CGPoint lastCenter = lastNoteView.center;
        lastCenter.x += 20.0f;
        lastCenter.y += 20.0f;
        
        noteView.newPoint = lastCenter;
    }
    else
    {
        [noteView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [noteView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        
        noteView.newPoint = CGPointMake(220.0f, 220.f);
    }
    
    [noteView autoSetDimension:ALDimensionWidth toSize:400];
    [noteView autoSetDimension:ALDimensionHeight toSize:400];
    [self.view bringSubviewToFront:noteView];

    [noteView addTarget:self doubleTapNoteTextView:@selector(handleNoteTextViewDoubleTapGesture:)];
    [noteView addTarget:self singleTagpNoteTextView:@selector(handleNoteTextViewSingleTapGesture:)];

    return noteView;
}

- (IBAction)handleNoteTextViewSingleTapGesture:(UITapGestureRecognizer*)gestureRecongnizer
{
    NSLog(@"single tap");
}


- (IBAction)handleNoteTextViewDoubleTapGesture:(UITapGestureRecognizer*)gestureRecongnizer
{
    if (!_isEditing) {
        _isEditing = TRUE;
        
        _currentEditNoteView = (CMNoteView*)gestureRecongnizer.view.superview;
        [_currentEditNoteView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
        
        [_currentEditNoteView becomeFirstResponder];
        
        CMEditMaskView* editMaskView = [[CMEditMaskView alloc] initForAutoLayout];
        editMaskView.delegate = self;
        [self.view addSubview:editMaskView];
        
        
        [editMaskView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
        [editMaskView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
        [editMaskView autoSetDimension:ALDimensionWidth toSize:self.view.frame.size.height];
        [editMaskView autoSetDimension:ALDimensionHeight toSize:self.view.frame.size.width];
        
        [UIView animateWithDuration:0.3f animations:^{
            [_currentEditNoteView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
            [_currentEditNoteView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
            [_currentEditNoteView autoSetDimension:ALDimensionWidth toSize:400];
            [_currentEditNoteView autoSetDimension:ALDimensionHeight toSize:400];
            
            [self.view bringSubviewToFront:_currentEditNoteView];
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)saveNoteArrayData
{
    NSMutableArray* array = [NSMutableArray array];
    for (CMNoteView* noteView in _noteArray) {
        CMNoteData* data = [[CMNoteData alloc] initWithContent:noteView.originContent
                                                        zIndex:noteView.zIndex pointX:noteView.newPoint.x pointY:noteView.newPoint.y bgNum:noteView.bgNum];
        [array addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:array] forKey:kNoteData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray*)loadNoteArrayData
{
    NSData* data = [[NSUserDefaults standardUserDefaults] objectForKey:kNoteData];
    NSArray* noteArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return noteArray;
}

#pragma mark CMEditMaskViewDelegate

- (void)saveNoteTextAction:(CMEditMaskView *)editMaskView
{
    [UIView animateWithDuration:0.3f animations:^{
        [editMaskView removeFromSuperview];
        [self.view addSubview:_currentEditNoteView];
        [_currentEditNoteView updateOriginContent];
        [_currentEditNoteView resignFirstResponder];
        [_currentEditNoteView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [_currentEditNoteView restoreCenter];
    }];
    [_currentEditNoteView addTarget:self doubleTapNoteTextView:@selector(handleNoteTextViewDoubleTapGesture:)];
    [self saveNoteArrayData];
    _isEditing = FALSE;
}

- (void)cancelNoteTextAction:(CMEditMaskView *)editMaskView
{
    [UIView animateWithDuration:0.3f animations:^{
        [editMaskView removeFromSuperview];
        [self.view addSubview:_currentEditNoteView];
        [_currentEditNoteView restoreOriginContent];
        [_currentEditNoteView resignFirstResponder];
        [_currentEditNoteView setTranslatesAutoresizingMaskIntoConstraints:YES];
        [_currentEditNoteView restoreCenter];
    }];
    [_currentEditNoteView addTarget:self doubleTapNoteTextView:@selector(handleNoteTextViewDoubleTapGesture:)];
    _isEditing = FALSE;
}

- (void)deleteNoteTextAction:(CMEditMaskView *)editMaskView
{
    [UIView animateWithDuration:0.3f animations:^{
        [editMaskView removeFromSuperview];
        [_currentEditNoteView removeFromSuperview];
    }];
    [_noteArray removeObject:_currentEditNoteView];
    
    [self saveNoteArrayData];
    _isEditing = FALSE;
}

- (void)setNoteTextAction:(CMEditMaskView *)editMaskView
{
    if (self.settingsPopoverController == nil)
    {
        CMNoteBgSettingsViewController* settingsViewController = [[CMNoteBgSettingsViewController alloc] init];
        settingsViewController.preferredContentSize  = CGSizeMake(128, 450);
        settingsViewController.title = @"";
        settingsViewController.delegate = self;
        
        [settingsViewController.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(settingsViewControllerDone:)]];
        
        settingsViewController.modalInPopover = NO;
        
        UINavigationController *contentViewController = [[UINavigationController alloc] initWithRootViewController:settingsViewController];
        
        _settingsPopoverController = [[WYPopoverController alloc] initWithContentViewController:contentViewController];
        _settingsPopoverController.delegate = self;
        _settingsPopoverController.passthroughViews = @[editMaskView.propertyNoteButton];
        _settingsPopoverController.popoverLayoutMargins = UIEdgeInsetsMake(10, 10, 10, 10);
        //_settingsPopoverController.modalPresentationStyle = UIModalPresentationFormSheet;
        _settingsPopoverController.wantsDefaultContentAppearance = NO;
        
            [_settingsPopoverController presentPopoverFromRect:editMaskView.propertyNoteButton.bounds
                                                       inView:editMaskView.propertyNoteButton
                                     permittedArrowDirections:WYPopoverArrowDirectionAny
                                                     animated:YES
                                                      options:WYPopoverAnimationOptionFadeWithScale];
    }
    else
    {
        [self settingsViewControllerDone:nil];
    }
}

- (void)settingsViewControllerDone:(id)sender
{
    [_settingsPopoverController dismissPopoverAnimated:YES completion:^{
        [self popoverControllerDidDismissPopover:_settingsPopoverController];
    }];
}

#pragma mark WYPopoverControllerDelegate

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerShouldDismissPopover");
    return YES;
}

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)controller
{
    NSLog(@"popoverControllerDidDismissPopover");
    _settingsPopoverController.delegate = nil;
    _settingsPopoverController = nil;
}

#pragma mark CMNoteBgSettingsDelegate

- (void)didSelectNoteBgSetting:(NSString *)bgNum
{
    [_currentEditNoteView updateBgImageView:bgNum];
}

#pragma mark keyboard
- (void)keyboardWillShow:(NSNotification*)notifiy
{
    if (!_isEditing) {
        [_currentEditNoteView resignFirstResponder];
    }
}


@end
