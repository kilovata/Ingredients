//
//  IngredientsModel.h
//  Ingredients
//
//  Created by kilovata-iMac on 21/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@class Ingredient;

@interface IngredientsModel : NSObject

- (NSFetchRequest*)getRequestIngredients;
- (void)addIngredientWithTitle:(NSString *)title andText:(NSString*)text andDanger:(NSInteger)danger;
- (void)updateIngredient:(Ingredient*)ingredient withTitle:(NSString*)title andText:(NSString*)text andDanger:(NSInteger)danger;
- (void)deleteIngredient:(Ingredient*)ingredient;

@end
