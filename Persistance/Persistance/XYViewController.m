//
//  XYViewController.m
//  Persistance
//
//  Created by Xia Yong on 13-8-9.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
// #import "XYFourLines.h"
#import <sqlite3.h>

// #define kFilename       @"data.plist"
// #define kFilename       @"archive"
// #define kDataKey        @"Data"
#define kFilename       @"data.sqlite3"

@interface XYViewController ()

- (NSString *)dataFilePath;
- (void)applicationWillResignActive:(NSNotification *)notification;

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    /*
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // 从文件中读取数据
        //NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        //for (int i = 0; i < [array count]; ++ i)
        //    [self setValue:[array objectAtIndex:i] forKeyPath:[NSString stringWithFormat:@"field%d.text", i + 1]];
        
        // 从归档文件中解密出数据
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        XYFourLines *fourLines = [unarchiver decodeObjectForKey:kDataKey];
        [unarchiver finishDecoding];
        for (int i = 1; i <= 4; i ++) {
            NSString *valye = [fourLines valueForKey:[NSString stringWithFormat:@"field%d", i]];
            [self setValue:valye forKeyPath:[NSString stringWithFormat:@"field%d.text", i]];
        }
    }
    */
    
    sqlite3 *database;
    // 打开数据库
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        // 若打开数据库出现问题，则关闭数据库，且断言失败
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT)";
    char *errorMsg;
    // 创建表
    if (sqlite3_exec(database, [createSQL UTF8String], NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Error creating table: %s", errorMsg);
    }
    NSString *querySQL = @"SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW ASC";
    sqlite3_stmt *statement;
    // 执行查询
    if (sqlite3_prepare_v2(database, [querySQL UTF8String], -1, &statement, nil) == SQLITE_OK) {
        // 分步获取结果集
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int row = sqlite3_column_int(statement, 0);
            char *rowData = (char *)sqlite3_column_text(statement, 1);
            [self setValue:[NSString stringWithUTF8String:rowData] forKeyPath:[NSString stringWithFormat:@"field%d.text", row]];
        }
        // 结束查询
        sqlite3_finalize(statement);
    }
    // 关闭数据库连接
    sqlite3_close(database);
    
    
    UIApplication *app = [UIApplication sharedApplication];
    // 注册UIApplicationWillResignActiveNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)dataFilePath {
    // 搜索应用程序Documents文件夹
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:kFilename];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    /*
    //NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
    //for (int i = 1; i <= 4; i ++)
    //    [array addObject:[self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]]];
    
    // 将应用程序数据写入文件
    //[array writeToFile:[self dataFilePath] atomically:YES];

    XYFourLines *fourLines = [[XYFourLines alloc] init];
    for (int i = 1; i <= 4; i ++) {
        NSString *value = [self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]];
        [fourLines setValue:value forKey:[NSString stringWithFormat:@"field%d", i]];
    }
    // 归档数据
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:fourLines forKey:kDataKey];
    [archiver finishEncoding];
    // 将归档后的数据写入文件
    [data writeToFile:[self dataFilePath] atomically:YES];
     */
    
    sqlite3 *database;
    if (sqlite3_open([[self dataFilePath] UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSAssert(0, @"Failed to open database");
    }
    for (int i = 1; i <= 4; i++) {
        NSString *fieldValue = [self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]];
        char *updateSQL = "INSERT OR REPLACE INTO FIELDS(ROW, FIELD_DATA) VALUES(?, ?)";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(database, updateSQL, -1, &statement, nil) == SQLITE_OK) {
            // 绑定变量
            sqlite3_bind_int(statement, 1, i);
            sqlite3_bind_text(statement, 2, [fieldValue UTF8String], -1, NULL);
        }
        if (sqlite3_step(statement) != SQLITE_DONE)
            NSAssert(0, @"Error update table: [%d, %@]", i, fieldValue);
        sqlite3_finalize(statement);
    }
    sqlite3_close(database);
}

- (IBAction)changeColor:(UISegmentedControl *)sender {
}

- (IBAction)changeColor:(UISegmentedControl *)sender {
}
@end
