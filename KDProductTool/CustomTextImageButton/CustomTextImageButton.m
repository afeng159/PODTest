//
//  CustomTextImageButton.m
//  Koudaitong
//
//  Created by Zhou Shaolin on 12/3/14.
//  Copyright (c) 2014 qima. All rights reserved.
//

#import "CustomTextImageButton.h"

@implementation CustomTextImageButton

/**
 
 
 换图和字的位置
 */
- (void)setEdgeInsetWithTitle:(NSString*)title {
    [self setTitle:title forState:UIControlStateNormal];
    //[self sizeToFit];
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width + 4, 0, -self.titleLabel.frame.size.width - 4);
}



- (void)setTitle:(NSString *)title withHint:(NSString *)hint {
    
    int titleLabelWidth = self.frame.size.width - self.imageView.frame.size.width - 8;
    CGSize textSize = [title boundingRectWithSize:CGSizeMake(LINE_MAX, 28)
                                         options:NSStringDrawingTruncatesLastVisibleLine
                                      attributes:@{NSFontAttributeName:self.titleLabel.font}
                                         context:nil].size;
    if (textSize.width > 2 * titleLabelWidth) {
        [self setTitle:hint forState:UIControlStateNormal];
    } else {
        [self setTitle:title forState:UIControlStateNormal];
    }
    if (self.titleLabel.frame.size.width > titleLabelWidth) {
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, titleLabelWidth, self.titleLabel.frame.size.height);
    }
    
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.frame.size.width, 0, self.imageView.frame.size.width);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.frame.size.width + 4, 0, -self.titleLabel.frame.size.width - 4);
}

- (BOOL)isAccessibilityElement {
    return YES;
}

- (UIAccessibilityTraits)accessibilityTraits {
    return UIAccessibilityTraitButton;
}

- (NSString *)accessibilityValue {
    return [NSString stringWithFormat:@"%@", self.titleLabel.text];
}

- (NSString *)accessibilityLabel {
    return [NSString stringWithFormat:@"%@", self.titleLabel.text];
}
@end
