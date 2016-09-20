//
//  LYLRotateImageCell.m
//  RotateImage
//
//  Created by admin on 16/9/14.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LYLRotateImageCell.h"

@implementation LYLRotateImageCell


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.rotateImage = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.rotateImage];
    }
    return self;
}





@end
