//
//  ListDetailViewController.m
//  checklists
//
//  Created by Mark Kenyon on 07/01/2014.
//  Copyright (c) 2014 Mark Kenyon. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

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
    
    if (self.checklistToEdit != nil) {
        self.title = @"Edit Checklist";
        self.textField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)cancel {
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    if (self.checklistToEdit == nil) {
        Checklist *checklist = [[Checklist alloc]init];
        checklist.name = self.textField.text;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }else {
        self.checklistToEdit.name = self.textField.text;
        [self.delegate listDetailViewController:self didFinishEditingChecklist: self.checklistToEdit];
    }
}

- (NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

- (BOOL) textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

@end
