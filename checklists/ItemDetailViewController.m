//
//  ItemDetailViewController.m
//  checklists
//
//  Created by Mark Kenyon on 20/11/2013.
//  Copyright (c) 2013 Mark Kenyon. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "CheckListItem.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.doneBarButton.enabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.textField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel {
    [self.delegate ItemDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    
    if (self.itemToEdit == nil) {
        CheckListItem *item = [[CheckListItem alloc] init];
        item.text = self.textField.text;
        item.checked = NO;
        
        [self.delegate ItemDetailViewController:self didFinishAddingItem:item];
    } else {
        self.itemToEdit.text = self.textField.text;
        
        [self.delegate ItemDetailViewController:self didFinishEditingItem:self.itemToEdit];
        
    }
    
}

#pragma mark - Table View Delegate Methods

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark -
#pragma mark Textfield Delegate

- (BOOL) textField: (UITextField *) theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([newText length] > 0) {
        self.doneBarButton.enabled = YES;
    } else {
        self.doneBarButton.enabled = NO;
    }
    
    return YES;
    
}


@end
