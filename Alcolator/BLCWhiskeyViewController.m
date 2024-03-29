//
//  BLCWhiskeyViewController.m
//  Alcolator
//
//  Created by Brian Doore on 9/5/14.
//  Copyright (c) 2014 Brian Doore. All rights reserved.
//

#import "BLCWhiskeyViewController.h"

@interface BLCWhiskeyViewController ()


@end

@implementation BLCWhiskeyViewController

- (instancetype) init {
    self = [super init];
    
    if (self) {
        
        self.title = NSLocalizedString(@"Whiskey", nil);
        
         [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];
    }
    return self;
}

- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    float ouncesInOneWhiskeyGlass = 1;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    
    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfWhiskeyGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWhiskeyGlass;
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *whiskeyText;
    
    if (numberOfWhiskeyGlassesForEquivalentAlcoholAmount == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of whiskey.", nil), numberOfBeers, beerText, numberOfWhiskeyGlassesForEquivalentAlcoholAmount, whiskeyText];
    self.resultLabel.text = resultText;
}

/*- (void)sliderValueDidChange:(UISlider *)sender {
    
    int numberOfBeers = sender.value;
    NSLog(@"Slider value changed to %i", numberOfBeers);
    
    if (numberOfBeers == 1)
        self.beerCountLabel.text = [NSString stringWithFormat:@"%d Beer", numberOfBeers];
    else
        self.beerCountLabel.text = [NSString stringWithFormat:@"%d Beers", numberOfBeers];
    
    //self.title = [NSString stringWithFormat:@"Whiskey (%i beers)", numberOfBeers];
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];

}*/


- (void) viewDidLoad
{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(1) green:(1) blue:(.9) alpha:(.9)];

    //self.title = NSLocalizedString(@"Whiskey", @"whiskey");
}

@end
