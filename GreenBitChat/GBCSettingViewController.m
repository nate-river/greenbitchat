//
//  GBCSettingViewController.m
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCSettingViewController.h"

enum {
	InformationSectionIndex,
} ProfileSectionIndicies;

enum {
	BioRowIndex,
	LocationRowIndex,
	WebsiteRowIndex,
} InformationSectionRowIndicies;

@interface GBCSettingViewController ()

@end

@implementation GBCSettingViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case BioRowIndex:
            return 77.0f;
        default:
            return tableView.rowHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = nil;
	
	switch (indexPath.row) {
		case BioRowIndex:
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
										   reuseIdentifier:nil];
			cell.textLabel.text = NSLocalizedString(@"Hacker from the Rustbelt, living in Austin, TX. iOS Developer at @gowalla, and co-founder of @austinrb", nil);
			cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.numberOfLines = 0;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			break;
		case LocationRowIndex:
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
										   reuseIdentifier:nil];
			cell.textLabel.text = NSLocalizedString(@"location", nil);
			cell.detailTextLabel.text = NSLocalizedString(@"Austin, TX", nil);
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
		case WebsiteRowIndex:
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
										   reuseIdentifier:nil];
			cell.textLabel.text = @"web";
			cell.detailTextLabel.text = @"http://mattt.me";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			break;
	}
	
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
