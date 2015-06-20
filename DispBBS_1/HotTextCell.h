//
//  HotTextCell.h
//  DispBBS_1
//
//  Created by ChangHsaio ni on 2015/6/20.
//  Copyright (c) 2015年 ChangHsaio ni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotTextCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UILabel *titleLabel;
@property(nonatomic,weak)IBOutlet UILabel *descLabel;
@property(nonatomic,weak)IBOutlet UIImageView *thumbImageView;
@end