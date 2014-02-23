//
//  FLUDReportViewController.m
//  FloodHack
//
//  Created by Jack Fletcher on 2/23/14.
//  Copyright (c) 2014 TeamKent. All rights reserved.
//

#import "FLUDReportViewController.h"

@interface FLUDReportViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *Scrolly;
@property (weak, nonatomic) IBOutlet UIPickerView *incidentPicker;
@property (weak, nonatomic) IBOutlet UITextField *decriptionField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (strong, nonatomic) NSString *incidentText;
@property (strong, nonatomic) NSArray *pickerElements;
@property (strong, nonatomic) NSMutableData *responseData;


@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@end

@implementation FLUDReportViewController

@synthesize locationManager, currentLocation;

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
    _incidentPicker.delegate = self;
    _incidentPicker.dataSource = self;
    _incidentPicker.showsSelectionIndicator = YES;
	// Do any additional setup after loading the view.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    self.pickerElements = @[@"Burst River Bank", @"Power Down", @"Flooded Road", @"Trapped Person", @"Other"];
    self.incidentText = [self.pickerElements objectAtIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitAction:(id)sender {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.4:3000/alerts.json"]];
    NSString *authToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"authKey"];
    
    NSMutableString *longitude = [[NSMutableString alloc] initWithFormat:@"%f", currentLocation.coordinate.longitude];
    [longitude setString: [longitude stringByReplacingOccurrencesOfString:@"." withString:@"P"]];
    
    NSMutableString *latitude =[[NSMutableString alloc] initWithFormat:@"%f", currentLocation.coordinate.latitude];
    [latitude setString: [latitude stringByReplacingOccurrencesOfString:@"." withString:@"P"]];
    
    //Set Json Data
    NSString *dataJson = [NSString stringWithFormat:@"{\"alert\":{\"alertType\": \"%@\",\"desc\": \"%@\",\"lat\": \"%@\",\"lon\": \"%@\"},\"commit\": \"Create Alert\",\"auth_token\": \"%@\"}",_incidentText, _decriptionField.text, longitude, latitude, authToken];
    NSData* postData= [dataJson dataUsingEncoding:NSUTF8StringEncoding];
    
    //Create URL Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    
    NSLog(dataJson);
    
    [_loadingSpinner startAnimating];
    
    //Perform Request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    
}

//GPS delegate methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.currentLocation = newLocation;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
}

//UI Picker delegate methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerElements count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerElements objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.incidentText = [self.pickerElements objectAtIndex:row];
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
    [_loadingSpinner stopAnimating];
    
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
