//
//  XYDetailViewController.m
//  Presidents
//
//  Created by Xia Yong on 13-8-5.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDetailViewController.h"
#import "XYLanguageListController.h"

static NSString * modifyUrlForLanguage(NSString *url, NSString *lang) {
    if (!lang)
        return url;
    NSRange languageCodeRange = NSMakeRange(7, 2);
    if ([[url substringWithRange:languageCodeRange] isEqualToString:lang])
        return url;
    else
        return [url stringByReplacingCharactersInRange:languageCodeRange withString:lang];
}

@interface XYDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation XYDetailViewController

- (void)setLanguage:(NSString *)language {
    if (![language isEqualToString:_language]) {
        _language = [language copy];
        self.detailItem = modifyUrlForLanguage(self.detailItem, language);
    }
    if (self.languagePopoverController) {
        // 让弹出视图消失
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

- (IBAction)touchLanguageButton {
    if (!self.languagePopoverController) {
        // 弹出视图不存在则创建弹出视图
        XYLanguageListController *languageListController = [[XYLanguageListController alloc] init];
        languageListController.detailViewController = self;
        UIPopoverController * poc = [[UIPopoverController alloc] initWithContentViewController:languageListController];
        [poc presentPopoverFromBarButtonItem:self.languageButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        self.languagePopoverController = poc;
    } else {
        [self.languagePopoverController dismissPopoverAnimated:YES];
        self.languagePopoverController = nil;
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        //_detailItem = newDetailItem;
        _detailItem = modifyUrlForLanguage(newDetailItem, self.language);
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    NSURL *url = [NSURL URLWithString:self.detailItem];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.languageButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Choose Language" style:UIBarButtonItemStyleDone target:self action:@selector(touchLanguageButton)];
    self.navigationItem.rightBarButtonItem = self.languageButtonItem;
    
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    //barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    barButtonItem.title = NSLocalizedString(@"Presidents", @"Presidents");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
