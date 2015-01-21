//
//  DataSource.m
//  EasyBank
//
//  Created by kilovata-iMac on 26/09/14.
//  Copyright (c) 2014 Manufactura Soft. All rights reserved.
//

#import "DataSource.h"

@interface DataSource()<NSFetchedResultsControllerDelegate>

@end


@implementation DataSource


- (void)setupFetchResultsControllerWithRequest:(NSFetchRequest*)request {
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    if (!self.fetchedResultsController.delegate) {
        self.fetchedResultsController.delegate = self;
    }
    
    NSError *error = nil;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}


@end
