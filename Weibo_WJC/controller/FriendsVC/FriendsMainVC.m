//
//  FriendsMainVC.m
//  Weibo_WJC
//
//  Created by TRALIN on 13-3-7.
//  Copyright (c) 2013年 TRALIN. All rights reserved.
//

#import "FriendsMainVC.h"

@interface FriendsMainVC ()

@end

@implementation FriendsMainVC

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cellDataArray = [[[NSMutableArray alloc]init]autorelease];
        [self.cellDataArray addObject:@"最近无联系人"];
        self.headCellDataArr = [NSMutableArray arrayWithObjects:@"最近联系人",@"全部关注",@"相互关注", @"名人明星",@"同事",@"特别关注",@"同学",@"未分组",@"粉丝",nil];
        
    }
    return self;
}

-(void)dealloc
{
    self.tableView = nil;
    self.cellDataArray = nil;
    self.headInserV = nil;
    self.headCellDataArr = nil;
    
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    UIBarButtonItem * homeButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"popover_icon_gohome@2x"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionHomeButton:)];
    
    self.navigationItem.rightBarButtonItem = homeButton;
    [homeButton release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
	// Do any additional setup after loading the view.
    self.tableView = [[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 460-44-40)
                                                 style:UITableViewStylePlain]autorelease];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    // NAVC:
    UIView * navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    navView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:navView];
    [navView release];
    //
    self.headViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headViewButton setTitle:@"最近联系人" forState:UIControlStateNormal];
    self.headViewButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:20];
    [self.headViewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.headViewButton.frame = CGRectMake(100, 5, 150, 44);
    self.headViewButton.center = navView.center;
    self.headViewButton.backgroundColor = [UIColor clearColor];
    [self.headViewButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    [self.headViewButton addTarget:self
                       action:@selector(actionHeadViewButton:)
             forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.headViewButton];
    // 加载头部View：
    [self addHeadView];
    
    
}
#pragma mark -----addHeadView：
-(void)addHeadView
{
    self.headInserV = [[[L_HeadInsertView alloc]initWithFrame:CGRectMake(80, 44, 320-160, 225)]autorelease];
    self.headInserV.tableView.delegate = self;
    self.headInserV.tableView.dataSource = self;
    self.headInserV.backgroundColor = [UIColor blackColor];
    self.headInserV.alpha = 0.85f;
    self.headInserV.hidden = YES;
    [self.view addSubview:self.headInserV];
    //
    [self.headInserV.updateButton addTarget:self
                                     action:@selector(actionHeadUpdataBtn:)
                           forControlEvents:UIControlEventTouchUpInside];
    [self.headInserV.editButton addTarget:self
                                   action:@selector(actionHeadEditBtn:)
                         forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark -----UITableViewDataSource-----

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.headInserV.tableView)
    {
        NSString *cellIdentifier = [NSString stringWithFormat:@"cell%d-%d",indexPath.section,indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell)
        {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier]autorelease];
        }
        
        cell.textLabel.text = [self.headCellDataArr objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
        
        UILabel * textLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 50, 25)];
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.textColor = [UIColor grayColor];
        textLabel.textAlignment = NSTextAlignmentRight;
        NSString * textStr = @"(0)";
        
        textLabel.text = textStr;
        [cell addSubview:textLabel];
        [textLabel release];
        
        return cell;
    }
    else
    {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (nil == cell)
        {
            cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier]autorelease];
        }
        
        cell.imageView.image = [UIImage imageNamed:@"user"];
        if (0 == indexPath.section)
        {
            cell.textLabel.text = @"找朋友";
            
        }
        else if (1 == indexPath.section)
        {
            // TODO: 加 Button:
            cell.textLabel.text = @"用户名";
            //
            UIButton * weiboButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            weiboButton.frame = CGRectMake(170, 3, 44, 44);
            weiboButton.tag = 1100;
            [weiboButton setTitle:@"weibo" forState:UIControlStateNormal];
            [weiboButton addTarget:self
                            action:@selector(actionCellButtonS1:)
                  forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:weiboButton];
            //
            UIButton * collectionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            collectionButton.frame = CGRectMake(170+50, 3, 44,44);
            collectionButton.tag = 1101;
            [collectionButton setTitle:@"col" forState:UIControlStateNormal];
            [collectionButton addTarget:self
                                 action:@selector(actionCellButtonS1:)
                       forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:collectionButton];
            //
            UIButton * fansButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            fansButton.frame = CGRectMake(170+50+50, 3, 44,44);
            fansButton.tag = 1102;
            [fansButton setTitle:@"fans" forState:UIControlStateNormal];
            [fansButton addTarget:self
                           action:@selector(actionCellButtonS1:)
                 forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:fansButton];
            
        }
        else
        {
            // TODO: 最近联系人：
            
        }
        
        return cell;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.headInserV.tableView)
    {
        headSelectInteger = indexPath;
        self.headInserV.hidden = YES;
        [self.headViewButton setTitle:[self.headCellDataArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        //TODO: 传值： 将所选 项的值 传给 第三段Cell:
        
        
    }
    else
    {
        if (0 == indexPath.section)
        {
            L_LookForFriendViewController * lookForFriendVC = [[L_LookForFriendViewController alloc]init];
            [self.navigationController pushViewController:lookForFriendVC animated:YES];
            [lookForFriendVC release];
            
        }
        else
        {
            //TODO: 推到相应的主页：
            
        }
        
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.headInserV.tableView)
    {
        return 1;
    }
    else
    {
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.headInserV.tableView)
    {
        return self.headCellDataArr.count;
    }
    else
    {
        if (0 == section || 1 == section)
            return 1;
        else
            return self.cellDataArray.count;
    }

}

#pragma mark - Table view delegate

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.headInserV.tableView)
    {
        return nil;
    }
    else
    {
        NSArray * titleArray = [NSArray arrayWithObjects:@"",@"我的资料",@"最近联系人", nil];
        return [titleArray objectAtIndex:section];
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.headInserV.tableView)
    {
        return nil;
    }
    else
    {
        if (0 == section)
        {
            self.cellHeadView = [[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)]autorelease];
            UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
            
            [self.cellHeadView addSubview:searchBar];
            [searchBar release];
            
            return self.cellHeadView;
        }
        else
        {
            return nil;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.headInserV.tableView)
    {
        return 25.0f;
    }
    else
    {
        CGFloat f = 50.0f;
        
        if (0 == indexPath.section)
            f = 50.0f;
        else if(1 == indexPath.section)
            f =  50.0f;
        
        return f;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.headInserV.tableView)
    {
        return 0;
    }
    else
    {
        if (0 == section)
            return 40.0f;
        else
            return 25.0f;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView == self.headInserV.tableView)
    {
        return 0.0f;
    }
    else
    {
        return 0.0f;
    }
    
}

#pragma mark ---actionCellButton:

-(void)actionCellButtonS1:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1100:
        {
            L_WeiboPageViewController * myWeiboVC = [[L_WeiboPageViewController alloc]init];
            //TODO: 传值：
            
            [self.navigationController pushViewController:myWeiboVC animated:YES];
            [myWeiboVC release];
            break;
        }
        case 1101:
        {
            L_CollectionViewController * collectionVC = [[L_CollectionViewController alloc]init];
            //TODO: 传值：
            
            [self.navigationController pushViewController:collectionVC animated:YES];
            [collectionVC release];
            break;
        }
        case 1102:
        {
            L_FansViewController * fansVC = [[L_FansViewController alloc]init];
            //TODO: 传值：
            
            [self.navigationController pushViewController:fansVC animated:YES];
            [fansVC release];
            break;
        }
        
        default:
            break;
    }
    
}


#pragma mark -----HeadViewActionButton:
-(void)actionHeadViewButton:(UIButton *)sender
{
    // TODO: 做一个动画 淡入淡出：
    if (self.headInserV.hidden == YES)
    {
        self.headInserV.hidden = NO;
    }
    else
    {
        self.headInserV.hidden = YES;
    }
}

-(void)actionHeadUpdataBtn:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    self.headInserV.hidden = YES;

}

-(void)actionHeadEditBtn:(UIButton *)sender
{
    NSLog(@"%s",__func__);
    self.headInserV.hidden = YES;

}

-(void)actionHomeButton:(UIBarButtonItem *)sender
{
    NSLog(@"%s",__func__);
    //返回到Home页面：
    
}

@end
