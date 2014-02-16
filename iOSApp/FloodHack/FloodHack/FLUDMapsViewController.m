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
    //_CrowdMap.delegate = self;
    
    _CrowdMap.showsUserLocation = true;
    _CrowdMap.userTrackingMode = MKUserTrackingModeFollow;
	// Do any additional setup after loading the view.
    
    //Set event when SegControl hit
    [_MapChooser addTarget:self
                         action:@selector(switchMap:)
               forControlEvents:UIControlEventValueChanged];
    
    [_MapChooser setSelectedSegmentIndex:1];
    
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

@end
