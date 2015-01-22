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
#import <MessageUI/MessageUI.h>
#import <CHCSVParser/CHCSVParser.h>

@interface ViewController ()<NSFetchedResultsControllerDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) DataSource *dataSource;
@property (strong, nonatomic) IngredientsModel *model;
@property (weak, nonatomic) IBOutlet UISearchBar *search;

@end


@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.model = [IngredientsModel new];
    self.dataSource = [DataSource new];
    self.dataSource.fetchedResultsController.delegate = self;
    NSFetchRequest *request = [self.model getRequestIngredients];
    if (request) {
        [self.dataSource setupFetchResultsControllerWithRequest:request];
    }
    
    self.title = @"Лаборатория";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(export)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addIngredient)];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:[UIFont fontWithName:@"Helvetica-Light" size:17.f]];
    
    UIImageView *imgViewFooter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"footer"]];
    self.table.tableFooterView = imgViewFooter;
    self.table.tableHeaderView = self.search;
    [self.table registerNib:[UINib nibWithNibName:@"MainCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MainCell"];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSFetchRequest *request = [self.model getRequestIngredients];
    if (request) {
        [self.dataSource setupFetchResultsControllerWithRequest:request];
    }
    [self.table reloadData];
}


- (void)viewDidDisappear:(BOOL)animated {

    [super viewDidDisappear:animated];
    
    self.search.text = @"";
}


- (void)createCSV {
    
    NSArray *arrayIngredients = [Ingredient MR_findAllSortedBy:@"idIngredient" ascending:YES];
    
    for (int i=0; i<arrayIngredients.count; i++) {
        
        Ingredient *ingredient = arrayIngredients[i];
        NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *docDir = [arrayPaths objectAtIndex:0];
        NSString *path = [docDir stringByAppendingString:@"/Ingredients.csv"];
        CHCSVWriter *writer = [[CHCSVWriter alloc] initForWritingToCSVFile:path];
        
        [writer writeLineOfFields:@[@"№", @"Название", @"Описание", @"Опасность"]];
        [writer writeField:[NSString stringWithFormat:@"%@", ingredient.idIngredient]];
        [writer writeField:ingredient.title];
        [writer writeField:ingredient.text];
        [writer writeField:[NSString stringWithFormat:@"%@", ingredient.danger]];
    }
}


- (void)export {
    
    if ([MFMailComposeViewController canSendMail]) {
        
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        controller.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *docDir = [arrayPaths objectAtIndex:0];
        NSString *Path = [docDir stringByAppendingString:@"/Ingredients.csv"];
        NSData *csvData = [NSData dataWithContentsOfFile:Path];
        [controller addAttachmentData:csvData mimeType:@"text/csv" fileName:@"Ingredients.csv"];
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://"]];
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller  didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if (ingredient.danger) {
        NSInteger danger = [ingredient.danger integerValue];
        switch (danger) {
            case 1:
                cell.labelTitle.textColor = [UIColor colorWithRed:99.f/255.f green:190.f/255.f blue:87.f/255.f alpha:1.f];
                //cell.imgViewDanger.image = [UIImage imageNamed:@"danger1"];
                break;
            case 2:
                cell.labelTitle.textColor = [UIColor colorWithRed:249.f/255.f green:236.f/255.f blue:25.f/255.f alpha:1.f];
                //cell.imgViewDanger.image = [UIImage imageNamed:@"danger2"];
                break;
            case 3:
                cell.labelTitle.textColor = [UIColor colorWithRed:246.f/255.f green:46.f/255.f blue:46.f/255.f alpha:1.f];
                //cell.imgViewDanger.image = [UIImage imageNamed:@"danger3"];
                break;
            case 0:
                cell.labelTitle.textColor = [UIColor grayColor];
                break;
            default:
                break;
        }
    }
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Ingredient *ingredient = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
        [self.model deleteIngredient:ingredient];
        NSError *error = nil;
        [self.dataSource.fetchedResultsController performFetch:&error];
        [self.table reloadData];
    }
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.search resignFirstResponder];
    Ingredient *ingredient = [self.dataSource.fetchedResultsController objectAtIndexPath:indexPath];
    AddIngredientViewController *addVC = [[AddIngredientViewController alloc] initWithIngredient:ingredient];
    [self.navigationController pushViewController:addVC animated:YES];
}


#pragma mark - UISearchBarDelegate
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    [self performSelector:@selector(searchTitle) withObject:nil afterDelay:0.1f];
    return YES;
}


- (void)searchTitle {
    
    NSFetchRequest *request = nil;
    if (self.search.text.length > 0) {
        request = [Ingredient MR_requestAllSortedBy:@"title" ascending:NO withPredicate:[NSPredicate predicateWithFormat:@"title beginswith[cd] %@", self.search.text]];
    } else {
        request = [self.model getRequestIngredients];
    }
    if (request) {
        [self.dataSource setupFetchResultsControllerWithRequest:request];
    }
    [self.table reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self performSelector:@selector(searchTitle) withObject:nil afterDelay:0.1f];
    [searchBar resignFirstResponder];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    self.search.text = @"";
    [self.search resignFirstResponder];
    NSFetchRequest *request = [self.model getRequestIngredients];
    if (request) {
        [self.dataSource setupFetchResultsControllerWithRequest:request];
    }
    [self.table reloadData];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    UITextField *textField = [searchBar valueForKey:@"_searchField"];
    textField.clearButtonMode = UITextFieldViewModeNever;
    searchBar.showsCancelButton = YES;
    
    UIView *view = searchBar.subviews[0];
    for (UIView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)subView;
            [cancelButton setTitle:@"Очистить" forState:UIControlStateNormal];
        }
    }
}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    searchBar.showsCancelButton = NO;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.search.isFirstResponder) {
        [self.search resignFirstResponder];
    }
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
