//
//  CheckListItem.h
//  Checklists
//
//  Created by Mark Kenyon on 11/11/2013.
//  Copyright (c) 2013 Mark Kenyon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL checked;

- (void) toggleChecked;

@end
