//
//  FLUDAlertsViewController.m
//  FloodHack
//
//  Created by Jack Fletcher on 2/23/14.
//  Copyright (c) 2014 TeamKent. All rights reserved.
//

#import "FLUDAlertsViewController.h"

@interface FLUDAlertsViewController ()
@property (strong, nonatomic) NSMutableData *responseData;


@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UISwitch *floodedBanksSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *powerDownSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *floodedRoadSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *strandedSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *otherSwitch;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *settingSaved;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet UILabel *distanceReadout;


@end

@implementation FLUDAlertsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_activityIndicator stopAnimating];
    _activityIndicator.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonAction:(id)sender {
    
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.4:3000/users/edit.json"]];
    //NSString *authToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"authKey"];
    
    //phoneField;
    //floodedBanksSwitch;
    //powerDownSwitch;
    //floodedRoadSwitch;
    //strandedSwitch;
    //otherSwitch;
    
    
    
    
    
    //Set Json Data
    //NSString *dataJson = [NSString stringWithFormat:@"{\"alert\":{\"alertType\": \"%@\",\"desc\": \"%@\",\"lat\": \"%@\",\"lon\": \"%@\"},\"commit\": \"Create Alert\",\"auth_token\": \"%@\"}",_incidentText, _decriptionField.text, latitude, longitude, authToken];
    //NSData* postData= [dataJson dataUsingEncoding:NSUTF8StringEncoding];
    
    //Create URL Request
    //NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    //[urlRequest setHTTPMethod:@"POST"];
    //[urlRequest setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[urlRequest setHTTPBody:postData];
    
    //NSLog(dataJson);
    
    //[_activityIndicator startAnimating];
    //_activityIndicator.hidden = NO;
    
    ////Perform Request
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}
- (IBAction)sliderValueChanged:(id)sender {
    _distanceReadout.text = [NSString stringWithFormat:@"%f miles", _distanceSlider.value];
}

//Delegate methods for NSURLConnection
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_activityIndicator startAnimating];
    _activityIndicator.hidden = NO;
    
    NSLog(@"response data - %@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
    
    NSError *error;
    NSDictionary *jsonResultSet = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    
    if ([[jsonResultSet objectForKey:@"success"] boolValue]){
        
        NSLog(@"Submit Fucking succeeded");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thanks" message:@"Thanks for your report, we will alert those nearby!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    } else {
        NSLog(@"Submit fucking failed");
    }
}


@end
