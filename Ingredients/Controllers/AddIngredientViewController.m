//
//  AddIngredientViewController.m
//  Ingredients
//
//  Created by kilovata-iMac on 21/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import "AddIngredientViewController.h"
#import "IngredientsModel.h"

@interface AddIngredientViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewText;
@property (weak, nonatomic) IBOutlet UIView *viewText;
@property (strong, nonatomic) IngredientsModel *model;

@end


@implementation AddIngredientViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.model = [IngredientsModel new];
    self.textFieldTitle.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textViewText.autocorrectionType = UITextAutocorrectionTypeNo;
    CGFloat offset = 25.f;
    self.textViewText.textContainerInset = UIEdgeInsetsMake(10.f, offset, 10.f, offset);
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.text.length > 0) {
        [self.model addIngredientWithTitle:textField.text];
    }
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    CGRect rectViewText = self.viewText.frame;
    CGRect rectTextView = textView.frame;
    rectViewText.origin.y = 64.f;
    rectTextView.size.height = 219.f;
    [UIView animateWithDuration:0.3f animations:^{
        self.viewText.frame = rectViewText;
        textView.frame = rectTextView;
    }];
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    CGRect rectViewText = self.viewText.frame;
    CGRect rectTextView = textView.frame;
    rectViewText.origin.y = 175.f;
    rectTextView.size.height = 324.f;
    [UIView animateWithDuration:0.3f animations:^{
        self.viewText.frame = rectViewText;
        textView.frame = rectTextView;
    }];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (range.length==0) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    return YES;
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


@end
