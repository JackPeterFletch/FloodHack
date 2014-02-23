//
//  FLUDMapsViewController.m
//  FloodHack
//
//  Created by Jack Fletcher on 2/16/14.
//  Copyright (c) 2014 TeamKent. All rights reserved.
//

#import "FLUDMapsViewController.h"
#import <MapKit/MapKit.h>

@interface FLUDMapsViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *CrowdMap;
@property (weak, nonatomic) IBOutlet UIWebView *WebMap;
@property (weak, nonatomic) IBOutlet UISegmentedControl *MapChooser;
@property (strong, nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@end

@implementation FLUDMapsViewController

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
    NSURL *url = [NSURL URLWithString:@"http://eafa.shoothill.com/Home/BBC/86AD0194-A30F-4434-8C5D-FE7C0ED486D7"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_WebMap setScalesPageToFit:YES];
    [_WebMap loadRequest:request];
    _theView.delegate = self;
    
    _CrowdMap.showsUserLocation = true;
    _CrowdMap.userTrackingMode = MKUserTrackingModeFollow;
	// Do any additional setup after loading the view.
    
    //Set event when SegControl hit
    [_MapChooser addTarget:self
                         action:@selector(switchMap:)
               forControlEvents:UIControlEventValueChanged];
    
    [_MapChooser setSelectedSegmentIndex:1];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [_CrowdMap removeOverlays:_CrowdMap.overlays];
    
    NSMutableArray * annotationsToRemove = [ _CrowdMap.annotations mutableCopy ];
    [ annotationsToRemove removeObject:_CrowdMap.userLocation ];
    [ _CrowdMap removeAnnotations:annotationsToRemove ];
}

-(void)viewWillAppear:(BOOL)animated
{
    _CrowdMap.delegate = self;
    
    _CrowdMap.showsUserLocation = true;
    _CrowdMap.userTrackingMode = MKUserTrackingModeFollow;
	// Do any additional setup after loading the view.
    
    NSString *authToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"authKey"];

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.4:3000/alerts.json?auth_token=%@", authToken]];
    
    //Set Json Data
    NSString *dataJson = [NSString stringWithFormat:@"{\"auth_token\": \"%@\"}", authToken];
    NSData* postData= [dataJson dataUsingEncoding:NSUTF8StringEncoding];
    
    //Create URL Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"GET"];
    //[urlRequest setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[urlRequest setHTTPBody:postData];
    
    NSLog(dataJson);
    
    //Perform Request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//Action method executes when user touches the button
-(void) switchMap:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    if([@"SootHill" isEqualToString: [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]]]){
        [_CrowdMap setHidden:YES];
        [_WebMap setHidden:NO];
    } else {
        [_CrowdMap setHidden:NO];
        [_WebMap setHidden:YES];
    }
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
    NSLog(@"response data - %@", [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
    
    NSError *error;
    NSDictionary *jsonResultSet = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSLog(@"Got here");
    
    NSArray *fetchedArr = [jsonResultSet objectForKey:@"alerts"];
    
    for (NSDictionary *alert in fetchedArr){
        NSNumber *latitude = [alert objectForKey:@"lat"];
        NSNumber *longitude = [alert objectForKey:@"lon"];
        NSString *alertType = [alert objectForKey:@"alertType"];
        NSString *desc = [alert objectForKey:@"desc"];
        
        CLLocationDegrees CLlongitude = (CLLocationDegrees)[longitude doubleValue];
        CLLocationDegrees CLlatitude = (CLLocationDegrees)[latitude doubleValue];
        
        CLLocation *coordinate = [[CLLocation alloc] initWithLatitude:CLlatitude longitude:CLlongitude];
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coordinate.coordinate;
        point.title = alertType;
        point.subtitle = desc;
        
        [_CrowdMap addAnnotation:point];
    }
    
    //} else {
    //    NSLog(@"Submit fucking failed");
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert retreival failed" message:@"Do you have network connectivity?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    //    [alert show];
    //}
}


@end
