//
//  CustomView.h
//  MacAAA
//
//  Created by 老岳 on 16/5/14.
//  Copyright © 2016年 LYue. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@protocol CusomViewDelegate;
@interface CustomView : NSView

@property (weak, nonatomic) id<CusomViewDelegate>delegate;
@end



@protocol CusomViewDelegate <NSObject>

- (void)customViewDidDragEnd:(CustomView *)customView withFileUrl:(NSString *)url;

@end
