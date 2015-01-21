//
//  IngredientsModel.h
//  Ingredients
//
//  Created by kilovata-iMac on 21/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface IngredientsModel : NSObject

- (NSFetchRequest*)getRequestIngredients;
- (void)addIngredientWithTitle:(NSString*)title;
- (void)addIngredientWithText:(NSString*)text andTitle:(NSString*)title;

@end
