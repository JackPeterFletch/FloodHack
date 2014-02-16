//
//  FLUDViewController.m
//  FloodHack
//
//  Created by Jack Fletcher on 2/16/14.
//  Copyright (c) 2014 TeamKent. All rights reserved.
//

#import "FLUDViewController.h"

@interface FLUDViewController ()
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) NSMutableData *responseData;

@end

@implementation FLUDViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)login:(id)sender {
    
    //Set Login URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.100.84.171:3000/api/users/sign_in.json"]];
    
    //Set Json Data
    NSString *dataJson = [NSString stringWithFormat:@"{\"user[email]\": \"%@\",\"user[password]\": \"%@\",\"remember_me\": 0,\"commit\": \"Signin\"}",_usernameField.text, _passwordField.text];
    NSData* postData= [dataJson dataUsingEncoding:NSUTF8StringEncoding];
    
    //Create URL Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    
    NSLog(dataJson);
    
    //Perform Request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
}
- (IBAction)signup:(id)sender {
    //Set Login URL
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.100.84.171:3000/users/%@/%@.json",_usernameField.text, _passwordField.text]];
    
    //Set Json Data
    NSString *dataJson = [NSString stringWithFormat:@"{\"user\":{\"email\": \"%@\",\"password\": \"%@\",\"remember_me\": 0,\"commit\": \"Signin\"}}",_usernameField.text, _passwordField.text];
    NSLog(dataJson);
    //NSError *error;
    //NSData* postData= [NSJSONSerialization  dataWithJSONObject:dataJson options:0 error:&error];
    //Create URL Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"POST"];
    //[urlRequest setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    //[urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[urlRequest setHTTPBody:postData];
        
    //Perform Request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];

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
        
    NSNumber *ID = [jsonResultSet objectForKey:@"id"];
    
    //If authentication key there
    NSNumber *authToken = [jsonResultSet objectForKey:@"authToken"];
    
    //put key in app persistance
    NSString *valueToSave = @"someValue";
    [[NSUserDefaults standardUserDefaults]
     setObject:valueToSave forKey:@"authKey"];
    
    //To Retrieve
    //NSString *savedValue = [[NSUserDefaults standardUserDefaults]
//stringForKey:@"preferenceName"];
    
    //perform segue
    [self performSegueWithIdentifier: @"loggedIn" sender: self];
}

@end