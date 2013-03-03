//
//  MenuTableViewCell.h
//  StackScrollView
//
//  Created by Aaron Brethorst on 5/15/11.
//  Copyright 2011 Structlab LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTableViewCell : UITableViewCell
{
	UIImageView *glowView;
}
@property(nonatomic,strong) UIImageView *glowView;

@property (nonatomic) UIImage *image;
@property (nonatomic) UIImage *highlightImage;

@end
