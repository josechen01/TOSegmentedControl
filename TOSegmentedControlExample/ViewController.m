//
//  ViewController.m
//  TOSegmentedControlExample
//
//  Created by Tim Oliver on 10/8/19.
//  Copyright © 2019 Tim Oliver. All rights reserved.
//

#import "ViewController.h"
#import "TOSegmentedControl.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *classicSegmentedControl;
@property (weak, nonatomic) IBOutlet TOSegmentedControl *segmentedControl;

@property (weak, nonatomic) IBOutlet UILabel *classicSegmentedLabel;
@property (weak, nonatomic) IBOutlet UILabel *segmentedLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.classicSegmentedLabel.alpha = 0.0f;
    self.segmentedLabel.alpha = 0.0f;
    
    __weak typeof(self) weakSelf = self;
    self.segmentedControl.itemColor = UIColor.whiteColor;
    self.segmentedControl.items = @[@"First ControlAAAA", @"Second ControlAAAA", @"Third"];
    self.segmentedControl.backgroundColor = [UIColor colorWithRed:35/255.0 green:37/255.0 blue:40/255.0 alpha:1];
    self.segmentedControl.thumbColor = [UIColor colorWithRed:68/255.0 green:70/255.0 blue:73/255.0 alpha:1];
    self.segmentedControl.customArrowIcon = [UIImage imageNamed:@"arrowIcon"];
    self.segmentedControl.selectedItemColor = UIColor.whiteColor;
    [self.segmentedControl setReversible:YES forSegmentAtIndex:1];
    [self.segmentedControl setReversed:YES forSegmentAtIndex:1];
    self.segmentedControl.segmentTappedHandler = ^(NSInteger index, BOOL reversed) {
        NSString *title = [self nameForIndex:index];
        [weakSelf animateLabel:weakSelf.segmentedLabel title:title reveresed:reversed];
    };
    
    self.segmentedControl.segmentTappedHandler = ^(NSInteger segmentIndex, BOOL reversed) {
        if (segmentIndex == 1) {
            [self.segmentedControl setEnabled:reversed forSegmentAtIndex:0];
            [self.segmentedControl setEnabled:reversed forSegmentAtIndex:2];
        }
    };

    // Additional options that can be tested on the control

    // Adds a new item called "Fourth" on the end
    // [self.segmentedControl addNewSegmentWithTitle:@"Fourth"];

    // Inserts a new item called Zero to the beginning
    // [self.segmentedControl insertSegmentWithTitle:@"Zero" atIndex:0];

    // Removes the last item from the end
    // [self.segmentedControl removeLastSegment];

    // Animate selection to the final segment
    // dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //    [self.segmentedControl setSelectedSegmentIndex:2 animated:YES];
    // });
}

- (IBAction)segmentedControlUpdated:(id)sender
{
    NSString *title = [self nameForIndex:self.classicSegmentedControl.selectedSegmentIndex];
    [self animateLabel:self.classicSegmentedLabel title:title reveresed:NO];
}

- (void)animateLabel:(UILabel *)label title:(NSString *)title reveresed:(BOOL)reversed
{
    label.text = title;
    if (reversed) {
        label.text = [label.text stringByAppendingString:@", Reversed"];
    }

    label.alpha = 1.0f;
    label.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.1f);
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
         usingSpringWithDamping:0.3f
          initialSpringVelocity:50.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{ label.transform = CGAffineTransformIdentity; }
                     completion:^(BOOL finished)
    {
        [UIView animateWithDuration:0.4f animations:^{
            label.alpha = 0.0f;
        }];
    }];
}

- (NSString *)nameForIndex:(NSInteger)index
{
    switch (index) {
        case 0: return @"First Selected";
        case 1: return @"Second Selected";
        case 2: return @"Third Selected";
        case 3: return @"Fourth Selected";
    }
    
    return nil;
}

@end
