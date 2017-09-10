//
//  KDProductToolView.m
//  Koudaitong
//
//  Created by Zhang ning on 16/1/4.
//  Copyright © 2016年 qima. All rights reserved.
//

#import "KDProductToolView.h"
#import "CustomTextImageButton.h"
#import "wsc_zui_define.h"
//#import "ZanIconFont.h"

@interface KDProductToolView ()

@property (strong, nonatomic) UIView *scrollSeperateView;
@property (assign, nonatomic) CGFloat buttonWidth;

@property (strong, nonatomic) CustomTextImageButton *speicialButton;

@property (copy, nonatomic) CommonButtonBlock commonButtonBlock;
@property (copy, nonatomic) SpecialButtonBlock specialButtonBlock;


@end

@implementation KDProductToolView

- (instancetype)initWithWithFrame:(CGRect)frame
                  andCommonTitles:(NSArray *)commonTitles
                commonButtonBlock:(CommonButtonBlock)commonButtonBlock {
    self = [super initWithFrame:frame];
    if (self) {
        if (!commonTitles.count) {
            return self;
        }
        
        [self createcommonButtonsWithTitles:commonTitles withFullLength:YES spacing:2.0];
        self.commonButtonBlock = commonButtonBlock;
    }
    return self;
}

- (instancetype)initWithWithFrame:(CGRect)frame
                  andCommonTitles:(NSArray *)commonTitles
                commonButtonBlock:(CommonButtonBlock)commonButtonBlock
                     specialTitle:(NSString *)specialTitle
               specialButtonBlock:(SpecialButtonBlock)specialButtonBlock {
    self = [super initWithFrame:frame];
    if (self) {
        if (!commonTitles.count && !specialTitle.length) {
            return self;
        }
        
        [self createcommonButtonsWithTitles:commonTitles
                             withFullLength:specialTitle.length < 1
                                    spacing:3.0];
        self.commonButtonBlock = commonButtonBlock;
        
        if (!specialTitle.length) {
            return self;
        }
        
        _speicialButton = [[CustomTextImageButton alloc]
                           initWithFrame:CGRectMake(DEVICE_WIDTH / 3.0 * 2 + 2, 0, DEVICE_WIDTH / 3.0 - 4, 36)];
        
        [_speicialButton setTitleColor:UIColorFromRGB(0x505050) forState:UIControlStateNormal];
        [_speicialButton setTitleColor:UIColorFromRGB(0xff5050) forState:UIControlStateHighlighted];
        [_speicialButton setImage:nil
                         forState:UIControlStateNormal];
        [_speicialButton setContentMode:UIViewContentModeCenter];
        
        _speicialButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        _speicialButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _speicialButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_speicialButton setEdgeInsetWithTitle:specialTitle];
        _speicialButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _speicialButton.titleLabel.numberOfLines = 1;
        _speicialButton.tag = SPECIAL_BUTTON_TAG;
        _speicialButton.userInteractionEnabled = YES;
        
        [_speicialButton addTarget:self
                            action:@selector(chooseTag:)
                  forControlEvents:UIControlEventTouchUpInside];
        self.specialButtonBlock = specialButtonBlock;
        [self addSubview:_speicialButton];
    }
    return self;
}

- (void)udpateSpecalButtonTitle:(NSString *)title {
    [self.speicialButton setEdgeInsetWithTitle:title];
}

- (void)updateSpecialButtonImage:(UIImage *)image {
    [self.speicialButton setImage:image forState:UIControlStateNormal];
}

- (void)createcommonButtonsWithTitles:(NSArray *)titles
                       withFullLength:(BOOL)onlyCommon
                              spacing:(NSInteger)spacing {
    NSUInteger count = titles.count;
    if (!count) {
        return;
    }
    self.buttonWidth = DEVICE_WIDTH / 3.0 * 2 / count;
    if (onlyCommon) {
        self.buttonWidth = DEVICE_WIDTH / count;
    }
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *button = [[UIButton alloc]
                            initWithFrame:CGRectMake(i * self.buttonWidth, 0, self.buttonWidth, self.frame.size.height)];
        button.tag = i;
        button.accessibilityTraits = UIAccessibilityTraitButton;
        [button setAccessibilityLabel:[titles objectAtIndex:i]];
        if (i == 0) {
            [button setAccessibilityValue:@"1"];
        } else {
            [button setAccessibilityValue:@"0"];
        }
        [button setTitle:[titles objectAtIndex:i] forState:UIControlStateNormal];
        UIColor *color = i ? UIColorFromRGB(0x505050) : UIColorFromRGB(colorRed);
        [button setTitleColor:color forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        [button addTarget:self
                   action:@selector(buttonAction:)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    if (!onlyCommon) {
        UILabel *separatorLabel =
        [[UILabel alloc] initWithFrame:CGRectMake(self.buttonWidth * count, 8, 0.6, 20)];
        separatorLabel.backgroundColor = UIColorFromRGB(colorGraySeparator);
        separatorLabel.tag = count;
        
        [self addSubview:separatorLabel];
    }
    
    self.scrollSeperateView = [[UIView alloc]
                               initWithFrame:CGRectMake((DEVICE_WIDTH / 3.0 * 2 / spacing - self.buttonWidth / 2.0) / 2, 34,
                                                        self.buttonWidth / 2.0, 2)];
    self.scrollSeperateView.backgroundColor = UIColorFromRGB(colorRed);
    [self addSubview:self.scrollSeperateView];
}

- (void)buttonAction:(UIButton *)button {
    if (_isEditing) {
        return;
    }
    [button setTitleColor:RGBA(255, 80, 80, 1.0) forState:UIControlStateNormal];
    for (UIView *subView in self.subviews) {
        if (subView != button && [subView isKindOfClass:[UIButton class]]) {
            [subView setAccessibilityValue:@"0"];
            [(UIButton *)subView setTitleColor:RGBA(85, 85, 85, 1.0) forState:UIControlStateNormal];
        }
    }
    [button setAccessibilityValue:@"1"];
    [self cancelChoiseDirectly];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.scrollSeperateView.frame =
                         CGRectMake(self.buttonWidth * button.tag + self.buttonWidth / 4, 34,
                                    self.buttonWidth / 2.0, 2);
                     }];
    
    if (self.commonButtonBlock) {
        self.commonButtonBlock(button.tag);
    }
}

- (void)chooseTag:(UIButton *)button {
    [self updateSpecialButtonImage:[UIImage imageNamed:@"down"]];
    if (self.specialButtonBlock) {
        self.specialButtonBlock(button);
    }
}

- (void)setCurrentIndex:(NSUInteger)index {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIColor *color = subView.tag == index ? RGBA(255, 80, 80, 1.0) : RGBA(85, 85, 85, 1.0);
            [(UIButton *)subView setTitleColor:color forState:UIControlStateNormal];
        }
    }
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         _scrollSeperateView.frame =
                         CGRectMake(self.buttonWidth * index + self.buttonWidth / 4, 34,
                                    self.buttonWidth / 2, 2);
                     }];
}

- (void)cancelChoiseDirectly {
    [self updateSpecialButtonImage:[UIImage imageNamed:@"down"]];
}

- (void)cancelChoise {
    [self updateSpecialButtonImage:[UIImage imageNamed:@"down"]];
}

@end
