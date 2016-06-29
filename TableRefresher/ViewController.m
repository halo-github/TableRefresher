//
//  ViewController.m
//  TableRefresher
//
//  Created by Fenix on 16/6/20.
//  Copyright © 2016年 Fenix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataArr = [[NSMutableArray alloc] init];
   
    for (int i = 0; i<10; i++) {
        [_dataArr addObject:[NSNumber numberWithInt:arc4random()]];
    }
    _tab = [[UITableView alloc] initWithFrame:CGRectMake(30, 20, 200, 300) style:UITableViewStylePlain];
    _tab.backgroundColor = [UIColor cyanColor];
    _tab.rowHeight = 100;
    _tab.delegate = self;
    _tab.dataSource = self;
    [self.view addSubview:_tab];
//    NSLog(@"scrollView contentSize.height = %f",_tab.contentSize.height);
    _fresher = [[ViewFresher alloc] init];
    UIView *a = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    a.backgroundColor = [UIColor greenColor];
    
    UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    b.backgroundColor = [UIColor lightGrayColor];
    [_fresher initTopView:nil onScrollView:_tab usingRefreshBlock:^(UIScrollView *scrl) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _dataArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<10; i++) {
                [_dataArr addObject:[NSNumber numberWithInt:arc4random()]];
            }
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tab  reloadData];
            });
        });
        NSLog(@"top refresher working");
    }];
    [_fresher initBottomViewWith:nil onScrollView:_tab usingRefreshBlock:^(UIScrollView *scrl) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            _dataArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<10; i++) {
                [_dataArr addObject:[NSNumber numberWithInt:arc4random()]];
            }
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tab  reloadData];
//                _tab reloadSections:<#(nonnull NSIndexSet *)#> withRowAnimation:<#(UITableViewRowAnimation)#>
//                _tab reloadRowsAtIndexPaths:<#(nonnull NSArray<NSIndexPath *> *)#> withRowAnimation:<#(UITableViewRowAnimation)#>
                
            });
        });
        NSLog(@"bottom refresher working");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArr&&_dataArr.count) {
        return _dataArr.count;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.contentView.backgroundColor = [UIColor redColor];
    cell.textLabel.text = [NSString stringWithFormat:@"Number:%@",[_dataArr objectAtIndex:indexPath.row]];
    return cell;
}


@end
