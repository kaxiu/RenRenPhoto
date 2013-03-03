//
//  MainViewController.m
//  RenrenPhoto
//
//  Created by  on 12-9-6.
//  Copyright (c) 2012年 winddisk.com. All rights reserved.
//

#import "MainViewController.h"
#import "AlbumsViewController.h"
#import "FriendsViewController.h"
#import "LoginViewController.h"
#import "ZoomingScrollView.h"
#import "QueryViewController.h"
#import "FontTestController.h"
#import "RegexKitLite.h"
#import "TrainSession.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize headImageView = _headImageView;
@synthesize userNameLable = _userNameLable;
@synthesize loginButton = _loginButton;
@synthesize logoutButton = _logoutButton;
@synthesize myInfo = _myInfo;

-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}


-(void)renrenLogin:(id)sender
{
    if ([[Renren sharedRenren] isSessionValid]) {
        NSLog(@"session valid");
        [self getMyUserInfo];
    }else {
        NSLog(@"pre login");
        [[Renren sharedRenren] authorizationWithPermission:[Renren permissionArray] withCompletionBlock:^(BOOL success){
            if (success) {
                NSLog(@"login success");
                [self getMyUserInfo];
                if (_logoutButton == nil) {
                    _logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [_logoutButton addTarget:self action:@selector(renrenLogout:) forControlEvents:UIControlEventTouchUpInside];
                    [_logoutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
                    _logoutButton.frame = CGRectMake(215, 15, 100, 30);
                }
                [self.view addSubview:_logoutButton];
            }else {
                NSLog(@"failed login");
            }
        }];
    }
    
    
    
}

-(void)renrenLogout:(id)sender
{
    if ([[Renren sharedRenren] isSessionValid]) {
        [[Renren sharedRenren]delUserSessionInfo];
    }else {
        NSLog(@"alreadyLogOut");
        
    }
    if (_loginButton == nil) {
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginButton addTarget:self action:@selector(renrenLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        _loginButton.frame = CGRectMake(15, 15, 100, 30);
    }
    [self.view addSubview:_loginButton];    
}

-(void)getFriends:(id)sender
{
    /*[[Renren sharedRenren] getFriendsInfoWithCompletionBlock:^(NSArray *friendsArray){
            NSLog(@"friends:%@",friendsArray);
            }
                                           withFailedBlock:^(NSError *error){
            NSLog(@"Error:%@",error);
    }];*/
    
   /* [[Renren sharedRenren] getUserAlbums:@"240912832" withCompletionBlock:
     ^(NSArray* albumsArray){
         NSLog(@"%@",albumsArray);
     } failedBlock:
     ^(NSError *error){
            NSLog(@"Error:%@",error);
     }];*/
    
   /* [[Renren sharedRenren] getPhotosUser:@"240912832" album:@"378298331" 
                     withCompletionBlock:^(NSArray *photosArray){
                         NSLog(@"photoArray:%@",photosArray);
                     } failedBlock:^(NSError *error){
                         NSLog(@"error:%@",error);
                     }];*/
    [[Renren sharedRenren] getPhotoCommentsUser:@"240912832" pid:@"3084483597" withCompletionBlock:^(NSArray *commentsArray){
        NSLog(@"comments:%@",commentsArray);
    } failedBlock:^(NSError *error){
        NSLog(@"error:%@",error);
    }];

//240912832
    //240912832-378298331-3084483597
}

-(void)getMyUserInfo
{
    NSString *uid = [Renren sharedRenren].uid;
    __weak MainViewController *blockSelf = self;
    if (uid) {
        [[Renren sharedRenren] getUserInfo:uid withCompletionBlock:^(UserInfo* userInfo){
            self.myInfo = userInfo;
            UIImage *headImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:userInfo.headurl]]];
            [blockSelf.headImageView setImage:headImage];
            [blockSelf.userNameLable setText:userInfo.name];
            [blockSelf.loginButton setHidden:YES];
            
        } failedBlock:^(NSError *error){
            NSLog(@"getMyUserInfo:%@",error);
        }];
    }else
    {
        [[Renren sharedRenren] authorizationWithPermission:[Renren permissionArray] withCompletionBlock:^(BOOL success){
            if (success) {
                [self performSelector:@selector(getMyUserInfo)];
            }else{
                NSLog(@"getMyUserInfo authorization Failed");
            }
        }];
    }
}

-(void)myPhoto:(id)sender
{
    [[Renren sharedRenren]getUserAlbums:[[Renren sharedRenren]uid] withCompletionBlock:^(NSArray* albumsArray){
        AlbumsViewController *controller = [[AlbumsViewController alloc]init];
        controller.albumsArray = [NSArray arrayWithArray:albumsArray];
        controller.owner = self.myInfo;
        [self.navigationController pushViewController:controller animated:YES];
    } failedBlock:^(NSError *error){
        NSLog(@"getMyPhoto:%@",error);
    }];
}

-(void)friendsPhoto:(id)sender
{
    [[Renren sharedRenren] getFriendsInfoWithCompletionBlock:^(NSArray *friendsArray){
        FriendsViewController *controller = [[FriendsViewController alloc]init];
        controller.friendsArray = [NSArray arrayWithArray:friendsArray];
        [self.navigationController pushViewController:controller animated:YES];
    } withFailedBlock:^(NSError *error){
        NSLog(@"getFrineds Error:%@",error);
    }];
}

-(void)showImage:(id)sender
{
    ZoomingScrollView *scrollView = [[ZoomingScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [UIApplication sharedApplication].statusBarHidden = YES;
    UIImage *localImage = [UIImage imageNamed:@"yulee.jpeg"];
    //UIImage *netWorkImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://imglf9.ph.126.net/1MHqgF5gjUsyDtA03_hyLw==/2490772068930385919.jpg"]]];
    [scrollView setImage:localImage];
    //[[[UIApplication sharedApplication] keyWindow] addSubview:scrollView];
    [self.view addSubview:scrollView];
    
}


-(void)login12306:(id)sender
{
    LoginViewController *login12306 = [[LoginViewController alloc]init];
    //[self.navigationController pushViewController:login12306 animated:YES];
    
    
    /*<td>硬卧(452.00元)无票</td>
	
    
    
    <td>硬座(257.00元)无票</td>
	
    
    
    <td>软卧(720.00元)无票</td>
	
    
    
    <td>无座(257.00元)有票</td>*/
    
    //\<td\>(.*?)\(.*\)(.*)\<\/td\>
    NSString *fileName = [NSString stringWithFormat:@"%@/trainInfo.txt",NSHomeDirectory()];
    NSError *error;
    NSString *responce = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:&error];
    //NSString *responce = @"   <td>软卧(720.00元)无票</td>   <td>无座(257.00元)有票</td>";
    NSString *regexString = @"\\<td\\>(.*?)\\(.*?\\)(.*?)\\<\\/td\\>";    
    [responce enumerateStringsMatchedByRegex:regexString usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSLog(@"captureCount:%d string:%@",captureCount,capturedStrings[0]);
        NSString *catptureString = capturedStrings[0];
        NSString *seatTypeName = [catptureString stringByMatching:@"\\<td\\>(.*?)\\((.*?)\\)" capture:1];
        NSString *price = [catptureString stringByMatching:@"\\<td\\>(.*?)\\((.*?)元\\)" capture:2];
        NSLog(@"seat:%@ price:%@",seatTypeName,price);
        NSMutableArray *seatTypeArray = [TrainSession sharedSession].seatTypeArray;
        for (SeatType *seat in seatTypeArray) {
            if([seat.seatTypeName isEqualToString:seatTypeName])
            {
                seat.seatPrice = price;
                break;
            }
        }
        
        
        
    }];
    
    //[responce writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:&error];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 40, 40)];
    [self.view addSubview:_headImageView];
    
    _userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 100, 20)];
    _userNameLable.backgroundColor = [UIColor clearColor];
    _userNameLable.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:_userNameLable];
    
    if ([[Renren sharedRenren] isSessionValid]) {
        [self performSelector:@selector(getMyUserInfo) withObject:nil afterDelay:0.0];
        _logoutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_logoutButton addTarget:self action:@selector(renrenLogout:) forControlEvents:UIControlEventTouchUpInside];
        [_logoutButton setTitle:@"退出登陆" forState:UIControlStateNormal];
        _logoutButton.frame = CGRectMake(215, 15, 100, 30);
        [self.view addSubview:_logoutButton];
        
    }else{
        _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_loginButton addTarget:self action:@selector(renrenLogin:) forControlEvents:UIControlEventTouchUpInside];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
        _loginButton.frame = CGRectMake(15, 15, 100, 30);
        [self.view addSubview:_loginButton];
    }
    
    UIButton *myPhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [myPhotoButton addTarget:self action:@selector(myPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [myPhotoButton setTitle:@"我的人人相册" forState:UIControlStateNormal];
    myPhotoButton.frame =  CGRectMake(15, 65, 130.0, 100.0);
    [self.view addSubview:myPhotoButton];
    
    UIButton *friendsPhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [friendsPhotoButton addTarget:self action:@selector(friendsPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [friendsPhotoButton setTitle:@"人人好友相册" forState:UIControlStateNormal];
    friendsPhotoButton.frame =  CGRectMake(155, 65, 130.0, 100.0);
    [self.view addSubview:friendsPhotoButton];
    
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [loginButton addTarget:self action:@selector(login12306:) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setTitle:@"12306" forState:UIControlStateNormal];
    loginButton.frame =  CGRectMake(15, 200, 130.0, 100.0);
    [self.view addSubview:loginButton];
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [imageButton addTarget:self action:@selector(showImage:) forControlEvents:UIControlEventTouchUpInside];
    [imageButton setTitle:@"显示图片" forState:UIControlStateNormal];
    imageButton.frame =  CGRectMake(155, 200, 130.0, 100.0);
    [self.view addSubview:imageButton];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)dealloc
{
    [[Renren sharedRenren] saveUserSessionInfo];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"mainViewCountroller touchBegain");
    NSLog(@"%@",[NSThread callStackSymbols]);
}
@end
