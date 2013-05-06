//
//  XYDependentComponentPickerViewController.m
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDependentComponentPickerViewController.h"

@interface XYDependentComponentPickerViewController ()

@end

@implementation XYDependentComponentPickerViewController

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
    
    // 获取资源文件URL
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"statedictionary" withExtension:@"plist"];
    // 读取资源文件
    self.stateZips = [NSDictionary dictionaryWithContentsOfURL:plistURL];
    // 将所有的key值取出排序后作为states
    self.states = [[self.stateZips allKeys] sortedArrayUsingSelector:@selector(compare:)];
    // 获取所有states中的第一个state对应的zips
    self.zips = [self.stateZips objectForKey:[self.states objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(UIButton *)sender {
    NSInteger stateRow = [self.picker selectedRowInComponent:kStateComponent];
    NSInteger zipRow = [self.picker selectedRowInComponent:kZipComponent];
    NSString *state = [self.states objectAtIndex:stateRow];
    NSString *zip = [self.zips objectAtIndex:zipRow];
    NSString *title = [NSString stringWithFormat:@"You selected zip code is %@.", zip];
    NSString *message = [NSString stringWithFormat:@"%@ is on %@", zip, state];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark -
#pragma mark Picker Data Source Methods
// 数据源对象被询问改pickerView中有多少个组件
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

// 数据源对象被询问pickerView对象的第component个组件需要显示多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (kStateComponent == component)
        return [self.states count];
    return [self.zips count];
}

#pragma mark Picker Delegate Methods
// 委托对象被询问pickerView对象的第component个组件的第row行的标题显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (kStateComponent == component)
        return [self.states objectAtIndex:row];
    return [self.zips objectAtIndex:row];
}

// 当pickerView对象的第component个组件的第row行被选中时向委托对象发送此消息
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // 当用户选择了state组件时
    if (kStateComponent == component) {
        // 取出该state对应的zips
        self.zips = [self.stateZips objectForKey:[self.states objectAtIndex:row]];
        // 让zip组件的第1行选中
        [self.picker selectRow:0 inComponent:kZipComponent animated:YES];
        // 重新加载zip组件
        [self.picker reloadComponent:kZipComponent];
    }
}

// 委托对象被询问pickerView对象的第component个组件的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (kStateComponent == component)
        return 200;
    return 90;
}

@end
