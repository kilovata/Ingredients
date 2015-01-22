//
//  AddIngredientViewController.m
//  Ingredients
//
//  Created by kilovata-iMac on 21/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import "AddIngredientViewController.h"
#import "IngredientsModel.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "Ingredient.h"

@interface AddIngredientViewController () {
    NSInteger danger;
}

@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextView *textViewText;
@property (weak, nonatomic) IBOutlet UIView *viewText;
@property (strong, nonatomic) IngredientsModel *model;
@property (strong, nonatomic) Ingredient *ingredient;
@property (weak, nonatomic) IBOutlet UIButton *buttonDanger1;
@property (weak, nonatomic) IBOutlet UIButton *buttonDanger2;
@property (weak, nonatomic) IBOutlet UIButton *buttonDanger3;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

- (IBAction)actionDanger:(id)sender;


@end


@implementation AddIngredientViewController


- (id)initWithIngredient:(Ingredient*)ingredient {
    
    if (self = [super init]) {
        self.ingredient = ingredient;
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    danger = 0;
    self.model = [IngredientsModel new];
    self.textFieldTitle.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textViewText.autocorrectionType = UITextAutocorrectionTypeNo;
    CGFloat offset = 25.f;
    self.textViewText.textContainerInset = UIEdgeInsetsMake(10.f, offset, 10.f, offset);
    
    if (self.ingredient) {
        if (self.ingredient.title) {
            self.textFieldTitle.text = self.ingredient.title;
        }
        if (self.ingredient.text) {
            self.textViewText.text = self.ingredient.text;
        }
        if (self.ingredient.danger) {
            NSInteger tag = [self.ingredient.danger integerValue];
            switch (tag) {
                case 1:
                    [self.buttonDanger1 setSelected:YES];
                    break;
                case 2:
                    [self.buttonDanger2 setSelected:YES];
                    break;
                case 3:
                    [self.buttonDanger3 setSelected:YES];
                    break;
                    
                default:
                    break;
            }
        }
    }
    
    CGSize size = self.textViewText.contentSize;
    CGFloat height = size.height + self.textViewText.frame.origin.y + self.viewText.frame.origin.y;
    self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, height);
}


- (void)actionSave {
    
    if (self.textFieldTitle.text.length > 0) {
        if (self.ingredient) {
            [self.model updateIngredient:self.ingredient withTitle:self.textFieldTitle.text andText:self.textViewText.text andDanger:danger];
        } else {
            [self.model addIngredientWithTitle:self.textFieldTitle.text andText:self.textViewText.text andDanger:danger];
        }
    }
    [SVProgressHUD showSuccessWithStatus:@"Вещество сохранено"];
    [self.textFieldTitle resignFirstResponder];
    [self.textViewText resignFirstResponder];
}


- (IBAction)actionDanger:(id)sender {
    
    if (sender == self.buttonDanger1) {
        
        danger = 1;
        [self.buttonDanger1 setSelected:YES];
        [self.buttonDanger2 setSelected:NO];
        [self.buttonDanger3 setSelected:NO];
    } else if (sender == self.buttonDanger2) {
        
        danger = 2;
        [self.buttonDanger1 setSelected:NO];
        [self.buttonDanger2 setSelected:YES];
        [self.buttonDanger3 setSelected:NO];
    } else if (sender == self.buttonDanger3) {
        
        danger = 3;
        [self.buttonDanger1 setSelected:NO];
        [self.buttonDanger2 setSelected:NO];
        [self.buttonDanger3 setSelected:YES];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(actionSave)];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (self.textFieldTitle.text.length > 1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(actionSave)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    return YES;
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    //[self.view insertSubview:self.viewText aboveSubview:self.scroll];
    
    CGRect rectViewText = self.viewText.frame;
    CGRect rectTextView = textView.frame;
    rectViewText.origin.y = 0;
    rectTextView.size.height = 207.f;
    rectViewText.size.height = rectTextView.origin.y + rectTextView.size.height;
    [UIView animateWithDuration:0.3f animations:^{
        
        //self.scroll.frame = rectViewText;
        self.scroll.contentSize = rectViewText.size;
        self.viewText.frame = rectViewText;
        textView.frame = rectTextView;
    }];
    
    textView.scrollEnabled = YES;
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    CGRect rectViewText = self.viewText.frame;
    CGRect rectTextView = textView.frame;
    rectViewText.origin.y = 340.f;
    rectTextView.size.height = 259.f;
    [UIView animateWithDuration:0.3f animations:^{
        self.viewText.frame = rectViewText;
        textView.frame = rectTextView;
    }];
    
    CGSize sizeContent = textView.contentSize;
    NSLog(@"%@", NSStringFromCGSize(sizeContent));
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if (range.length == 0) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    if (textView.text.length > 1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(actionSave)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    return YES;
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


@end
