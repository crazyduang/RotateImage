//
//  LYLRotateImage.h
//  RotateImage
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYLRotateImageDelegate <NSObject>

- (void)didSelectItemAtItem:(NSInteger)item;

@end



@interface LYLRotateImage : UIView


@property (nonatomic, strong) NSMutableArray *sourceArray;
@property (nonatomic, assign) id<LYLRotateImageDelegate> delegate;

@end
