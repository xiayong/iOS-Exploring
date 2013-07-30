//
//  XYTaskDetailController.m
//  Seg Nav
//
//  Created by Xia Yong on 13-7-31.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYTaskDetailController.h"

@interface XYTaskDetailController ()

@end

@implementation XYTaskDetailController

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
    
    self.textView.text = [self.selection objectForKey:@"object"];
    [self.textView becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 当此视图将要退出时，向上一级视图控制器回传值
    if ([self.delegate respondsToSelector:@selector(setEditedSelection:)]) {
        [self.textView endEditing:YES];
        NSIndexPath *indexPath = [self.selection objectForKey:@"indexPath"];
        id object = self.textView.text;
        NSDictionary *editedSelection = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", object , @"object", nil];
        [self.delegate setValue:editedSelection forKey:@"editedSelection"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
