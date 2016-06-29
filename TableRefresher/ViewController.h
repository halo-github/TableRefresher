//
//  ViewController.h
//  TableRefresher
//
//  Created by Fenix on 16/6/20.
//  Copyright © 2016年 Fenix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewFresher.h"
@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tab;
@property (nonatomic, strong) ViewFresher *fresher;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

