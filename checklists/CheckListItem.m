//
//  CheckListItem.m
//  Checklists
//
//  Created by Mark Kenyon on 11/11/2013.
//  Copyright (c) 2013 Mark Kenyon. All rights reserved.
//

#import "CheckListItem.h"

@implementation CheckListItem

- (id) initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.text = [aDecoder decodeObjectForKey:@"Text"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.text forKey:@"Text"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

- (void) toggleChecked{
    self.checked = !self.checked;
}

@end
