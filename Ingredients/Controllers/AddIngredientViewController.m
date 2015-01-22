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
#import "UIPlaceHolderTextView.h"

@interface AddIngredientViewController () {
    
    NSInteger danger;
}

@property (strong, nonatomic) IngredientsModel *model;
@property (strong, nonatomic) Ingredient *ingredient;

@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;

@property (weak, nonatomic) IBOutlet UIView *viewDanger;
@property (weak, nonatomic) IBOutlet UIButton *buttonDanger1;
@property (weak, nonatomic) IBOutlet UIButton *buttonDanger2;
@property (weak, nonatomic) IBOutlet UIButton *buttonDanger3;

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *textViewText;

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
    self.textViewText.placeholder = @"Введите описание вещества";
    
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
}


- (void)actionSave {
    
    if (self.textFieldTitle.text.length > 0) {
        if (self.ingredient) {
            [self.model updateIngredient:self.ingredient withTitle:self.textFieldTitle.text andText:self.textViewText.text andDanger:danger];
        } else {
            
            if (self.textFieldTitle.text.length > 0) {
                [self.model addIngredientWithTitle:self.textFieldTitle.text andText:self.textViewText.text andDanger:danger];
                [SVProgressHUD showSuccessWithStatus:@"Вещество сохранено"];
            }
        }
    }
    [self.textFieldTitle resignFirstResponder];
    [self.textViewText resignFirstResponder];
    self.navigationItem.rightBarButtonItem = nil;
}


- (void)actionSaveText {
    
    if (self.textFieldTitle.isFirstResponder) {
        [self.textFieldTitle resignFirstResponder];
    }
    if (self.textViewText.isFirstResponder) {
        [self.textViewText resignFirstResponder];
    }
    
    if (self.textFieldTitle.text.length > 0) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Сохранить" style:UIBarButtonItemStylePlain target:self action:@selector(actionSave)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
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
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStylePlain target:self action:@selector(actionSaveText)];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    self.textFieldTitle.alpha = 0.1f;
    self.viewDanger.alpha = 0.1f;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Готово" style:UIBarButtonItemStylePlain target:self action:@selector(actionSaveText)];
    
    CGRect rectTextView = textView.frame;
    rectTextView.origin.y = 64.f;
    rectTextView.size.height = 288.f;
    
    [UIView animateWithDuration:0.3f animations:^{
        textView.frame = rectTextView;
    }];
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.textFieldTitle.alpha = 1.f;
    self.viewDanger.alpha = 1.f;
    
    CGRect rectTextView = textView.frame;
    rectTextView.origin.y = 271.f;
    rectTextView.size.height = 297.f;
    
    [UIView animateWithDuration:0.3f animations:^{
        textView.frame = rectTextView;
    }];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}


@end
