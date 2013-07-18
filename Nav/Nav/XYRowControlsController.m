//
//  XYRowControlsController.m
//  Nav
//
//  Created by Xia Yong on 13-7-19.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYRowControlsController.h"

@interface XYRowControlsController ()

@end

@implementation XYRowControlsController

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
    self.list = [[NSArray alloc] initWithObjects:@"R2-D2", @"C3p0", @"Tik-Tok", @"Robby", @"Rosie", @"Uniblab", @"Bender", @"Marvin", @"Lt. Commander Data", @"Evil Brother Lore", @"Optimus Prime", @"Tobor", @"HAL", @"Orgasmatron", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender {
    UIButton *senderButton = (UIButton *)sender;
    // 这个是button是表单元的子视图，所以通过[senderButton superview]可以获取到当前表单元
    UITableViewCell *buttonCell = (UITableViewCell *)[senderButton superview];
    NSUInteger buttonRow = [[self.tableView indexPathForCell:buttonCell] row];
    NSString *buttonTitle = [self.list objectAtIndex:buttonRow];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped the button" message:[NSString stringWithFormat:@"You tapped the button for %@", buttonTitle] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ControlRowIdentifier = @"ControlRowIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ControlRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ControlRowIdentifier];
        UIImage *buttonUpImage = [UIImage imageNamed:@"button_up.png"];
        UIImage *buttonDownImage = [UIImage imageNamed:@"button_down.png"];
        // 使用UIButton的工厂方法创建UIButton实例并指定该UIButton实例的样式
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, buttonUpImage.size.width, buttonUpImage.size.height);
        [button setBackgroundImage:buttonUpImage forState:UIControlStateNormal];
        [button setBackgroundImage:buttonDownImage forState:UIControlStateHighlighted];
        [button setTitle:@"Tap" forState:UIControlStateNormal];
        // 通知此button针对TouchUpInside调用操作方法
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        // 将此button分配给单元的附加视图
        cell.accessoryView = button;
    }
    cell.textLabel.text = [self.list objectAtIndex:[indexPath row]];
    return  cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *rowTitle = [self.list objectAtIndex:[indexPath row]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You tapped the row." message:[NSString stringWithFormat:@"You tapped %@", rowTitle] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
