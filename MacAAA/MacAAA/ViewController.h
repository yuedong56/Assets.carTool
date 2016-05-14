//
//  ViewController.h
//  MacAAA
//
//  Created by 老岳 on 16/5/4.
//  Copyright © 2016年 LYue. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *pathField;
@property (weak) IBOutlet NSTextField *label;

@property (weak) IBOutlet NSButton *button;
- (IBAction)buttonAction:(id)sender;

@end

