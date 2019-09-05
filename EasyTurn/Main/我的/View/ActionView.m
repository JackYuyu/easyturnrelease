//
//  ActionView.m
//  XingHou
//
//  Created by 陈林 on 16/6/24.
//  Copyright © 2016年 CYX. All rights reserved.
//

#import "ActionView.h"

@implementation ActionView

- (IBAction)cameraClick:(UIButton *)sender {
    if (self.block) {
        self.block(sender);
    }
}

- (IBAction)albumClick:(UIButton *)sender {
    if (self.block) {
        self.block(sender);
    }
}

- (IBAction)cancelClick:(UIButton *)sender {
    if (self.block) {
        self.block(sender);
    }
}

@end
