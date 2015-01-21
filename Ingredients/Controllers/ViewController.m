//
//  ViewController.m
//  Ingredients
//
//  Created by kilovata-iMac on 21/01/15.
//  Copyright (c) 2015 kilovata-iMac. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"
#import "IngredientsModel.h"
#import "Ingredient.h"
#import "MainCell.h"
#import "AddIngredientViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) DataSource *dataSource;
@property (strong, nonatomic) IngredientsModel *model;

@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSource = [DataSource new];
    NSFetchRequest *request = [self.model getRequestIngredients];
    if (request) {
        [self.dataSource setupFetchResultsControllerWithRequest:request];
    }
    
    self.title = @"Лаборатория";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIngredient)];
    
    UIImageView *imgViewFooter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"footer"]];
    self.table.tableFooterView = imgViewFooter;
    
    [self.table registerNib:[UINib nibWithNibName:@"MainCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MainCell"];
}


- (void)addIngredient {
    
    AddIngredientViewController *addVC = [AddIngredientViewController new];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.dataSource.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.dataSource.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Ingredient *ingredient = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
    MainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.labelTitle.text = ingredient.title;
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 220.f;
    } else {
        return 120.f;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Ingredient *ingredient = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
