//
//  CustomView.m
//  MacAAA
//
//  Created by 老岳 on 16/5/14.
//  Copyright © 2016年 LYue. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    [self registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
}

BOOL canDrag = NO;
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSPasteboard *pb =[sender draggingPasteboard];
    NSArray *array=[pb types];
    if ([array containsObject:NSFilenamesPboardType]) {
        
        NSArray* allFileUrls = [pb propertyListForType:NSFilenamesPboardType];
        NSArray* array = [allFileUrls filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension.lowercaseString IN %@", @[@"car"]]];
        if (array.count > 0) {
            canDrag = YES;
            return NSDragOperationCopy;
        }
    }
    return NSDragOperationNone;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender
{
    if (canDrag) {
        return NSDragOperationCopy;
    }
    return NSDragOperationNone;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender
{
    NSArray* allFileUrls = [[sender draggingPasteboard] propertyListForType:NSFilenamesPboardType];
    NSArray* array = [allFileUrls filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pathExtension.lowercaseString IN %@", @[@"car"]]];

    if (array.count>1) {
        NSAlert *alert = [NSAlert alertWithMessageText:@"别拖太多的文件，只拖一个.car文件" defaultButton:@"ok" alternateButton:nil otherButton:nil informativeTextWithFormat:@"aaa"];
        [alert runModal];
    }
    else if (array.count > 0) {
        [self.delegate customViewDidDragEnd:self withFileUrl:array[0]];
    }
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    return YES;
}

@end
