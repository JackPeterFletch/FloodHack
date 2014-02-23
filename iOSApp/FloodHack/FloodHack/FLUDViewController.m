//
//  FLUDViewController.m
//  FloodHack
//
//  Created by Jack Fletcher on 2/16/14.
//  Copyright (c) 2014 TeamKent. All rights reserved.
//

#import "FLUDViewController.h"
#import "DataClass.h"

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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.4:3000/users/sign_in.json"]];
    
    //Set Json Data
    NSString *dataJson = [NSString stringWithFormat:@"{\"user\":{\"email\": \"%@\",\"password\": \"%@\",\"remember_me\": 0},\"commit\": \"Log In\"}",_usernameField.text, _passwordField.text];

    NSData* postData= [dataJson dataUsingEncoding:NSUTF8StringEncoding];
    
    //Create URL Request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", postData.length] forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setHTTPBody:postData];
    
    NSLog(dataJson);
    
    //Perform Request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    
}
- (IBAction)signup:(id)sender {
    
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
    
    if ([[jsonResultSet objectForKey:@"success"] boolValue]){
        
        //If authentication key there
        NSNumber *authToken = [[jsonResultSet objectForKey:@"data"] objectForKey:@"auth_token"];

        //Store auth key in user defaults
        [[NSUserDefaults standardUserDefaults]
         setObject:authToken forKey:@"authKey"];
        
        //To Retrieve
        NSString *savedValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"authKey"];
        NSLog(savedValue);
        
        //perform segue
        [self performSegueWithIdentifier: @"loggedIn" sender: self];
        
    } else {
        _usernameField.text = @"Login";
        _passwordField.text = @"Error";
    }
}

@end