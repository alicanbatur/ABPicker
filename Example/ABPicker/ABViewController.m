//
//  ABViewController.m
//  ABPicker
//
//  Created by alicanbatur on 03/10/2015.
//  Copyright (c) 2014 alicanbatur. All rights reserved.
//

#import "ABViewController.h"

@interface ABViewController ()

@end

@implementation ABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //set your custom values to picker.
    self.abPickerView.maxHour = 23;
    self.abPickerView.minHour = 8;
    
    self.abPickerView.dateFormat = @"dd MMM EEE";
    self.abPickerView.dayCount = 21;
    
    //optinal
    //self.abPickerView.buttonText = @"";           //default : "Refresh"
    //self.abPickerView.placeHolderText = @"";      //default : "Please Tap"
    //self.abPickerView.localeIdentifier = @"";     //default : "en_GB"



}

#pragma mark - Picker Delegate
-(void)refresh:(SelectedPickerItem *)selectedPickerItem{
    //here you have selected item.
}

#pragma mark - Picker Data Source
- (NSString *)pickerTextFieldView:(PickerTextFieldView *)pickerTextFieldView itemAtIndexInCustomColumn:(NSInteger)index {
    return [NSString stringWithFormat:@"%li People",index + 1];
}

-(NSInteger)pickerTextFieldViewNumberOfItems:(PickerTextFieldView *)pickerTextFieldView{
    return 20;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
