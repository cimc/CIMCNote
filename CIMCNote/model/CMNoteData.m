//
//  CMNoteData.m
//  CIMCNote
//
//  Created by cloudzou on 8/14/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMNoteData.h"

#pragma mark NSCoding

#define kNoteContent    @"content"
#define kNotezIndex @"zIndex"
#define kNotePointX @"pointX"
#define kNotePointY @"pointY"
#define kNoteBgNum  @"bgNum"

@implementation CMNoteData

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.content forKey:kNoteContent];
    [aCoder encodeInteger:self.zIndex forKey:kNotezIndex];
    [aCoder encodeFloat:self.pointX forKey:kNotePointX];
    [aCoder encodeFloat:self.pointY forKey:kNotePointY];
    [aCoder encodeInteger:self.bgNum forKey:kNoteBgNum];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    NSString* content = [aDecoder decodeObjectForKey:kNoteContent];
    NSInteger zIndex = [aDecoder decodeIntegerForKey:kNotezIndex];
    CGFloat pointX = [aDecoder decodeFloatForKey:kNotePointX];
    CGFloat pointY = [aDecoder decodeFloatForKey:kNotePointY];
    NSInteger bgNum = [aDecoder decodeIntegerForKey:kNoteBgNum];
    return [self initWithContent:content zIndex:zIndex pointX:pointX pointY:pointY bgNum:bgNum];
}

- (id)initWithContent:(NSString*)content zIndex:(NSInteger)zIndex pointX:(CGFloat)pointX pointY:(CGFloat)pointY bgNum:(NSInteger)bgNum
{
    if ((self = [super init])) {
        _content = [content copy];
        _zIndex = zIndex;
        _pointX = pointX;
        _pointY = pointY;
        _bgNum = bgNum;
    }
    return self;
}

@end
