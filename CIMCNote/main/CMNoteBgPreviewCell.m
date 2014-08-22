//
//  CMNoteBgPreviewCell.m
//  CIMCNote
//
//  Created by cloudzou on 8/15/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMNoteBgPreviewCell.h"
#import "UIImage+MaskImage.h"

@interface CMNoteBgPreviewCell ()
@property (nonatomic, strong) UIImageView*      bgImageView;
@end

@implementation CMNoteBgPreviewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _bgImageView = [[UIImageView alloc] initForAutoLayout];
        [self addSubview:_bgImageView];
        [_bgImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [_bgImageView autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [_bgImageView autoSetDimension:ALDimensionHeight toSize:120];
        [_bgImageView autoSetDimension:ALDimensionWidth toSize:120];
    }
    return self;
}

- (void)setBackgroundImageIndex:(NSString *)index
{
    NSString* noteName = [NSString stringWithFormat:@"note%@preview.jpg",index];
    NSString* noteMaskName = [NSString stringWithFormat:@"note%@preview_mask.png",index];
    UIImage* image = [UIImage maskImage:[UIImage imageNamed:noteName] withMask:[UIImage imageNamed:noteMaskName]];
    [_bgImageView setImage:image];
}

@end
