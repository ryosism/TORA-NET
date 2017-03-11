//
//  autoLoginSetting.h
//  TORA-NET
//
//  Created by 祖父江亮 on 2017/01/25.
//  Copyright © 2017年 Ryo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface autoLoginSetting : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UITextField *passwd;

- (IBAction)saveButtonPushed:(id)sender;
- (IBAction)switchChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *enableSwitch;

@end
