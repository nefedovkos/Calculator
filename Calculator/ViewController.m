//
//  ViewController.m
//  Calculator
//
//  Created by Konstantin Nefedov on 15/04/2020.
//  Copyright © 2020 Konstantin Nefedov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
double firstNumber=0;
double secondNumber=0;
double result=0;
bool operatorPressed=false;
bool periodPressed=false;
bool toGiveAnswer=false;
bool isPrecentPressed=false;
bool toCleanDisplayForSecondValue=false;
int operator=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)removeZeroInEnd{
    bool havePeriod=false;
    const char *charArray = [_displayResult.text UTF8String];
    int length = (int)[_displayResult.text length];
    for(int index=0; index<length; index++){
        if(charArray[index] == '.'){
            havePeriod=true;
        }
    }
    if(havePeriod){
        for (int i = 0; i < [_displayResult.text length]; i++){
                    if([_displayResult.text hasSuffix:@"0"]){
                        _displayResult.text = [_displayResult.text substringToIndex:[_displayResult.text length]-1];
                }
        }
        for (int i = 0; i < [_displayResult.text length]; i++){
                    if([_displayResult.text hasSuffix:@"0"]){
                        _displayResult.text = [_displayResult.text substringToIndex:[_displayResult.text length]-1];
                }
        }
        if([_displayResult.text hasSuffix:@"."]){
        _displayResult.text = [_displayResult.text substringToIndex:[_displayResult.text length]-1];
        }
    }
}
- (double) calculateResult:(int)operetorNum{
    double result=0;
        if (operetorNum==13){   // %
        result = (firstNumber/100)*secondNumber;
        toGiveAnswer=false;
        _displayResult.text=[NSString stringWithFormat:@"%f", result];
        firstNumber=result;
        secondNumber=0;
    }
    if (operetorNum==14){   // /
        if(secondNumber==0){
            _displayResult.text=@"ERROR";
            firstNumber=0;
            secondNumber=0;
            operatorPressed=false;
            periodPressed=false;
        } else{
            result = firstNumber/secondNumber;
            toGiveAnswer=false;
            _displayResult.text=[NSString stringWithFormat:@"%f", result];
            firstNumber=result;
            secondNumber=0;
        }
    }
    if (operetorNum==15){   // *
        result = firstNumber*secondNumber;
        toGiveAnswer=false;
        _displayResult.text=[NSString stringWithFormat:@"%f", result];
        firstNumber=result;
        secondNumber=0;
    }
    if (operetorNum==16){   // -
        result = firstNumber-secondNumber;
        toGiveAnswer=false;
        _displayResult.text=[NSString stringWithFormat:@"%f", result];
        firstNumber=result;
        secondNumber=0;
    }
    if (operetorNum==17){   // +
        result = firstNumber+secondNumber;
        toGiveAnswer=false;
        _displayResult.text=[NSString stringWithFormat:@"%f", result];
        firstNumber=result;
        secondNumber=0;
    }
    return result;
}
- (IBAction)digits:(UIButton *)sender {
    _ACchangedC.titleLabel.text=@" C";
    _displayResult.adjustsFontSizeToFitWidth=true;
    if (operatorPressed){
        if(toCleanDisplayForSecondValue){
            _displayResult.text=@"";
            toCleanDisplayForSecondValue=false;
        }
        if([_displayResult.text isEqual:@""]){
            if(sender.tag==10){
                _displayResult.text=@"0.";
                    periodPressed=true;
                } else{
                _displayResult.text=[NSString stringWithFormat:@"%li",(long)sender.tag];
            }
        } else {
            if(sender.tag==10){
                if(!periodPressed){
                _displayResult.text=[NSString stringWithFormat:@"%@.", _displayResult.text];
                    periodPressed=true;
                }
            } else{
                _displayResult.text=[NSString stringWithFormat:@"%@%li", _displayResult.text,(long)sender.tag];
            }
        }
        toGiveAnswer=true;
        secondNumber=[_displayResult.text doubleValue];
    } else {
        if([_displayResult.text isEqual:@"0"]){
            if(sender.tag==10){
                _displayResult.text=@"0.";
                    periodPressed=true;
                } else{

                _displayResult.text=[NSString stringWithFormat:@"%li",(long)sender.tag];
            }
        } else {
            if(sender.tag==10){
                if(!periodPressed){
                _displayResult.text=[NSString stringWithFormat:@"%@.", _displayResult.text];
                    periodPressed=true;
                }
            } else{
                _displayResult.text=[NSString stringWithFormat:@"%@%li", _displayResult.text,(long)sender.tag];
            }
        }
        firstNumber=[_displayResult.text doubleValue];
    }
    isPrecentPressed=false;
}
- (IBAction)functoinButtons:(UIButton *)sender {
    if (sender.tag==12){   // +/-
        if(operatorPressed){
            if(secondNumber!=0){
                if(secondNumber == [_displayResult.text doubleValue]){
                secondNumber=-(secondNumber);
                _displayResult.text=[NSString stringWithFormat:@"%f", secondNumber];
                }
            } else {
                if(firstNumber!=0){
                    firstNumber=-(firstNumber);
                    _displayResult.text=[NSString stringWithFormat:@"%f", firstNumber];
                }
            }
        } else {
            if(firstNumber!=0){
                firstNumber=-(firstNumber);
                _displayResult.text=[NSString stringWithFormat:@"%f", firstNumber];
            }
        }
    }
    if (sender.tag==13){   // %
        if(toGiveAnswer){
            secondNumber = (firstNumber/100)*secondNumber;
            result = [self calculateResult:operator];
        } else {
            if(!operatorPressed){
                secondNumber=1;
                result = [self calculateResult:13];
            }
        }
        operatorPressed=true;
        periodPressed=false;
        toCleanDisplayForSecondValue=true;
        operator=13;
    }
    if (sender.tag==14){   // /
       if(toGiveAnswer){
           result = [self calculateResult:operator];
       }
       operator=14;
    }
    if (sender.tag==15){   // *
        if(toGiveAnswer){
            result = [self calculateResult:operator];
        }
        operator=15;
    }
    if (sender.tag==16){   // -
        if(toGiveAnswer){
            result = [self calculateResult:operator];
        }
        operator=16;
    }
    if (sender.tag==17){   // +
        if(toGiveAnswer){
            result = [self calculateResult:operator];
        }
        operator=17;
    }
    operatorPressed=true;
    if (sender.tag==18){  //=
        if(toGiveAnswer){
            result = [self calculateResult:operator];
            operatorPressed=false;
            operator = 18;
        } else {
            //result = [self calculateResult:operator];
            operatorPressed=false;
            operator=18;
        }
    }
    if (sender.tag==11){    // AC
        _displayResult.text=@"0";
        firstNumber=0;
        secondNumber=0;
        operatorPressed=false;
        toGiveAnswer=false;
    }
    periodPressed=false;
    toCleanDisplayForSecondValue=true;
    [self removeZeroInEnd];
}
@end
