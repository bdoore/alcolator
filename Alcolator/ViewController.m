//
//  ViewController.m
//  Alcolator
//
//  Created by Brian Doore on 9/4/14.
//  Copyright (c) 2014 Brian Doore. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController


- (void)loadView
{
    
    self.view = [[UIView alloc] init];
    
    
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UILabel *beerLabel = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:beerLabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    beerLabel.textAlignment = NSTextAlignmentCenter;
    
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.beerCountLabel = beerLabel;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;

}


- (void) viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    
    CGRect screenBounds = self.view.bounds;
    
    CGFloat viewWidth = screenBounds.size.width;
    CGFloat viewHeight = screenBounds.size.height;
    CGFloat padding = 20;
    //CGFloat navBarHeight = 44;
    //CGFloat navBarLandscape = 34;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    //CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    //self.beerCountLabel.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
     
   //CGFloat bottomOfBeerLabel = CGRectGetMaxY(self.beerCountLabel.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 2);
    
    CGFloat buttonPosition = viewHeight - (itemHeight*2) - padding;
    self.calculateButton.frame = CGRectMake(padding, buttonPosition, itemWidth, itemHeight);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    
    
}


- (instancetype) init {
    self = [super init];
    
    if (self) {
        
        self.title = NSLocalizedString(@"Wine", @"wine");
        
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:(.9) green:(1) blue:(1) alpha:(.9)];
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    self.beerPercentTextField.borderStyle = UITextBorderStyleRoundedRect;
    CGFloat fieldFontSize = self.beerPercentTextField.font.pointSize;
    self.beerPercentTextField.font = [UIFont fontWithName:@"Avenir" size:fieldFontSize];
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:fieldFontSize];
    
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    self.resultLabel.font = [UIFont fontWithName:@"Avenir" size:fieldFontSize];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0)
        sender.text = nil;
    
}


- (void)sliderValueDidChange:(UISlider *)sender {

    int numberOfBeers = sender.value;
    NSLog(@"Slider value changed to %i", numberOfBeers);
    if (numberOfBeers == 1)
        self.beerCountLabel.text = [NSString stringWithFormat:@"%d Beer", numberOfBeers];
    else
        self.beerCountLabel.text = [NSString stringWithFormat:@"%d Beers", numberOfBeers];
    
    //self.title = [NSString stringWithFormat:@"Wine (%i beers)", numberOfBeers];
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];

}


- (void)buttonPressed:(UIButton *)sender {
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWineGlass = 5;
    float alcoholPercentageOfWine = .13;
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    NSLog(@"%f",ouncesOfAlcoholTotal);
    
    NSString *beerText;
    
    if(numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if(numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ cointains as much alcohol as %.1f %@ of wine.", nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
}


- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
}




@end
