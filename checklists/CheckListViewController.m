//
//  CheckListViewController.m
//  Checklists
//
//  Created by Mark Kenyon on 20/10/2013.
//  Copyright (c) 2013 Mark Kenyon. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"
#import "Checklist.h"


@interface CheckListViewController ()



@end

@implementation CheckListViewController {
    NSMutableArray *_items;
}

-(NSString *) documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

- (NSString *) dataFilePath {
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

- (void) saveCheckListItems {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:_items forKey:@"ChecklistItems"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void) loadCheckListItems {
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        
        _items = [unarchiver decodeObjectForKey:@"ChecklistItems"];
        [unarchiver finishDecoding];
    }else {
        _items = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self loadCheckListItems];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = self.checklist.name;
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
    }else if ([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *) navigationController.topViewController;
        controller.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = _items [indexPath.row];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) configureCheckmarkForCell: (UITableViewCell *) cell withCheckListItem: (CheckListItem *) item {
    
    UILabel *label = (UILabel *) [cell viewWithTag:1001];
    
    if (item.checked) {
        label.text =@"√";
    }else{
        label.text =@"";
    }
}

- (void) configureTextForCell: (UITableViewCell *)cell withCheckListItem: (CheckListItem *) item {
    UILabel *label = (UILabel *) [cell viewWithTag:1000];
    label.text = item.text;
}

#pragma mark -
#pragma mark Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    CheckListItem *item = _items [indexPath.row];
    
    [self configureTextForCell:cell withCheckListItem:item];
    [self configureCheckmarkForCell:cell withCheckListItem:item];
     
    return cell;

}

#pragma mark -
#pragma mark Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    CheckListItem *item = _items [indexPath.row];
    
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell withCheckListItem:item];
    
    [self saveCheckListItems];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_items removeObjectAtIndex:indexPath.row];
    
    [self saveCheckListItems];
    
    NSArray *indexPaths = @[indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark ItemDetailViewController Delegate

- (void) ItemDetailViewControllerDidCancel:(ItemDetailViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) ItemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(CheckListItem *)item {
    NSInteger newRowIndex = [_items count];
    [_items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) ItemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(CheckListItem *)item {
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [self configureTextForCell:cell withCheckListItem:item];
   // [_items addObject:item];
    
    [self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
