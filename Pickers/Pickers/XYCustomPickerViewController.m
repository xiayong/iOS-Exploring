//
//  XYCustomPickerViewController.m
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYCustomPickerViewController.h"

@interface XYCustomPickerViewController ()

@end

@implementation XYCustomPickerViewController

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
    // Do any additional setup after loading the view from its nib.
    
    UIImage *seven = [UIImage imageNamed:@"seven.png"];
    UIImage *bar = [UIImage imageNamed:@"bar.png"];
    UIImage *crown = [UIImage imageNamed:@"crown.png"];
    UIImage *cherry = [UIImage imageNamed:@"cherry.png"];
    UIImage *lemon = [UIImage imageNamed:@"lemon.png"];
    UIImage *apple = [UIImage imageNamed:@"apple.png"];
    
    for (int i = 1; i <= 5; ++i) {
        UIImageView *sevenView = [[UIImageView alloc] initWithImage:seven];
        UIImageView *barView = [[UIImageView alloc] initWithImage:bar];
        UIImageView *crownView = [[UIImageView alloc] initWithImage:crown];
        UIImageView *cherryView = [[UIImageView alloc] initWithImage:cherry];
        UIImageView *lemonView = [[UIImageView alloc] initWithImage:lemon];
        UIImageView *appleView = [[UIImageView alloc] initWithImage:apple];
        NSArray *imageViewArray = [NSArray arrayWithObjects:sevenView, barView, crownView, cherryView, lemonView, appleView, nil];
        NSString *fieldName = [NSString stringWithFormat:@"column%d", i];
        [self setValue:imageViewArray forKey:fieldName];
    }
    
    self.winLabel.text = @"";
    
    srandom(time(NULL));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.picker = nil;
    self.winLabel = nil;
    self.column1 = nil;
    self.column2 = nil;
    self.column3 = nil;
    self.column4 = nil;
    self.column5 = nil;
}

- (IBAction)spin:(UIButton *)sender {
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i < 5; ++i) {
        int newValue = random() % [self.column1 count];
        if (newValue == lastVal)
            ++ numInRow;
        else
            numInRow = 1;
        lastVal = newValue;
        [self.picker selectRow:newValue inComponent:i animated:YES];
        [self.picker reloadComponent:i];
        if (numInRow >= 3)
            win = YES;
    }
    if (win)
        self.winLabel.text = @"WIN!";
    else
        self.winLabel.text = @"";
}

#pragma mark -
#pragma mark Picker Data Source Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.column1 count];
}

#pragma mark Picker Delegate Methods
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    NSString *arrayName = [NSString stringWithFormat:@"column%d", component + 1];
    NSArray *array = [self valueForKey:arrayName];
    return [array objectAtIndex:row];
}

@end
