//
//  DetailViewController.h
//  RestAppDemo
//
//  Created by Ferris Li on 12/19/15.
//  Copyright (c) 2015 Ferris Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
