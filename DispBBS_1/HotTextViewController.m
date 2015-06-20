//
//  HotTextViewController.m
//  DispBBS_1
//
//  Created by ChangHsaio ni on 2015/6/20.
//  Copyright (c) 2015年 ChangHsaio ni. All rights reserved.
//

#import "HotTextViewController.h"
#import "HotTextCell.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "TextViewController.h"
@interface HotTextViewController()


@end

@implementation HotTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadHotTexts];
}

-(void)loadHotTexts
{
    self.hotTexts =[NSMutableArray arrayWithCapacity:20];
    NSString *urlString=@"http://disp.cc/api/hot_text.json";
    NSURL *url=[NSURL URLWithString:urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation=[[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer=[AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSDictionary *data = (NSDictionary *)responseObject;
        NSLog(@"err:%@",data[@"err"]);
        self.hotTexts=data[@"list"];
        [self.tableView reloadData];
    }
    failure:^(AFHTTPRequestOperation *operation,NSError *error)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Error Retrieving HotTexts" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                  
    [alertView show];
    }];
    
    [operation start];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.hotTexts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HotTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotTextCell"];
    NSDictionary *hotText=self.hotTexts[indexPath.row];
    cell.titleLabel.text=hotText[@"title"];
    cell.descLabel.text=hotText[@"desc"];
    NSArray *img_list=hotText[@"img_list"];
    if ([img_list count]) {
        UIImage *placeholderImage=[UIImage imageNamed:@"displogo120.png"];
        NSString *imgUrlString= img_list[0];
        NSURL *url=[NSURL URLWithString:imgUrlString];
        NSURLRequest *request =[NSURLRequest requestWithURL:url];
        __weak HotTextCell *weakCell=cell;
        [cell.thumbImageView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            weakCell.thumbImageView.image=image;
            [weakCell setNeedsLayout];
        
        }failure:nil
         ];
    } else {
        cell.thumbImageView.image=[UIImage imageNamed:@"displogo120.png"];
    
    }
   

    return cell;
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSDictionary *hotText=self.hotTexts[self.tableView.indexPathForSelectedRow.row];
    NSString *urlString = [NSString stringWithFormat:@"http://disp.cc/m/%@-%@",hotText[@"bi"],hotText[@"ti"]];
    TextViewController *textViewController=segue.destinationViewController;
    textViewController.urlString=urlString;
}



@end

