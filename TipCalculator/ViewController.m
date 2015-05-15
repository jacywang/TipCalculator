//
//  ViewController.m
//  TipCalculator
//
//  Created by JIAN WANG on 5/15/15.
//  Copyright (c) 2015 JWANG. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate, UITextInputTraits>

@property (strong, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (strong, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (strong, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (strong, nonatomic) IBOutlet UISlider *tipSlider;

@property (assign, nonatomic) float billBeforeTips;
@property (assign, nonatomic) float tips;
@property (assign, nonatomic) float tipPercentage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.billAmountTextField.delegate = self;
    self.tipPercentageTextField.delegate = self;
    [self.tipSlider addTarget:self action:@selector(moveTipSlider:) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    [self.billAmountTextField resignFirstResponder];
    [self.tipPercentageTextField resignFirstResponder];
    
    self.tips = self.billBeforeTips * self.tipPercentage;
    self.tipAmountLabel.text = [NSString stringWithFormat:@"%.2f", self.tips];;
    self.billAmountTextField.text = @"";
    self.tipPercentageTextField.text = @"";
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [textField becomeFirstResponder];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.billAmountTextField) {
        self.billBeforeTips = [textField.text floatValue];
        NSLog(@"bill - %f", self.billBeforeTips);
    } else if (textField == self.tipPercentageTextField) {
        self.tipPercentage = [textField.text floatValue] / 100;
         NSLog(@"tipPecentage - %f", self.tipPercentage);
    }
}

-(IBAction)moveTipSlider:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%.2f", sender.value];
    self.tipPercentage = [self.tipPercentageTextField.text floatValue] / 100;
}

@end
