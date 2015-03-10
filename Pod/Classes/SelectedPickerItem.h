//
//  SelectedPickerItem.h
//  MultiColumnPicker
//
//  Created by Ali Can Batur on 6.03.2015.
//  Copyright (c) 2015 DT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedPickerItem : NSObject


@property (nonatomic) NSInteger peopleQuantityIndex;
@property (nonatomic) NSInteger dateIndex;
@property (nonatomic) NSInteger hourIndex;
@property (nonatomic) NSDate * selectedDate;

-(instancetype)     initWithPeopleQuantityIndex:(NSInteger) selectedPeopleQuantityIndex
                              selectedDateIndex:(NSInteger) selectedDateIndex
                              selectedHourIndex:(NSInteger) selectedHourIndex
                                   selectedDate:(NSDate*) selectedDate;
@end
