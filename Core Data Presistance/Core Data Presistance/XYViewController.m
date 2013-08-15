//
//  XYViewController.m
//  Core Data Presistance
//
//  Created by Xia Yong on 13-8-16.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
#import "XYAppDelegate.h"

@interface XYViewController ()

- (void)applicationWillResignActive:(NSNotification *)notification;

@end

@implementation XYViewController

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
    
    XYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Line" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (!objects) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[error description] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    for (NSManagedObject *object in objects) {
        NSNumber *lineNum = [object valueForKey:@"lineNum"];
        NSString *lineText = [object valueForKey:@"lineText"];
        [self setValue:lineText forKeyPath:[NSString stringWithFormat:@"field%d.text", [lineNum integerValue]]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:[UIApplication sharedApplication]];
}

- (void)applicationWillResignActive:(NSNotification *)notification {
    XYAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    for (int i = 1; i <= 4; i++) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Line"];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(lineNum = %d)", i];
        [request setPredicate:predicate];
        NSArray *objects = [context executeFetchRequest:request error:&error];
        NSManagedObject *object;
        if (!objects)
            NSLog(@"There was an error! :%@", error);
        if ([objects count] > 0)
            object = [objects objectAtIndex:0];
        else
            object = [NSEntityDescription insertNewObjectForEntityForName:@"Line" inManagedObjectContext:context];
        [object setValue:[NSNumber numberWithInteger:i] forKey:@"lineNum"];
        [object setValue:[self valueForKeyPath:[NSString stringWithFormat:@"field%d.text", i]] forKey:@"lineText"];
    }
    [context save:&error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
