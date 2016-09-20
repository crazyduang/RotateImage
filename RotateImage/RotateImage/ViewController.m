//
//  ViewController.m
//  RotateImage
//
//  Created by admin on 16/9/13.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ViewController.h"
#import "LYLRotateImage.h"

@interface ViewController ()<LYLRotateImageDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /*
     http://p4.music.126.net/NnxcNzWLHMs_ibmVZRfANQ==/3445869446541953.jpg
     http://p4.music.126.net/xbAhnNKU7P5VkSMFhIyiVA==/3265549556581177.jpg
     http://p3.music.126.net/gyTABngZG2adrbgEU7bluw==/3265549552949176.jpg
     http://p4.music.126.net/_LYoUmaH4XRWiv94VsbfPQ==/3417282145422712.jpg
     http://p3.music.126.net/ILPSZz723oUC0Jgz6WFqgg==/1408474407250516.jpg
     http://p4.music.126.net/eZZk6tz-TI53KNC7jbysfg==/3420580698415397.jpg
     http://p3.music.126.net/33UF4-9UsarHdVvcqExqGw==/2946691186766226.jpg
     */
    
    LYLRotateImage *rotateImage = [[LYLRotateImage alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.21f)];
    rotateImage.delegate = self;
    rotateImage.sourceArray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"2.jpg"], [UIImage imageNamed:@"3.jpg"], [UIImage imageNamed:@"4.png"], [UIImage imageNamed:@"5.jpg"], [UIImage imageNamed:@"6.jpg"], [UIImage imageNamed:@"7.jpg"], nil];
    [self.view addSubview:rotateImage];
}

- (void)didSelectItemAtItem:(NSInteger)item{
    NSLog(@"item == %ld", item);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
