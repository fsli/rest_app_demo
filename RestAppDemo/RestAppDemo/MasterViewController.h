//
//  MasterViewController.h
//  RestAppDemo
//
//  Created by Ferris Li on 12/19/15.
//  Copyright (c) 2015 Ferris Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
