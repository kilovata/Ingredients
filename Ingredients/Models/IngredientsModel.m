//
//  IngredientsModel.m
//  Ingredients
//
//  Created by kilovata-iMac on 21/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import "IngredientsModel.h"
#import "Ingredient.h"

@implementation IngredientsModel


- (NSFetchRequest*)getRequestIngredients {
    
    return [Ingredient MR_requestAllSortedBy:@"title" ascending:NO];
}


- (void)addIngredientWithTitle:(NSString*)title {
    
    Ingredient *ingredient = [Ingredient MR_findFirstByAttribute:@"title" withValue:title];
    if (!ingredient) {
        ingredient = [Ingredient MR_createEntity];
        NSInteger count = [Ingredient MR_countOfEntities];
        count++;
        ingredient.idIngredient = @(count);
    }
    ingredient.title = title;
}


- (void)addIngredientWithText:(NSString*)text andTitle:(NSString*)title {
    
    Ingredient *ingredient = [Ingredient MR_findFirstByAttribute:@"title" withValue:title];
    if (!ingredient) {
        ingredient = [Ingredient MR_createEntity];
        NSInteger count = [Ingredient MR_countOfEntities];
        count++;
        ingredient.idIngredient = @(count);
    }
    ingredient.text = text;
}


@end
