//
//  XYMasterViewController.m
//  TinyPix
//
//  Created by Xia Yong on 13-8-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYMasterViewController.h"

#import "XYDetailViewController.h"
#import "XYTinyPixDocument.h"

@interface XYMasterViewController ()<UIAlertViewDelegate>

@property (strong, nonatomic) NSArray *documentFilenames;
@property (strong, nonatomic) XYTinyPixDocument *chosenDocument;
- (NSURL *)urlForFilename:(NSString *)filename;
- (void)reloadFiles;

@end

@implementation XYMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    
    [self reloadFiles];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 用户点击导航栏的添加按钮后弹出警告框
- (void)insertNewObject {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Filename" message:@"Enter a name for new TinyPix document." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Create", nil];
    // 警告框的格式为UIAlertViewStylePlainTextInput
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // 当用户点击了警告框的第二个按钮后获取用户输入的文件名
        NSString *filename = [NSString stringWithFormat:@"%@.tinypix", [alertView textFieldAtIndex:0].text];
        NSURL *saveURL = [self urlForFilename:filename];
        self.chosenDocument = [[XYTinyPixDocument alloc] initWithFileURL:saveURL];
        // 保存文件，并在保存方法响应后执行回调方法
        [self.chosenDocument saveToURL:saveURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"save OK");
                [self reloadFiles];
                // 若保存成功，初始化转向另一个视图控制器的segue
                [self performSegueWithIdentifier:@"masterToDetail" sender:self];
            } else
                NSLog(@"save failed!");
        }];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.documentFilenames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FileCellIdentifier = @"FileCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FileCellIdentifier forIndexPath:indexPath];
    NSString *path = [self.documentFilenames objectAtIndex:indexPath.row];
    cell.textLabel.text = path.lastPathComponent.stringByDeletingPathExtension;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender == self) {
        // 若用户保存了一个新的文件，要跳转到详细视图
        UIViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setDetailItem:)])
            [destination setValue:self.chosenDocument forKey:@"detailItem"];
    } else {
        // 若用户没有保存一个新文件，直接点击一个已经存在的文件跳转到相信视图
        
        // 获取当前选中的行
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *filename = [self.documentFilenames objectAtIndex:indexPath.row];
        NSURL *docUrl = [self urlForFilename:filename];
        self.chosenDocument = [[XYTinyPixDocument alloc] initWithFileURL:docUrl];
        // 打开文件
        [self.chosenDocument openWithCompletionHandler:^(BOOL success) {
            if (success) {
                NSLog(@"load OK");
                UIViewController *destination = segue.destinationViewController;
                if ([destination respondsToSelector:@selector(setDetailItem:)])
                    [destination setValue:self.chosenDocument forKey:@"detailItem"];
            } else
                NSLog(@"load failed!");
        }];
    }
}


- (NSURL *)urlForFilename:(NSString *)filename {
    // 获取应用程序Documents目录
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:filename];
    return [NSURL fileURLWithPath:filePath];
}

- (void)reloadFiles {
    // 获取应用程序Documents目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    // 获取文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *dirError;
    // 搜索应用程序Documents目录下面的所有文件
    NSArray *files = [fileManager contentsOfDirectoryAtPath:path error:&dirError];
    if (!files)
        NSLog(@"Encountered error while trying to list files in directory %@: %@", path, dirError);
    NSLog(@"Found files: %@", files);
    // 使用自定义的算法来重新
    files = [files sortedArrayUsingComparator:^NSComparisonResult(id filename1, id filename2){
        NSDictionary *attr1 = [fileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:filename1] error:nil];
        NSDictionary *attr2 = [fileManager attributesOfItemAtPath:[path stringByAppendingPathComponent:filename2] error:nil];
        return [[attr2 objectForKey:NSFileCreationDate] compare:[attr1 objectForKey:NSFileCreationDate]];
    }];
    self.documentFilenames = files;
    [self.tableView reloadData];
}

- (void)chooseColor:(id)sender {
    // 保存用户偏好设置
    NSInteger selectedColorIndex = [sender selectedSegmentIndex];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:selectedColorIndex forKey:@"selectedColorIndex"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 加载用户偏好设置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger selectedColorIndex = [defaults integerForKey:@"selectedColorIndex"];
    self.colorControl.selectedSegmentIndex = selectedColorIndex;
}

@end
