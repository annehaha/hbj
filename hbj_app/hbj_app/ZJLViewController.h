//
//  ZJLViewController.h
//  zhanKaiTableView
//
//  Created by 张欣琳 on 14-2-11.
//  Copyright (c) 2014年 张欣琳. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ZJLViewController : UIViewController<MFMessageComposeViewControllerDelegate>
{
    NSMutableDictionary *idToName;
    NSMutableDictionary *attentionMsg;
    NSMutableDictionary *tel;
}

@end
