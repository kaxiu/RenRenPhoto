//
//  FriendsViewController.h
//  RenrenPhoto
//
//  Created by xuguoxing on 12-9-16.
//  Copyright (c) 2012年 winddisk.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Renren.h"
@interface FriendsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_friendsArray;
    NSMutableArray *_friendAlbumArray;
    UITableView *_tableView;
}
@property (nonatomic) NSArray *friendsArray;
@property (nonatomic) NSMutableArray *friendsAlbumArray;
@end
