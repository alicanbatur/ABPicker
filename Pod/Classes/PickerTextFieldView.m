//
//  PickerTextFieldView.m
//  MultiColumnPicker
//
//  Created by Ali Can Batur on 5.03.2015.
//  Copyright (c) 2015 DT. All rights reserved.
//

#import "PickerTextFieldView.h"


#define VIEW_CLOSED_HEIGT 50
#define VIEW_OPENED_HEIGT 210
#define UPDATE_BUTTON_WIDTH 100
#define ANIMATION_DURATION_TOGGLE_VIEW 0.3

@interface PickerTextFieldView(){
    
    
    BOOL didPickerOpened;
    
    CGFloat screenWidth;
    CGFloat screenHeight;
    
    NSInteger hour;
}

@property (nonatomic) UIPickerView *pickerView;
@property (nonatomic) UIButton *refreshButton;
@property (nonatomic) NSDateFormatter * dateFormatter;
@property (nonatomic) NSDateComponents * components;
@property (nonatomic) NSCalendar * gregorian;
@property (nonatomic) UITextField * textField;
@end


@implementation PickerTextFieldView



-(void)awakeFromNib{
    [super awakeFromNib];
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    if(self.buttonText == nil){
        self.buttonText = @"Refresh";
    }
    
    if(self.placeHolderText == nil){
        self.placeHolderText = @"Please Tap";
    }
    
    if(self.localeIdentifier == nil){
        self.localeIdentifier = @"en_GB";
    }
    
    if(self.selectedItemStringPattern == nil){
        self.selectedItemStringPattern = @"%@, %@, %@";
    }
    
    didPickerOpened = NO;
    
    
    [self setBackgroundColor:[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]];
    self.clipsToBounds = YES;
    
    //init textField
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 8, screenWidth - 30, VIEW_CLOSED_HEIGT - 16)];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = self.placeHolderText;
    self.textField.delegate = self;
    self.textField.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.textField];
    
    //init refresh button
    self.refreshButton = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth, 8, UPDATE_BUTTON_WIDTH - 16, VIEW_CLOSED_HEIGT - 16)];
    [self.refreshButton setTitle:self.buttonText forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    self.refreshButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.refreshButton.layer.cornerRadius = 8;
    self.refreshButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.refreshButton.layer.borderWidth=1.0f;
    [self.refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    self.refreshButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.refreshButton];
    
    
    //init pickerView.
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, VIEW_CLOSED_HEIGT, screenWidth, 10)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.alpha = 0.0;
    [self addSubview:self.pickerView];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:self.localeIdentifier]];
    self.components = [[NSDateComponents alloc] init];
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

-(void) refresh:(SelectedPickerItem*) selectedPickerItem{
    
    //first columns value
    NSString * firstColumnStringValue = [self.dtPickerDataSource pickerTextFieldView:self itemAtIndexInCustomColumn:[self.pickerView selectedRowInComponent:0]];
    
    //hour columns value.
    NSString * hourString = [NSString stringWithFormat:@"%.2li:00", [self.pickerView selectedRowInComponent:2] + self.minHour];
    
    //date columns value.
    [self.components setDay:[self.pickerView selectedRowInComponent:1]];
    NSDate * dateAddedDate = [self.gregorian dateByAddingComponents:self.components toDate:[NSDate date] options:0];
    dateAddedDate = [self setTimeToDate:dateAddedDate withTime:hourString];
    
    selectedPickerItem = [[SelectedPickerItem alloc] initWithPeopleQuantityIndex:[self.pickerView selectedRowInComponent:0] selectedDateIndex:[self.pickerView selectedRowInComponent:1] selectedHourIndex:[self.pickerView selectedRowInComponent:2] selectedDate:dateAddedDate];
    
    //set values to textfield in view.
    self.textField.text = [NSString stringWithFormat:self.selectedItemStringPattern,firstColumnStringValue,[self formatDate:dateAddedDate withFormat:self.dateFormat],hourString];
    
    [self closePicker];
    if([self.dtPickerDelegate respondsToSelector:@selector(refresh:)]){
        [self.dtPickerDelegate refresh:selectedPickerItem];
    }
}

/*
 * If selection rules needed, they can be set here.
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            
        }
            break;
        case 1:{
            
        }
            break;
        case 2:{
            
        }
            break;
        default:
            break;
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(!didPickerOpened){
        [self openPicker];
    }else{
        [self closePicker];
    }
    return NO;
}

-(void) openPicker{
    
    if([self.dtPickerDelegate respondsToSelector:@selector(willOpenPickerArea)]){
        [self.dtPickerDelegate willOpenPickerArea];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:ANIMATION_DURATION_TOGGLE_VIEW];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        CGRect frame = self.textField.frame;
        frame.size.width -= UPDATE_BUTTON_WIDTH;
        self.textField.frame = frame;
        
        frame = self.refreshButton.frame;
        frame.origin.x -= UPDATE_BUTTON_WIDTH;
        self.refreshButton.frame = frame;
        
        self.pickerView.alpha = 1.0;
        
        self.constraintHeight.constant = VIEW_OPENED_HEIGT;
        [self layoutIfNeeded];
        
        
        if([self.dtPickerDelegate respondsToSelector:@selector(didOpenPickerArea)]){
            [self.dtPickerDelegate didOpenPickerArea];
        }
        
        
        [UIView commitAnimations];
    });
    
    didPickerOpened = YES;
}

-(void) closePicker{
    
    if([self.dtPickerDelegate respondsToSelector:@selector(willClosePickerArea)]){
        [self.dtPickerDelegate willClosePickerArea];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:ANIMATION_DURATION_TOGGLE_VIEW];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        
        CGRect frame = self.textField.frame;
        frame.size.width += UPDATE_BUTTON_WIDTH;
        self.textField.frame = frame;
        
        frame = self.refreshButton.frame;
        frame.origin.x += UPDATE_BUTTON_WIDTH;
        self.refreshButton.frame = frame;
        
        self.pickerView.alpha = 0.0;
        
        self.constraintHeight.constant = VIEW_CLOSED_HEIGT;
        [self layoutIfNeeded];
        
        if([self.dtPickerDelegate respondsToSelector:@selector(didClosePickerArea)]){
            [self.dtPickerDelegate didClosePickerArea];
        }
        
        
        [UIView commitAnimations];
    });
    
    didPickerOpened = NO;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [self.dtPickerDataSource pickerTextFieldViewNumberOfItems:self];
            break;
        case 1:{
            return self.dayCount;
        }
            break;
        case 2:{
            return self.maxHour - self.minHour + 1;
        }
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont systemFontOfSize:16]];
        tView.textAlignment = NSTextAlignmentCenter;
    }
    
    switch (component) {
        case 0:
            tView.text = [self.dtPickerDataSource pickerTextFieldView:self itemAtIndexInCustomColumn:row];
            break;
        case 1:{
            [self.components setDay:row];
            NSDate * dateAddedDate = [self.gregorian dateByAddingComponents:self.components toDate:[NSDate date] options:0];
            tView.text = [self formatDate:dateAddedDate withFormat:self.dateFormat];
        }
            break;
        case 2:{
            tView.text = [NSString stringWithFormat:@"%.2li:00", row + self.minHour];
        }
            break;
        default:
            tView.text = @"";
            break;
    }
    return tView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(pickerView == self.pickerView){
        return screenWidth / 3 - 10;
    }
    return 0;
}

-(NSString*)formatDate:(NSDate*)date withFormat:(NSString*) withFormat{
    NSDateFormatter * dateFormatterWithFormat = [[NSDateFormatter alloc] init];
    [dateFormatterWithFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:self.localeIdentifier]];
    [dateFormatterWithFormat setDateFormat:withFormat];
    return [dateFormatterWithFormat stringFromDate:date];
}

-(NSDate*) setTimeToDate:(NSDate*) date withTime:(NSString*) time {
    NSArray* timeValues = [time componentsSeparatedByString: @":"];
    NSString * hourStr = [timeValues objectAtIndex:0];
    NSString * minuteStr = [timeValues objectAtIndex:1];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    comps.hour   = [hourStr integerValue];
    comps.minute = [minuteStr integerValue];
    comps.second = 00;
    return [calendar dateFromComponents:comps];
}


@end
