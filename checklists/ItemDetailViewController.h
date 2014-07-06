//
//  ItemDetailViewController.h
//  checklists
//
//  Created by Mark Kenyon on 20/11/2013.
//  Copyright (c) 2013 Mark Kenyon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class CheckListItem;

@protocol ItemDetailViewControllerDelegate <NSObject>

- (void) ItemDetailViewControllerDidCancel: (ItemDetailViewController *) controller;

- (void) ItemDetailViewController: (ItemDetailViewController *) controller didFinishAddingItem: (CheckListItem *) item;

- (void) ItemDetailViewController: (ItemDetailViewController *) controller didFinishEditingItem: (CheckListItem *) item;

@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;

@property (nonatomic, strong) CheckListItem *itemToEdit;

@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;

-(IBAction) cancel;
-(IBAction) done;

@end
