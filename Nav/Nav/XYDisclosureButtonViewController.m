//
//  XYDisclosureButtonViewController.m
//  Nav
//
//  Created by Xia Yong on 13-7-16.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDisclosureButtonViewController.h"
#import "XYAppDelegate.h"
#import "XYDisclosureDetailController.h"

@interface XYDisclosureButtonViewController ()

@property (strong, nonatomic) XYDisclosureDetailController *childController;

@end


@implementation XYDisclosureButtonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.list = [[NSArray alloc] initWithObjects:@"Toy Story", @"A Bug's Life", @"Toy Story 2", @"Monsters, Inc.", @"Finding Nemo", @"The Incredibles", @"Cars", @"Tatatuille", @"WALL-E", @"Up", @"Toy Story 3", @"Cars 2", @"Brave", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DisclosureButtonCellIdentifier = @"DisclosureButtonCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DisclosureButtonCellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DisclosureButtonCellIdentifier];
    cell.textLabel.text = [self.list objectAtIndex:[indexPath row]];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hey, do you see the disclosure button?" message:@"If you're trying to drill down, touch that instead" delegate:nil cancelButtonTitle:@"Won't happen again" otherButtonTitles:nil];
    [alert show];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (self.childController == nil)
        self.childController = [[XYDisclosureDetailController alloc] initWithNibName:@"XYDisclosureDetail" bundle:nil];
    NSString *selectedMovie = [self.list objectAtIndex:[indexPath row]];
    NSString *detailMessage = [[NSString alloc] initWithFormat:@"You pressed the disclosure button for %@.", selectedMovie];
    self.childController.title = @"Disclosure Button Pressed";
    self.childController.message = detailMessage;
    self.childController.title = selectedMovie;
    [self.navigationController pushViewController:self.childController animated:YES];
}

@end
