//
//  XYPresidentDetailController.m
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYPresidentDetailController.h"
#import "BIDPresident.h"

@interface XYPresidentDetailController ()

@end

@implementation XYPresidentDetailController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.fieldLabels = [[NSArray alloc] initWithObjects:@"Name:", @"From:", @"To:", @"Party:", nil];
    // 初始化导航栏上面的两个按钮
    // UIBarButtonItemStylePlain 一般是指用户取消当前的操作，返回上一级视图
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
    // UIBarButtonItemStyleDone 一般是指用户确定当前的操作，准备离开本视图
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style: UIBarButtonItemStyleDone target:self action:@selector(save:)];
    self.tempValues = [[NSMutableDictionary alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    // 放弃本次修改，返回到上级视图
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
    if (self.currentTextField != nil) {
        // 用户当前还在编辑某个UITextField
        NSNumber *tagAsNum = [NSNumber numberWithInt:self.currentTextField.tag];
        [self.tempValues setObject:self.currentTextField.text forKey:tagAsNum];
    }
    // 将用户本次所有的修改更新到self.president对象
    for (NSNumber *key in [self.tempValues allKeys]) {
        NSString *value = [self.tempValues objectForKey:key];
        switch ([key intValue]) {
            case kNameRowIndex:
                self.president.name = value;
                break;
            case kFromYearRowIndex:
                self.president.fromYear = value;
                break;
            case kToYearRowIndex:
                self.president.toYear = value;
                break;
            case kPartyIndex:
                self.president.party = value;
                break;
            default:
                break;
        }
    }
    // 返回到上一级视图
    [self.navigationController popViewControllerAnimated:YES];
    UITableViewController *parent = [self.navigationController.viewControllers lastObject];
    [parent.tableView reloadData];
}

- (IBAction)textFieldDone:(id)sender {
    // [sender resignFirstResponder];
    
    // UITableViewCell的子视图是UITableViewCellContentView，UITableViewCellContentView的子视图里面才有UITextField
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *thisCellIndexPath = [self.tableView indexPathForCell:cell];
    NSUInteger nextRow = [thisCellIndexPath row] + 1;
    // 如果没有下一行了，就跳到第一行
    //if (nextRow >= kNumberOfEditableRows)
    //    nextRow = kNameRowIndex;
    
    // 我改了一下。。。
    if (nextRow >= kNumberOfEditableRows) {
        [sender resignFirstResponder];
        return;
    }
    // 获取下一行
    UITableViewCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:nextRow inSection:[thisCellIndexPath section]]];
    UITextField *nextTextField = nil;
    // 获取到下一行的文本框
    for (UIView *oneView in nextCell.contentView.subviews) {
        if ([oneView isMemberOfClass:[UITextField class]]) {
            nextTextField = (UITextField *)oneView;
            break;
        }
    }
    // 如果下一行是最后一行，则键盘的return键为Done
    if (nextRow == kPartyIndex)
        nextTextField.returnKeyType = UIReturnKeyDone;
    // 让下一行行的文本框成为第一响应着
    [nextTextField becomeFirstResponder];
        
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return kNumberOfEditableRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *PresidentCellIdentifier = @"PresidentCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresidentCellIdentifier];
    NSUInteger row = [indexPath row];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PresidentCellIdentifier];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 75, 25)];
        label.textAlignment = kCTRightTextAlignment;
        label.tag = kLabelTag;
        label.font = [UIFont boldSystemFontOfSize:14];
        [cell.contentView addSubview:label];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 12, 200, 25)];
        // clearsOnBeginEditing 当用户将要开始编辑文本框的时候是否清除文本框的内容
        textField.clearsOnBeginEditing = NO;
        [textField setDelegate:self];
        // 键盘return键的类型为Done
        // textField.returnKeyType = UIReturnKeyDone;
        switch (row) {
            case kFromYearRowIndex:
            case kToYearRowIndex:
                textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                break;
            default:
                break;
        }
        
        [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:kLabelTag];
    UITextField *textField = nil;
    for (UIView *onView in cell.contentView.subviews) {
        if ([onView isMemberOfClass:[UITextField class]]) {
            textField = (UITextField *)onView;
            break;
        }
    }
    label.text = [self.fieldLabels objectAtIndex:row];
    NSNumber *rowAsNum = [NSNumber numberWithInt:row];
    
    // BOOL isContains = [[self.tempValues allKeys] containsObject:rowAsNum];
    NSString *value = [self.tempValues objectForKey:rowAsNum];
    
    // 下面的if判断个人觉得多余了。。。每次这里 self.tempValues 都是一个空的字典，isContains一定为NO。
    // 换句话来说，每次查看某个总统的详细信息的时候，初始化一个新的XYPresidentDetailController对象，这个controller引用的president对象已经是更新过的，完全不需要考虑上一次是否修改了什么。
    
    switch (row) {
        case kNameRowIndex:
            //if (!isContains)
                value = self.president.name;
            break;
        case kFromYearRowIndex:
            //if (!isContains)
                value = self.president.fromYear;
            break;
        case kToYearRowIndex:
            //if (!isContains)
                value = self.president.toYear;
            break;
        case kPartyIndex:
            //if (!isContains)
                value = self.president.party;
            break;
        default:
            break;
    }
    textField.text = value;
    if (self.currentTextField == textField)
        self.currentTextField = nil;
    textField.tag = row;
    
    return cell;
}

#pragma mark - Table view delegate
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 不用用户选中任何一行，每一行都是由一个标签和一个文本框组成
    return nil;
}

#pragma mark - Text Field Delegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 让controller知道用户当前编辑了哪一行，因为有可能用户编辑完某一行之后没有按键盘上的return按钮，而是直接按导航栏上的Save键。
    self.currentTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    // 临时保存用户的本次修改
    [self.tempValues setObject:textField.text forKey:[NSNumber numberWithInt:textField.tag]];
}

@end
