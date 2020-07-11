//
//  ViewController.m
//  Cenfotec-Calculator
//
//  Created by yespinoza on 7/10/20.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblResult;
@property (weak, nonatomic) NSString *lastExpresion;
@property (weak, nonatomic) NSString *value01;
@property (weak, nonatomic) NSString *value02;
@property (weak, nonatomic) NSString *operation;



@end

@implementation ViewController
Boolean *hasChanged;
NSString *const SUPPORTED_OPERATIONS = @"÷x-+";
NSString *const NONSUPPORT_01 = @"+/-";
NSString *const NONSUPPORT_02 = @"%";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnCalculator:(UIButton*)sender {
    

    
    NSString *buttonText = sender.titleLabel.text;
    if([buttonText  isEqual: NONSUPPORT_01] || [buttonText  isEqual: NONSUPPORT_02]){
        return;
    }
    else if([buttonText  isEqual: @"AC"])
    {
        _lblResult.text = @"0";
        _lastExpresion = NULL;
        _value01 = NULL;
        _value02 = NULL;
    }else if ([SUPPORTED_OPERATIONS containsString:(buttonText)]) {
        _operation = buttonText;
        if(!hasChanged)
            return;
        if(_value01 == NULL){
            _value01 = _lastExpresion;
       }else{
           _value02 = _lastExpresion;
           [self calculate];
       }
    }
    else if([buttonText  isEqual: @"="]){
        if(_value01 != NULL && hasChanged){
            _value02 = _lastExpresion;
           [self calculate];
        }
    }
    else{
        hasChanged = true;
        if([_lblResult.text  isEqual: @"0"] || _value01 != NULL)
            _lastExpresion = buttonText;
        else{
            _lastExpresion = [NSString stringWithFormat:@"%@%@", _lblResult.text, buttonText];
        }
        _lblResult.text = _lastExpresion;
    }
            
}

- (void)calculate{
    
    double result = 0;
    if([_operation isEqual:(@"+")])
        result = ([_value01 doubleValue] + [_value02 doubleValue]);
    else if([_operation isEqual:(@"-")])
        result = ([_value01 doubleValue] - [_value02 doubleValue]);
    else if([_operation isEqual:(@"x")])
        result = ([_value01 doubleValue] * [_value02 doubleValue]);
    else if([_operation isEqual:(@"÷")])
        result = ([_value01 doubleValue] / [_value02 doubleValue]);
    
    _lblResult.text = [NSString stringWithFormat:@"%.f",result];
    [self clearVariables];
}
- (void)clearVariables{
    _operation = NULL;
    _value01 = NULL;
    _value02 = NULL;
    hasChanged = false;
}



@end
