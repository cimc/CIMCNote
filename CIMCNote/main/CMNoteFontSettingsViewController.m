//
//  CMNoteFontSettingsViewController.m
//  CIMCNote
//
//  Created by cloudzou on 8/19/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMNoteFontSettingsViewController.h"

#define kFontCellIdentifier @"FontCellIdentifier"

@interface CMNoteFontSettingsViewController ()
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* fonts;

@end

@implementation CMNoteFontSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fonts = @[@{@"size":@(12),@"text":@"小号"},@{@"size":@(15),@"text":@"小号"}];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.fonts.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* FontCellIdentifier = kFontCellIdentifier;
    UITableViewCell* cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:FontCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FontCellIdentifier];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:[self.fonts[indexPath.row][@"size"] integerValue]];
    return cell;
}




@end
