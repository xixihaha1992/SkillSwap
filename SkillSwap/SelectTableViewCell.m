//
//  SelectTableViewCell.m
//  SkillSwap
//
//  Created by Chen Zhu on 5/8/15.
//  Copyright (c) 2015 Chen Zhu. All rights reserved.
//

#import "SelectTableViewCell.h"

@implementation SelectTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectButtonPressed:(id)sender {
    if (self.isSelected) {
        UIImage *unselectImg = [UIImage imageNamed:@"uncheckImg"];
        [self.selectButton setImage:unselectImg forState:UIControlStateNormal];
        self.isSelected = false;
        [self.myDelegate buttonUnchecked:self];
    } else {
        UIImage *selectImg = [UIImage imageNamed:@"checkImg"];
        [self.selectButton setImage:selectImg forState:UIControlStateNormal];
        self.isSelected = true;
        [self.myDelegate buttonChecked:self];
    }
}
@end
