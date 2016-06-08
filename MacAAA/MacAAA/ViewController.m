//
//  ViewController.m
//  MacAAA
//
//  Created by 老岳 on 16/5/4.
//  Copyright © 2016年 LYue. All rights reserved.
//

#define DedaultStr @"将.car的文件拖动灰色区域"

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()<CusomViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //想让一个window固定大小，在sb中把resize去掉即可。
    
    self.label.stringValue = DedaultStr;

    CustomView *v = [[CustomView alloc] initWithFrame:NSMakeRect(0, 80, self.view.bounds.size.width, self.view.bounds.size.height-80)];
    v.wantsLayer = YES;
    v.delegate = self;
    v.layer.backgroundColor = [[NSColor grayColor] CGColor];
    v.alphaValue = 0.6;
    [self.view addSubview:v];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void)customViewDidDragEnd:(CustomView *)customView withFileUrl:(NSString *)url;
{
    self.label.stringValue = url;
}

- (IBAction)buttonAction:(id)sender
{
//    system("mv /Users/yuedong/Desktop/111/1.jpg /Users/yuedong/Desktop/111/2.jpg");\
    
    if ([self.label.stringValue isEqualToString:DedaultStr]) {
        return;
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/生成car图片的目录", [self.label.stringValue stringByDeletingLastPathComponent]];
    NSString *result = [self runCmdPath:@"/bin/mkdir" arguments:@[path]];
    NSLog(@"result ---- %@", result);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self runCmdPath:[self carToolPtah] arguments:@[self.label.stringValue, path]];
    });
}

- (NSString *)carToolPtah
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [NSString stringWithFormat: @"%@/Contents/Resources/cartool", mainBundle.bundlePath];
    return path;
}

- (NSString *)runCmdPath:(NSString *)path arguments:(NSArray *)args
{
    NSTask *task = [[NSTask alloc] init];
    
    [task setLaunchPath:path];
    [task setArguments:args];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardInput:[NSPipe pipe]];
    [task setStandardOutput: pipe];
    
    NSFileHandle *file = [pipe fileHandleForReading];
    
    [task launch];
    [task waitUntilExit];
    
    NSData *data;
    data = [file readDataToEndOfFile];
    
    NSString *string;
    string = [[NSString alloc] initWithData: data
                                   encoding: NSUTF8StringEncoding];
    return string;
}


@end
