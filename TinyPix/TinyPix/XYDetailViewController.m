//
//  XYDetailViewController.m
//  TinyPix
//
//  Created by Xia Yong on 13-8-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDetailViewController.h"

@interface XYDetailViewController ()
@property (assign, nonatomic) NSUInteger selectedColorIndex;
- (void)configureView;
@end

@implementation XYDetailViewController

- (void)setSelectedColorIndex:(NSUInteger)i {
    if (_selectedColorIndex != i) {
        _selectedColorIndex = i;
        switch (_selectedColorIndex) {
            case 0:
                self.pixView.highlightColorl = [UIColor blackColor];
                break;
            case 1:
                self.pixView.highlightColorl = [UIColor redColor];
                break;
            case 2:
                self.pixView.highlightColorl = [UIColor grayColor];
                break;
            default:
                break;
        }
        [self.pixView setNeedsDisplay];
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.pixView.document = self.detailItem;
        [self.pixView setNeedsDisplay];
    }
    self.selectedColorIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"selectedColorIndex"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.detailItem closeWithCompletionHandler:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
