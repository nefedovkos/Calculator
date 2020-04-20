//
//  ViewController.h
//  Calculator
//
//  Created by Konstantin Nefedov on 15/04/2020.
//  Copyright © 2020 Konstantin Nefedov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)digits:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *displayResult;
@property (weak, nonatomic) IBOutlet UIButton *ACchangedC;
- (IBAction)functoinButtons:(UIButton *)sender;
- (double) calculateResult:(int)operetorNum;
- (void) removeZeroInEnd;
@end

