//
//  GBCContactsViewController.m
//  GreenBitChat
//
//  Created by L on 10/16/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCContactsViewController.h"

#define kItemKeyTitle       @"title"
#define kItemKeyDescription @"description"
#define kItemKeyClassPrefix @"prefix"


@interface GBCContactsViewController ()
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSArray *indexOfNumbers;
@end


@implementation GBCContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *numbers = @"100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500";
    self.tableData = [numbers componentsSeparatedByString:@" "];
    
    numbers = @"1 2 3 4 5 6 7 8 9 10 11 12 13 14 15";
    self.indexOfNumbers = [numbers componentsSeparatedByString:@" "];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.indexOfNumbers count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.tableData objectAtIndex:indexPath.section];
    
    return cell;
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexOfNumbers;
}

- (NSInteger)tableView:(UITableView *)tableView
sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.indexOfNumbers indexOfObject:title];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end



