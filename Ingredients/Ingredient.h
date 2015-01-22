//
//  Ingredient.h
//  Ingredients
//
//  Created by kilovata-iMac on 22/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSNumber * idIngredient;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * danger;

@end
