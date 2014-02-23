//
//  FLUDMapsViewController.h
//  FloodHack
//
//  Created by Jack Fletcher on 2/16/14.
//  Copyright (c) 2014 TeamKent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FLUDMapsViewController : UIViewController <MKMapViewDelegate, NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *theView;

@end
