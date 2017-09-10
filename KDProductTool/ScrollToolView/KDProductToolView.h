//
//  KDProductToolView.h
//  Koudaitong
//
//  Created by Zhang ning on 16/1/4.
//  Copyright © 2016年 qima. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SPECIAL_BUTTON_TAG 99901

typedef void (^CommonButtonBlock)(NSInteger);
typedef void (^SpecialButtonBlock)(UIButton *);

@interface KDProductToolView : UIView

@property (assign, nonatomic) BOOL isEditing;

- (instancetype)initWithWithFrame:(CGRect)frame
                  andCommonTitles:(NSArray *)commonTitles
                commonButtonBlock:(CommonButtonBlock)commonButtonBlock;

- (instancetype)initWithWithFrame:(CGRect)frame
                  andCommonTitles:(NSArray *)commonTitles
                commonButtonBlock:(CommonButtonBlock)commonButtonBlock
                     specialTitle:(NSString *)specialTitle
               specialButtonBlock:(SpecialButtonBlock)specialButtonBlock;


/**
   改变特殊btn的标题

 @param title 标题
 */
- (void)udpateSpecalButtonTitle:(NSString *)title;

/**
    改变特殊btn的图片

 @param image 图片
 */
- (void)updateSpecialButtonImage:(UIImage *)image;


- (void)cancelChoiseDirectly;


- (void)cancelChoise;


/**
   设置按钮为选择状态

 @param index 索引  从0开始
 */
- (void)setCurrentIndex:(NSUInteger)index;

@end
