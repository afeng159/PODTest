//
//  ViewController.m
//  KDProductTool.h
//
//  Created by 啦啦啦 on 2017/9/10.
//  Copyright © 2017年 啦啦啦. All rights reserved.
//

#import "ViewController.h"
#import "KDProductToolView.h"
#import "CustomTextImageButton.h"

#define UIColorFromRGB(rgbValue)                                                                   \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                           \
green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                              \
blue:((float)(rgbValue & 0xFF)) / 255.0                                       \
alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController
{
    
    CustomTextImageButton *_speicialButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    KDProductToolView *_toolView = [[KDProductToolView alloc] initWithWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)
                                             andCommonTitles:@[@"出售中", @"售罄的", @"仓库中",@"出售中",@"出售中"]
                                           commonButtonBlock:^(NSInteger buttonIndex) {
//                                               [weak_self changeList:buttonIndex];
                                           }
                                                specialTitle:@"分组管理"
                                          specialButtonBlock:^(UIButton *button) {
//                                              [weak_self mannullyLoadTags];
                                          }];
    
    
    
    [self.view addSubview:_toolView];
    
    
    _speicialButton = [[CustomTextImageButton alloc]
                       initWithFrame:CGRectMake(self.view.frame.size.width / 3.0 * 2 + 2, 100, self.view.frame.size.width / 3.0 - 4, 36)];
    
    [_speicialButton setTitleColor:UIColorFromRGB(0x505050) forState:UIControlStateNormal];
    [_speicialButton setTitleColor:UIColorFromRGB(0xff5050) forState:UIControlStateHighlighted];
    [_speicialButton setImage:nil
                     forState:UIControlStateNormal];
    [_speicialButton setContentMode:UIViewContentModeCenter];
    
    _speicialButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    _speicialButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _speicialButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_speicialButton setEdgeInsetWithTitle:@"lall"];
    _speicialButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _speicialButton.titleLabel.numberOfLines = 1;
    _speicialButton.tag = SPECIAL_BUTTON_TAG;
    _speicialButton.userInteractionEnabled = YES;
    
    [_speicialButton addTarget:self
                        action:@selector(chooseTag:)
              forControlEvents:UIControlEventTouchUpInside];
//    self.specialButtonBlock = specialButtonBlock;
    [self.view addSubview:_speicialButton];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)chooseTag:(UIButton *)btn{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
