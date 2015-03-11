//
//  ViewController.m
//  GCMacysTechInterview
//
//  Created by Gustavo Couto on 2015-03-11.
//  Copyright (c) 2015 makr.space. All rights reserved.
//

#import "RootViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "LFSEntity.h"

@interface RootViewController ()

@property (weak, nonatomic) NSString * const BaseURLString;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * lfsArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.BaseURLString = @"http://www.nactem.ac.uk/software/acromine/dictionary.py";

}

- (IBAction)onSearchButtonPressed:(id)sender {
    //clear up current data
    self.lfsArray = [NSMutableArray new];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //build the url for the rest call based on user input
    NSString *string = [NSString stringWithFormat:@"%@?sf=%@", self.BaseURLString, self.inputTextField.text];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //instantiate an AFHTTPRequestOperation object to request our json
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //gets called if the call to rest api was successful

        NSArray * response = (NSArray *)responseObject;
        NSDictionary * responseDictionary = response.firstObject;
        NSArray * lfsArray = responseDictionary[@"lfs"];
        for (NSDictionary * lfs in lfsArray) {
            LFSEntity * lfsEntity = [[LFSEntity alloc] initWithDictionary:lfs];
            [self.lfsArray addObject:lfsEntity];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.tableView reloadData];
        });


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {



        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Acronym!"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];


    [operation start];
}




#pragma mark - TableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lfsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    LFSEntity * lfs = [LFSEntity new];
    lfs = self.lfsArray[indexPath.row];
    cell.textLabel.text = lfs.lf;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Frequency: %@ , since: %@",lfs.freq, lfs.since];

    return cell;
}

@end
