//
//  PickerTextFieldView.h
//  MultiColumnPicker
//
//  Created by Ali Can Batur on 5.03.2015.
//  Copyright (c) 2015 DT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedPickerItem.h"

@protocol DTPickerDelegate;
@protocol DTPickerDataSource;

@interface PickerTextFieldView : UIView <UITextFieldDelegate,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet id<DTPickerDelegate> dtPickerDelegate;
@property (weak, nonatomic) IBOutlet id<DTPickerDataSource> dtPickerDataSource;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeight;


@property (nonatomic) NSInteger minHour;
@property (nonatomic) NSInteger maxHour;

@property (nonatomic) NSString * dateFormat;
@property (nonatomic) NSInteger dayCount;

@property (nonatomic) NSString * buttonText;
@property (nonatomic) NSString * placeHolderText;
@property (nonatomic) NSString * localeIdentifier;
@property (nonatomic) NSString * selectedItemStringPattern;

@end

@protocol DTPickerDelegate <NSObject>

@optional
-(void) willOpenPickerArea;
-(void) didOpenPickerArea;
-(void) willClosePickerArea;
-(void) didClosePickerArea;
-(void) refresh:(SelectedPickerItem*) selectedPickerItem;
@end

@protocol DTPickerDataSource <NSObject>

@required
- (NSString *)pickerTextFieldView:(PickerTextFieldView *)pickerTextFieldView itemAtIndexInCustomColumn:(NSInteger)index ;
- (NSInteger)pickerTextFieldViewNumberOfItems:(PickerTextFieldView *)pickerTextFieldView;
@end
