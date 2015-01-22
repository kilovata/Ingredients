//
//  UIPlaceHolderTextView.h
//  Ingredients
//
//  Created by Sveta Kilovata on 22/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
