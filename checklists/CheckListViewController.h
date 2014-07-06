//
//  CheckListViewController.h
//  Checklists
//
//  Created by Mark Kenyon on 20/10/2013.
//  Copyright (c) 2013 Mark Kenyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

@class Checklist;

@interface CheckListViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end
