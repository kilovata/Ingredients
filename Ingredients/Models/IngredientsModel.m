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
    
    return [Ingredient MR_requestAllSortedBy:@"title" ascending:YES];
}


- (void)addIngredientWithTitle:(NSString *)title andText:(NSString*)text andDanger:(NSInteger)danger {
    
    Ingredient *ingredient = [Ingredient MR_findFirstByAttribute:@"title" withValue:title];
    if (!ingredient) {
        ingredient = [Ingredient MR_createEntity];
        NSInteger count = [Ingredient MR_countOfEntities];
        count++;
        ingredient.idIngredient = @(count);
    }
    ingredient.title = title;
    if (text) {
        ingredient.text = text;
    }
    if (danger > 0) {
        ingredient.danger = @(danger);
    }
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (void)updateIngredient:(Ingredient*)ingredient withTitle:(NSString*)title andText:(NSString*)text andDanger:(NSInteger)danger {
    
    if (title) {
        ingredient.title = title;
    }
    if (text) {
        ingredient.text = text;
    }
    if (danger > 0) {
        ingredient.danger = @(danger);
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (void)deleteIngredient:(Ingredient*)ingredient {
    
    [ingredient MR_deleteEntity];
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


@end
