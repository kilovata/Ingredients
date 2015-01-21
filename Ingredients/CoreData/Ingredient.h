//
//  Ingredient.h
//  
//
//  Created by kilovata-iMac on 21/01/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * idIngredient;

@end
