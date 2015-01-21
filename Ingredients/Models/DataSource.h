//
//  DataSource.h
//  EasyBank
//
//  Created by kilovata-iMac on 26/09/14.
//  Copyright (c) 2014 Manufactura Soft. All rights reserved.
//

#import <MagicalRecord/CoreData+MagicalRecord.h>

@interface DataSource : NSObject

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (void)setupFetchResultsControllerWithRequest:(NSFetchRequest*)request;

@end
