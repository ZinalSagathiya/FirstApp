//
//  lib.h
//  WebView
//
//  Created by ATOM TECHNOLOGIES on 10/15/13.
//  Copyright (c) 2013 ATOM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

#define statusTag 0
@protocol nbDelegate <NSObject>
-(void) secondviewcontrollerDissmissed:(NSString *)stringForFirst;

@end



@interface nb : UIViewController <UIWebViewDelegate,UIAlertViewDelegate>
{
    UIWebView *codeviewWeb;
    UIWebView *viewWeb;
    UIImageView *imageView;
    
    NSString *merchantId;
    NSString *txnscamt;
    NSString *loginid;
    NSString *password;
    NSString *prodid;
    NSString *txncurr;
    NSString *clientcode;
    NSString *custacc;
    
    NSString *amt;
    NSString *txnid;
    NSString *date;
    NSString *bankid;
    NSString *ru;
    NSString *reqHashKey;
    NSString *resHashKey;
}



@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
@property (strong, nonatomic) IBOutlet UIWebView *codeviewWeb;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UILabel *waitLabel;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,retain)  UIImageView *imageView;
@property (nonatomic,assign) id <nbDelegate> myDelegate;


@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *txnscamt;
@property (strong, nonatomic) NSString *loginid;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *prodid;
@property (strong, nonatomic) NSString *txncurr;
@property (strong, nonatomic) NSString *clientcode;
@property (strong, nonatomic) NSString *custacc;
@property (strong, nonatomic) NSString *amt;
@property (strong, nonatomic) NSString *txnid;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *bankid;
@property (strong, nonatomic) NSString *ru;

@property (strong, nonatomic) NSString *reqHashKey;
@property (strong, nonatomic) NSString *resHashKey;

-(void)initialCall;
-(void)dismiss;
-(IBAction)cancelNav:(id)sender;
@end
