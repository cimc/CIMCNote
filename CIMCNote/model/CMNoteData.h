//
//  CMNoteData.h
//  CIMCNote
//
//  Created by cloudzou on 8/14/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMNoteData : NSObject<NSCoding>

- (id)initWithContent:(NSString*)content zIndex:(NSInteger)zIndex pointX:(CGFloat)pointX pointY:(CGFloat)pointY bgNum:(NSInteger)bgNum;

@property (nonatomic, strong) NSString* content;
@property (nonatomic, assign) NSInteger zIndex;
@property (nonatomic, assign) CGFloat pointX;
@property (nonatomic, assign) CGFloat pointY;
@property (nonatomic, assign) NSInteger bgNum;

@end
