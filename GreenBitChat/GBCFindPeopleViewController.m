//
//  GBCFindPeople.m
//  GreenBitChat
//
//  Created by L on 11/25/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCFindPeopleViewController.h"

@implementation GBCFindPeopleViewController

# pragma mark - view life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *urlAsString = @"http://localhost/Iphone/getInterestPeople";
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url]; NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response,
                                                                                        NSData *data, NSError *error) {
        if ([data length] >0 && error == nil){
            NSString *html = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"HTML = %@", html); }
        else if ([data length] == 0 && error == nil){
            NSLog(@"Nothing was downloaded."); }
        else if (error != nil){
            NSLog(@"Error happened = %@", error);
        } }];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 42;
}

- (float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 450;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    return cell;
}

- (IBAction)switchTable:(UISegmentedControl *)sender {
}
@end
