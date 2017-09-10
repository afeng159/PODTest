//
//  CustomTextImageButton.h
//  Koudaitong
//
//  Created by Zhou Shaolin on 12/3/14.
//  Copyright (c) 2014 qima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextImageButton : UIButton

-(void)setTitle:(NSString *)title withHint:(NSString *)hint;
-(void)setEdgeInsetWithTitle:(NSString*)title;
@end
