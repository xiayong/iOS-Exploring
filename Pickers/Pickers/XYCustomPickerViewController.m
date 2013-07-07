//
//  XYCustomPickerViewController.m
//  Pickers
//
//  Created by Xia Yong on 13-5-6.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYCustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

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
    //self.picker = nil;
    //self.winLabel = nil;
    //self.column1 = nil;
    //self.column2 = nil;
    //self.column3 = nil;
    //self.column4 = nil;
    //self.column5 = nil;
}

// 显示按钮
- (void)showButton {
    self.spinButton.hidden = NO;
}

// 播放声音
- (void)playWinSound {
    // 向主束请求声音文件的路径
    NSURL *soundURL = [[NSBundle mainBundle] URLForResource:@"win" withExtension:@"wav"];
    // 下面的三行代码是播放声音文件
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
    AudioServicesPlaySystemSound(soundID);
    self.winLabel.text = @"WINNING!";
    // 在1.5秒之后调用showButton方法
    [self performSelector:@selector(showButton) withObject:nil afterDelay:1.5];
}

- (IBAction)spin:(UIButton *)sender {
    BOOL win = NO;
    int numInRow = 1;
    int lastVal = -1;
    for (int i = 0; i < 5; ++i) {
        // 随机让选取器中的某一列选择某个图片
        int newValue = random() % [self.column1 count];
        // 判断本次选中的图片和上此选中的是否是同一个
        if (newValue == lastVal)
            ++ numInRow;
        else
            numInRow = 1;
        lastVal = newValue;
        // 更新选取器
        [self.picker selectRow:newValue inComponent:i animated:YES];
        [self.picker reloadComponent:i];
        if (numInRow >= 3)
            win = YES;
    }
    
    self.spinButton.hidden = YES;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"crunch" ofType:@"wav"];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    AudioServicesPlaySystemSound(soundID);
    if (win)
        [self performSelector:@selector(playWinSound) withObject:nil afterDelay:.5];
    else
        [self performSelector:@selector(showButton) withObject:nil afterDelay:.5];
    self.winLabel.text = @"";
    
    //if (win)
    //    self.winLabel.text = @"WIN!";
    //else
    //    self.winLabel.text = @"";
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
