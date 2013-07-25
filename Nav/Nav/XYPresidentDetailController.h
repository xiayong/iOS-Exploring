//
//  XYPresidentDetailController.h
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BIDPresident;

#define kNumberOfEditableRows       4
#define kNameRowIndex               0
#define kFromYearRowIndex           1
#define kToYearRowIndex             2
#define kPartyIndex                 3

#define kLabelTag                   4096

@interface XYPresidentDetailController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) BIDPresident *president;
@property (strong, nonatomic) NSArray *fieldLabels;
@property (strong, nonatomic) NSMutableDictionary *tempValues;
@property (strong, nonatomic) UITextField *currentTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;

@end
