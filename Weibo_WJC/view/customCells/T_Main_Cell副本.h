//
//  T_Main_Cell.h
//  Weibo_WJC
/*
 自定义cell一个 展示有图有文字 但是没有转发信息
 */
//  Created by TRALIN on 13-3-7.
//  Copyright (c) 2013年 TRALIN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+Html.h"
#import "DownLoad.h"
#import "Microblog.h"

@interface T_Main_Cell : UITableViewCell<UIWebViewDelegate>
{
    UILabel * retweetLab;
    UILabel * commentLab;
}
@property (nonatomic , retain) UIImageView * userIcon;
@property (nonatomic , retain) UILabel * nameLab;
@property (nonatomic , retain) UIWebView * textView;
@property (nonatomic , retain) Microblog * blog;
@property (nonatomic , assign) float height;

@property (nonatomic , retain) UIView * topView;
@property (nonatomic , retain) UIView * bottomView;

-(void)setInfo;

@end
