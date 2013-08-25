//
//  XYDetailViewController.h
//  TinyPix
//
//  Created by Xia Yong on 13-8-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTinyPixView.h"

@interface XYDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet XYTinyPixView *pixView;

@end
