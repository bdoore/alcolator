//
//  BLCMainMenuViewController.m
//  Alcolator
//
//  Created by Brian Doore on 9/6/14.
//  Copyright (c) 2014 Brian Doore. All rights reserved.
//

#import "BLCMainMenuViewController.h"

@interface BLCMainMenuViewController ()

@property (weak, nonatomic) UIButton *wineButton;
@property (weak, nonatomic) UIButton *whiskeyButton;

@end

@implementation BLCMainMenuViewController


- (void)loadView
{
    self.view = [[UIView alloc] init];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    
    self.wineButton = button1;
    self.whiskeyButton = button2;
    
    
}

- (void) viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    CGRect screenBounds = self.view.bounds;
    
    CGFloat viewWidth = screenBounds.size.width;
    CGFloat viewHeight = screenBounds.size.height;
    //CGFloat padding = 20;
    CGFloat itemWidth = (viewWidth)/2;
    CGFloat yMidpoint = (viewHeight)/2;
    CGFloat itemHeight = 44;
    
    self.wineButton.frame = CGRectMake(0, yMidpoint, itemWidth, itemHeight);
    
    self.whiskeyButton.frame = CGRectMake(itemWidth,yMidpoint,itemWidth, itemHeight);
    self.title = NSLocalizedString(@"Select Alcolator", @"alcolator");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:(.9) green:(.9) blue:(1) alpha:(.9)];
    
    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.wineButton setTitle:NSLocalizedString(@"Wine", @"Wine Tab") forState:UIControlStateNormal];
    
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.whiskeyButton setTitle:NSLocalizedString(@"Whiskey", @"Whiskey Tab") forState:UIControlStateNormal];

    
    
}

- (void) winePressed:(UIButton *) sender {
    ViewController *wineVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    BLCWhiskeyViewController *whiskeyVC = [[BLCWhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
