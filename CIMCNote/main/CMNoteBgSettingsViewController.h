//
//  CMNoteBgSettingsViewController.h
//  CIMCNote
//
//  Created by cloudzou on 8/15/14.
//  Copyright (c) 2014 rawray. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CMNoteBgSettingsDelegate <NSObject>
@optional
- (void)didSelectNoteBgSetting:(NSString*)bgNum;
@end

@interface CMNoteBgSettingsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) id<CMNoteBgSettingsDelegate> delegate;
@end
