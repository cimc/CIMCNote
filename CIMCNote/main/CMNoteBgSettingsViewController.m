//
//  CMNoteBgSettingsViewController.m
//  CIMCNote
//
//  Created by cloudzou on 8/15/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import "CMNoteBgSettingsViewController.h"
#import "CMNoteBgPreviewCell.h"

#define kCellHeight 128.0f
#define kBgCellIdentifier @"BgCellIdentifier"

@interface CMNoteBgSettingsViewController ()

@property (nonatomic, strong) NSMutableArray* bgImageArray;
@property (nonatomic, strong) UITableView* tableView;

@end

@implementation CMNoteBgSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bgImageArray = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3", nil];
    CGRect rect = CGRectMake(0, 0, 128, 400);
    self.tableView = [[UITableView alloc] initWithFrame:rect];
    self.tableView.showsVerticalScrollIndicator = YES;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bgImageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* BgCellIdentifier = kBgCellIdentifier;
    CMNoteBgPreviewCell* cell = (CMNoteBgPreviewCell*)[tableView dequeueReusableCellWithIdentifier:BgCellIdentifier];
    
    if (cell == nil) {
        cell = [[CMNoteBgPreviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BgCellIdentifier];
    }
    [cell setBackgroundImageIndex:self.bgImageArray[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* bgNum = [self.bgImageArray objectAtIndex:[indexPath row]];
    [self.delegate didSelectNoteBgSetting: bgNum];
}

@end
