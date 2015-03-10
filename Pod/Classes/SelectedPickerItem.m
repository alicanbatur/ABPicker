//
//  SelectedPickerItem.m
//  MultiColumnPicker
//
//  Created by Ali Can Batur on 6.03.2015.
//  Copyright (c) 2015 DT. All rights reserved.
//

#import "SelectedPickerItem.h"

@implementation SelectedPickerItem

-(instancetype)     initWithPeopleQuantityIndex:(NSInteger) selectedPeopleQuantityIndex
                              selectedDateIndex:(NSInteger) selectedDateIndex
                              selectedHourIndex:(NSInteger) selectedHourIndex
                                   selectedDate:(NSDate *) selectedDate{

    self.peopleQuantityIndex = selectedPeopleQuantityIndex;
    self.dateIndex = selectedDateIndex;
    self.hourIndex = selectedHourIndex;
    self.selectedDate = selectedDate;
    return self;
}

@end
