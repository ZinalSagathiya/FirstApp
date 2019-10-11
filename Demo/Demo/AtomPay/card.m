//
//  RnDViewController.m
//  WebView
//
//  Created by ATOM TECHNOLOGIES on 10/15/13.
//  Copyright (c) 2013 ATOM TECHNOLOGIES. All rights reserved.
//

#import "card.h"
#import "Reachability.h"
#import "NSString+DES.h"
#import "NSData+DES.h"

#define MAX_LENGTH_cardname 45
#define MAX_LENGTH_Cardnumber 19
#define MIN_LENGTH_Cardnumber 15
#define MAX_LENGTH_CVV 3
#define ACCEPTABLE_CHARACTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."

@interface card ()
{
    NSXMLParser *parser;
    NSString *element;
    
    NSDictionary *myAttrDict;
    NSString *attributesNames;
    NSString *attributesNamesId;
    NSMutableArray *names;
    
    NSMutableArray *formParam;
    NSMutableArray *formUrl;
    NSString *result;
    IBOutlet UIImageView *atImageView;
    
}
@end

@implementation card
@synthesize activityIndicator,viewWeb,imageView,codeviewWeb,myDelegate,
merchantId,txnscamt,loginid,password,prodid,txncurr,clientcode,custacc,channelid,amt,txnid,date,ru,
cardData,cardNumber,cvv,expYear,expMonth,cardhname,cardtype,cardAssociate,mdd,scrollview,
cardEdhname,cardEdhnumber,cardEdhexpyr,cardEdhexpmn,cardhEdCvv,yearPickerView,monthPickerView ,
yeardataArray,monthdataArray,selectedCategory,pay,labelAmt,navBar,navItem,firstView,middleView,secondView,navText,waitLabel;



- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"viewDidAppear");
    [super viewDidAppear:animated];
    
    
    
    
    
    //   Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //   NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    //    if (networkStatus == NotReachable) {
    //      //  NSLog(@"NO internet connection");
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Not Available"
    //                                                        message:@"Please check the Network connectivity "
    //                                                       delegate:self
    //                                              cancelButtonTitle:@"OK"
    //                                              otherButtonTitles: nil];
    //        [alert show];
    //
    //    } else {
    
    //  [self initialCall];
    
    //}
    
    //  [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blank_background.png"]]];
    
}


- (void)viewDidLoad
{
    // NSLog(@"ViewDidLoad");
    [super viewDidLoad ];
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(doneWithNumberPad)];
    // UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIToolbar *numberToolbar = [[UIToolbar alloc]initWithFrame:
                                CGRectMake(0, 0, 320, 50)];
    
    //    UIToolbar* numberToolbar = [[UIToolbar alloc] init];
    //    [numberToolbar sizeToFit];
    [numberToolbar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [numberToolbar setItems:toolbarItems];
    
    
    
    [numberToolbar sizeToFit];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //float h =self.view.bounds.size.height;
    //float w = self.view.bounds.size.width;
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    scrollview.contentSize =    CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    
    
    // Init the data array.
    yeardataArray = [[NSMutableArray alloc] init];
    monthdataArray = [[NSMutableArray alloc] init];
    
    
    [monthdataArray addObject:@"01"];
    [monthdataArray addObject:@"02"];
    [monthdataArray addObject:@"03"];
    [monthdataArray addObject:@"04"];
    [monthdataArray addObject:@"05"];
    [monthdataArray addObject:@"06"];
    [monthdataArray addObject:@"07"];
    [monthdataArray addObject:@"08"];
    [monthdataArray addObject:@"09"];
    [monthdataArray addObject:@"10"];
    [monthdataArray addObject:@"11"];
    [monthdataArray addObject:@"12"];
    
    
    
    
    for (int i = 2015; i<2051; i++) {
        [yeardataArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    
    
    
    
    //    UITextView *details = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    //    details.font = [UIFont systemFontOfSize:25];
    //    details.textAlignment = NSTextAlignmentCenter;
    //    [details setText:@"Card Details"];
    
    
    
    
    //cardEdhname = [[UITextField alloc] initWithFrame:CGRectMake(10, 150, 300, 40)];
    cardEdhname .borderStyle = UITextBorderStyleRoundedRect;
    cardEdhname .font = [UIFont systemFontOfSize:15];
    cardEdhname .placeholder = @"Name on the Card";
    cardEdhname .autocorrectionType = UITextAutocorrectionTypeNo;
    cardEdhname .keyboardType = UIKeyboardTypeDefault;
    cardEdhname .returnKeyType = UIReturnKeyDone;
    cardEdhname .clearButtonMode = UITextFieldViewModeWhileEditing;
    cardEdhname .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cardEdhname .delegate = self;
    
    // cardEdhnumber = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    cardEdhnumber .borderStyle = UITextBorderStyleRoundedRect;
    cardEdhnumber .font = [UIFont systemFontOfSize:15];
    cardEdhnumber .placeholder = @"Card No.";
    cardEdhnumber .autocorrectionType = UITextAutocorrectionTypeNo;
    cardEdhnumber .keyboardType = UIKeyboardTypeNumberPad;
    cardEdhnumber .returnKeyType = UIReturnKeyDone;
    cardEdhnumber .clearButtonMode = UITextFieldViewModeWhileEditing;
    cardEdhnumber .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cardEdhnumber.inputAccessoryView = numberToolbar;
    cardEdhnumber .delegate = self;
    
    // cardEdhexpmn = [[UITextField alloc] initWithFrame:CGRectMake(10, 250, 300, 40)];
    cardEdhexpmn .borderStyle = UITextBorderStyleRoundedRect;
    cardEdhexpmn .font = [UIFont systemFontOfSize:15];
    cardEdhexpmn .placeholder = @"MM";
    //    cardEdhexpmn .autocorrectionType = UITextAutocorrectionTypeNo;
    //    cardEdhexpmn .keyboardType = UIKeyboardTypeDefault;
    //    cardEdhexpmn .returnKeyType = UIReturnKeyDone;
    cardEdhexpmn .clearButtonMode = UITextFieldViewModeWhileEditing;
    cardEdhexpmn .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cardEdhexpmn.tag = 0;
    cardEdhexpmn .delegate = self;
    
    // cardEdhexpyr = [[UITextField alloc] initWithFrame:CGRectMake(10, 300, 300, 40)];
    cardEdhexpyr .borderStyle = UITextBorderStyleRoundedRect;
    cardEdhexpyr .font = [UIFont systemFontOfSize:15];
    cardEdhexpyr .placeholder = @"YY";
    //cardEdhexpyr .autocorrectionType = UITextAutocorrectionTypeNo;
    //cardEdhexpyr .keyboardType = UIKeyboardTypeDefault;
    //cardEdhexpyr .returnKeyType = UIReturnKeyDone;
    cardEdhexpyr .clearButtonMode = UITextFieldViewModeWhileEditing;
    cardEdhexpyr .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cardEdhexpyr.inputView = [[UIView alloc] initWithFrame:CGRectZero];
    cardEdhexpyr.tag = 1;
    cardEdhexpyr .delegate = self;
    
    //  cardhEdCvv = [[UITextField alloc] initWithFrame:CGRectMake(10, 350, 300, 40)];
    cardhEdCvv .borderStyle = UITextBorderStyleRoundedRect;
    cardhEdCvv .font = [UIFont systemFontOfSize:15];
    cardhEdCvv .placeholder = @"CVV";
    cardhEdCvv .autocorrectionType = UITextAutocorrectionTypeNo;
    cardhEdCvv .keyboardType = UIKeyboardTypeNumberPad;
    cardhEdCvv .returnKeyType = UIReturnKeyDone;
    cardhEdCvv .clearButtonMode = UITextFieldViewModeWhileEditing;
    cardhEdCvv .contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    cardhEdCvv.inputAccessoryView = numberToolbar;
    cardhEdCvv .delegate = self;
    cardhEdCvv.secureTextEntry=YES;
    
    //    UIButton *pay = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    //    pay.frame = CGRectMake(40, 400, 100, 40);
    //    [pay setTitle:@"Pay Now" forState:UIControlStateNormal];
    
    //    [pay addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancel = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    cancel.frame = CGRectMake(180, 400, 100, 40);
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelPressed) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    if(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
    {
        
        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:0.000 green:0.784 blue:0.843 alpha:1.00]];
    }
    else
    {
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.000 green:0.784 blue:0.843 alpha:1.00]];
        
        
    }
    
    
    
    //     UIImage *backArrow = [UIImage imageNamed:@"Back"];
    //    [self.navBar setBackIndicatorImage:backArrow];
    
    
    UIImage *faceImage = [UIImage imageNamed:@"arrow-leftx66.png"];
    UIButton *face = [UIButton buttonWithType:UIButtonTypeCustom];
    face.bounds = CGRectMake( 0, 0, faceImage.size.width, faceImage.size.height );
    [face setImage:faceImage forState:UIControlStateNormal];
    [face addTarget:self action:@selector(cancelNav:) forControlEvents:UIControlEventTouchUpInside];
    
    //UIBarButtonItem *faceBtn = [[UIBarButtonItem alloc] initWithCustomView:face];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"arrow-leftx66.png"] forState:UIControlStateNormal];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(cancelNav:) forControlEvents:UIControlEventTouchDown];
    
    //UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    
    
    
    
    
    /*UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]
     initWithImage:[UIImage imageNamed: @"arrow-leftx66.png"]
     style:UIBarButtonItemStylePlain
     target:self action:@selector(:)];*/
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"arrow-leftx66.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [button addTarget:self action:@selector(cancelNav:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    /*[self.navItem setLeftBarButtonItem:[[UIBarButtonItem alloc]
     initWithImage:[UIImage imageNamed: @"arrow-leftx66.png"]
     style:UIBarButtonItemStylePlain
     target:self
     action:@selector(cancelNav:)] animated:YES];*/
    //self.navItem.hidesBackButton = NO;
    self.navigationItem.leftBarButtonItem = logoutButton;
    [self.navigationItem.leftBarButtonItem setEnabled:YES];
    // [self.navBar setUserInteractionEnabled:YES];
    //[self.navBar ]
    //self.navItem.leftBarButtonItem = logoutButton;
    //[self.view setUserInteractionEnabled:YES];
    // self.navItem.leftBarButtonItem.enabled = YES;
    //self.navItem.leftBarButtonItems = @[backButtonItem,logoutButton];
    
    //    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelNav:)];
    
    
    
    [self.navigationController.navigationItem setTitle:@"Thirstkart"];
    // [navItem setTitle:navText];
    [labelAmt setText:amt];
    [pay setBackgroundColor:[UIColor colorWithRed:0.000 green:0.529 blue:0.667 alpha:1.00]];
    
    
    [firstView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.306 blue:0.443 alpha:1.00]];
    [secondView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.773 blue:0.847 alpha:1.00]];
    [middleView setBackgroundColor:[UIColor colorWithRed:0.000 green:0.529 blue:0.667 alpha:1.00]];
    
    
    
    
    //[scrollview addSubview:details];
    //[scrollview addSubview:cardEdhname ];
    //[scrollview addSubview:cardEdhnumber ];
    //[scrollview addSubview:cardEdhexpmn ];
    //[scrollview addSubview:cardEdhexpyr ];
    //[scrollview addSubview:cardhEdCvv ];
    //[scrollview addSubview:pay];
    // [scrollview addSubview:cancel];
    //[scrollview setScrollEnabled:YES];
    //[scrollview setDelegate:self];
    
    
    // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blank_background.png"]];
    
    // scrollview.backgroundColor = [UIColor blackColor];
    
    // [self.view addSubview:scrollview];
    
}


- (IBAction)cancelNav:(id)sender
{
    result = @"Transaction Failed!";
    // NSLog(@"Transaction Failed!");
    [self.myDelegate secondviewcontrollerDissmissed:result];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



//-(void) setNavBarColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha
//{
//
//}
//-(void) setNavBarText:(NSString *)title
//{
//    navText = title;
//
//
//}
//
//-(void) setFirstViewColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha
//{
//
//}
//-(void) setSecondViewColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha
//{
//}
//
//-(void) setMiddleViewColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha
//{
//}
//
//-(void) setPayButtonColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha
//{
//
//}

- (IBAction)pay:(id)sender;
{
    cardhname = cardEdhname.text;
    cardNumber = cardEdhnumber.text;
    cvv = cardhEdCvv.text;
    expYear = cardEdhexpyr.text;
    expMonth = cardEdhexpmn.text;
    
    if([cardhname length] == 0 || [cardNumber length] == 0 ||  [cvv length] == 0  || [expYear length] == 0  ||  [expMonth length] == 0 )
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Please Enter all fields"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    if(!([cardhname length] == 0) || !([cardNumber length] == 0) ||  !([cvv length] == 0)  || !([expYear length] == 0)  ||  !([expMonth length] == 0) )
    {
        
        
        if ([cardhname length] > MAX_LENGTH_cardname)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Please enter valid Card Name"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
        if ([cardNumber length] > MAX_LENGTH_Cardnumber || [cardNumber length] < MIN_LENGTH_Cardnumber)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Please enter valid Card Number"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
        if ([cvv length] > MAX_LENGTH_CVV || [cvv length] < MAX_LENGTH_CVV)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:@"Please enter valid CVV"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
        else
        {
            activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [activityIndicator startAnimating];
            
            /* float h = self.view.bounds.size.height;
             if(h > 480)
             {
             activityIndicator.frame = CGRectMake(115,217,100,100);
             viewWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, 320, 568)];
             }else
             {
             activityIndicator.frame = CGRectMake(125,208,80,40);
             viewWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
             }
             
             
             */
            
            float h =self.view.bounds.size.height;
            float w = self.view.bounds.size.width;
            if(h > 480)
            {
                activityIndicator.frame = CGRectMake(w/2-50,h/2-100,100,100);
                viewWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
            }else
            {
                activityIndicator.frame = CGRectMake(w/2-50,h/2-100,80,40);
                viewWeb = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
            }
            
            
            viewWeb.scrollView.scrollEnabled = TRUE;
            
            // [self.viewWeb addSubview:activityIndicator];
            UIImage *image = [UIImage imageNamed:@"atom-logo.png"];
            
            imageView = [[UIImageView alloc] initWithImage:image];
            [imageView setFrame:CGRectMake(ceil(CGRectGetWidth(viewWeb.frame) - 140), h-80, 126, 66)];
            
            imageView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
            
            [self.viewWeb addSubview:activityIndicator];
            
            
            //CGFloat labelX = activityIndicator.bounds.size.width + 2;
            
            waitLabel = [[UILabel alloc] initWithFrame:CGRectMake(w/2-100, h/2-100, 200, 50)];
            waitLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            waitLabel.font = [UIFont boldSystemFontOfSize:12.0f];
            waitLabel.numberOfLines = 2;
            
            waitLabel.backgroundColor = [UIColor clearColor];
            waitLabel.textColor = [UIColor blackColor];
            waitLabel.text = @"Please wait, while we processing your request..";
            
            [self.viewWeb addSubview:waitLabel];
            
            [self.viewWeb addSubview:imageView];
            
            //[self.viewWeb addSubview:imageView];
            
            
            
            //  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            // label.text = @"Please wait, while we processing your request..";
            
            // [self.viewWeb addSubview:label];
            [self.view addSubview:viewWeb];
            
            [viewWeb setDelegate:self];
            [self.view endEditing:YES];
            
            
            [self performSelector:@selector(cardinitialCall) withObject:nil afterDelay:0.1];
            
            // [self.view bringSubviewToFront:activityIndicator];
            // [self initialCall];
        }
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:@"Please Enter all fields"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    
    
    
    
    
}





//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if (cardEdhname.text.length >= MAX_LENGTH_cardname && range.length == 0)
//    {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                        message:@"Please enter valid Card Name"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//        [alert show];
//        return NO; // return NO to not change text
//    }else if (cardEdhnumber.text.length >= MAX_LENGTH_Cardnumber && range.length == 0)
//    {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                        message:@"Please enter valid Card Number"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//        [alert show];
//        return NO; // return NO to not change text
//    }
//
//    else if (cardhEdCvv.text.length >= MAX_LENGTH_CVV && range.length == 0)
//    {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                        message:@"Please enter valid CVV"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles: nil];
//        [alert show];
//        return NO; // return NO to not change text
//    }
//
//
//
//    else
//    {return YES;}
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string  {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
    
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    
    return [string isEqualToString:filtered];
}





-(void) cardinitialCall
{
    
    
    
    cardhname = cardEdhname.text;
    cardNumber = cardEdhnumber.text;
    cvv = cardhEdCvv.text;
    expYear = cardEdhexpyr.text;
    expMonth = cardEdhexpmn.text;
    
    
    cardData= @""; //cardNumber,cvv,expYear,expMonth
    cardData = [cardData stringByAppendingString:cardNumber];
    cardData = [cardData stringByAppendingString:@"|"];
    cardData = [cardData stringByAppendingString:cvv];
    cardData = [cardData stringByAppendingString:@"|"];
    cardData = [cardData stringByAppendingString:expYear];
    cardData = [cardData stringByAppendingString:@"|"];
    cardData = [cardData stringByAppendingString:expMonth];
    
    NSLog(@"SecureDataEncryption Text----->%@ %@ %@ %@ %@",cardhname,cardNumber,cvv,expYear,expMonth);
    NSLog(@"SecureDataEncryption Text----->%@",cardData);
    //SecureDataEncryption
    cardData = [cardData DES3EncryptWithKey];
    // NSLog(@"SecureDataEncryption Text----->%@ %@ %@ %@ %@",cardhname,cardNumber,cvv,expYear,expMonth);
    
    //channelid,cardData,cardhname,cardtype,cardAssociate
    mdd = @"";
    
    mdd = [mdd stringByAppendingString:channelid];
    mdd = [mdd stringByAppendingString:@"|carddata="];
    mdd = [mdd stringByAppendingString:cardData];
    mdd = [mdd stringByAppendingString:@"|cardhname="];
    mdd = [mdd stringByAppendingString:cardhname];
    mdd = [mdd stringByAppendingString:@"|cardtype="];
    mdd = [mdd stringByAppendingString:cardtype];
    mdd = [mdd stringByAppendingString:@"|card="];
    mdd = [mdd stringByAppendingString:cardAssociate];
    
    //ru = @"https://payment.atomtech.in/mobilesdk/param";
    ru=@"https://paynetzuat.atomtech.in/paynetz/param";
    
    NSLog(@"MDD----->%@",mdd);
    NSLog(@"MDD111 Test----->%@",mdd);
    
    
    mdd = [mdd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlstring= [NSString stringWithFormat:@"https://paynetzuat.atomtech.in/paynetz/epi/fts?login=%@&pass=%@&ttype=CCFundTransfer&prodid=%@&amt=%@&txncurr=%@&txnscamt=%@&clientcode=%@&txnid=%@&date=%@&custacc=%@&ru=%@&mdd=%@",loginid,password,prodid,amt,txncurr,txnscamt,clientcode,txnid,date,custacc,ru,mdd] ;
    
    /*
     NSString *urlstring= [NSString stringWithFormat:@"https://payment.atomtech.in/paynetz/epi/fts?login=%@&pass=%@&ttype=CCFundTransfer&prodid=%@&amt=%@&txncurr=%@&txnscamt=%@&clientcode=%@&txnid=%@&date=%@&custacc=%@",loginid,password,prodid,amt,txncurr,txnscamt,clientcode,txnid,date,custacc] ;
     
     
     urlstring = [urlstring stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     urlstring = [NSString stringWithFormat:@"%@&mdd=%@",urlstring,mdd];
     urlstring = [NSString stringWithFormat:@"%@&ru=%@",urlstring,ru];
     
     */
    NSLog(@"-----url RECEIVED--->%@",urlstring);
    
    NSError *error;
    NSURL *url = [NSURL URLWithString:urlstring];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    /*NSString *dataString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
     
     NSLog(@"-----DATA RECEIVED--->%@",dataString);
     NSData *data  = [dataString dataUsingEncoding:NSUTF8StringEncoding];
     
     NSLog(@"%@",[error localizedDescription]);*/
    
    /*
     NSString *dataString =[[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error] ;
     NSLog(@"-----DATA RECEIVED--->%@",dataString);
     NSData *data  = [dataString dataUsingEncoding:NSUTF8StringEncoding];
     
     
     NSLog(@"%@",[error localizedDescription]);
     */
    
    parser = [[NSXMLParser alloc] initWithData:responseData];
    
    
    // NSURL *url = [NSURL URLWithString:urlstring];
    
    
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    
    if([elementName isEqualToString:@"param"])
    {
        
        myAttrDict = [[NSDictionary alloc] initWithDictionary:attributeDict];
        [names addObject:[myAttrDict valueForKeyPath:@"name"]];
    }
    
    
    if([elementName isEqualToString:@"RESPONSE"])
    {
        names =[[NSMutableArray alloc]init];
        formUrl = [[NSMutableArray alloc] init];
        formParam = [[NSMutableArray alloc] init];
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    if([element isEqualToString:@"param"])
    {
        //NSLog(@"Adding String-->%@",string);
        [formParam addObject:string];
    }
    if([element isEqualToString:@"url"])
    {
        //NSLog(@"Adding String-->%@",string);
        [formUrl addObject:string];
    }
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser1 {
    
    
    NSString *urlString = [formUrl objectAtIndex:0];
    urlString = [urlString stringByAppendingString:@"?"];
    NSString *type =[@"ttype=" stringByAppendingString:[formParam objectAtIndex:0]];
    NSString *tempTxnId =[@"tempTxnId=" stringByAppendingString:[formParam objectAtIndex:1]];
    NSString *token =[@"token=" stringByAppendingString:[formParam objectAtIndex:2]];
    NSString *txnStage =[@"txnStage=" stringByAppendingString:[formParam objectAtIndex:3]];
    
    NSString *encodedUrl =[urlString stringByAppendingString:type];
    encodedUrl = [encodedUrl stringByAppendingString:@"&"];
    encodedUrl = [encodedUrl stringByAppendingString:tempTxnId];
    encodedUrl = [encodedUrl stringByAppendingString:@"&"];
    encodedUrl = [encodedUrl stringByAppendingString:token];
    encodedUrl = [encodedUrl stringByAppendingString:@"&"];
    encodedUrl = [encodedUrl stringByAppendingString:txnStage];
    // NSLog(@"Encoded Url---->%@",encodedUrl);
    
    //encodedUrl = [encodedUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:encodedUrl];
    
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    viewWeb.scrollView.bounces =NO;
    [viewWeb loadRequest:requestObj];
    
    
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //  NSLog(@"didFailLoadWithError---->%@",error);
    
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    // NSLog(@"start animating");
    //[imageView addSubview:activityIndicator];
    // [self.viewWeb addSubview:imageView];
    
    
    
    
    //UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    //label.text = @"Please wait, while we are processing your request..";
    
    
    // [activityIndicator startAnimating];
    
    
    /*  if([currentURL rangeOfString:@"/paynetz/epi/fts?"].location != NSNotFound){
     [self.viewWeb addSubview:activityIndicator];
     [self.viewWeb addSubview:waitLabel];
     }*/
    NSString *currentURL = viewWeb.request.URL.absoluteString;
    NSLog(@"%@", currentURL);
    [activityIndicator removeFromSuperview];
    [activityIndicator stopAnimating];
    [waitLabel removeFromSuperview];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    // NSLog(@"stop animating");
    //[viewWeb stringByEvaluatingJavaScriptFromString:@"window.alert=null;"];
    [activityIndicator setHidden:YES];
    //[activityIndicator removeFromSuperview];
    //[activityIndicator stopAnimating];
    //[waitLabel removeFromSuperview];
    [waitLabel setHidden:YES];
    // [viewWeb stringByEvaluatingJavaScriptFromString:@"window.alert=null;"];
    
    NSString *currentURL = viewWeb.request.URL.absoluteString;
    NSLog(@"%@", currentURL);
    
    if([currentURL rangeOfString:@"atomtech.in"].location != NSNotFound)
    {
        atImageView.hidden = true;
        
    } else {
        atImageView.hidden = false;
    }
    
    if([currentURL rangeOfString:@"param"].location != NSNotFound)
        
    {
        NSString *htmlSource = [self.viewWeb stringByEvaluatingJavaScriptFromString:@"document.documentElement.outerHTML"];
        NSLog(@"html---->%@",@"Testest");
        NSLog(@"html---->%@",htmlSource);
        
        
        if([htmlSource rangeOfString:@"success_00" options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            
            
            //NSString *r = [self convertHTMLTableString:htmlSource];
            //result = @"Transaction Successfull!";
            result=[self convertHTMLTableString:htmlSource];
            // NSLog(@"Transaction Successfull!");
            //result = htmlSource;
        }
        else
        {
            //result = @"Transaction Failed!";
            result = [self convertHTMLTableString:htmlSource];
            // NSLog(@"Transaction Failed!");
            //result=htmlSource;
        }
        
        
        //  if([self.myDelegate respondsToSelector:@selector(secondviewcontrollerDissmissed:)])
        //  {
        
        
        [self.myDelegate secondviewcontrollerDissmissed:result];
        
        
        
        //  }
        
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:5.0];
        
        
    }
    
}


//<a class="yourbutton" href="inapp://close">Close</a>

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //  NSLog(@"In Button Close--->");
    if ([request.URL.scheme isEqualToString:@"inapp"]) {
        
        if([request.URL.host isEqualToString:@"close"])
        {
            
            [self.myDelegate secondviewcontrollerDissmissed:result];
            [self dismiss];
        }
    }
    return YES;
}




-(void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)cancelPressed
{
    result = @"Transaction Failed!";
    // NSLog(@"Transaction Failed!");
    [self.myDelegate secondviewcontrollerDissmissed:result];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == alert.cancelButtonIndex) {
        [self viewDidAppear:YES];
    }
}



#pragma mark -
#pragma mark UITextFieldDelegate



-(void)doneWithNumberPad{
    [cardEdhnumber resignFirstResponder];
    [cardhEdCvv resignFirstResponder];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // the user pressed the "Done" button, so dismiss the keyboard
    
    
    
    [cardEdhname resignFirstResponder];
    [cardEdhnumber resignFirstResponder];
    [cardEdhexpyr resignFirstResponder];
    [cardEdhexpmn resignFirstResponder];
    [cardhEdCvv resignFirstResponder];
    
    
    
    return YES;
}



-(void)resignKeyboard
{
    
    
}


-(void)keyboardDidHide:(NSNotification *)notif
{
    
}


//- (void)textFieldDidBeginEditing:(UITextField *)textField
//
//{
//
//
//}

//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//
//
//    scrollview.frame = CGRectMake(0, self.view.frame.origin.y, 320, 480 + 60);
//
//
//}
//
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.tag == 0)
    {
        
        [self addPickerViewMn];
    }
    else if(textField.tag == 1)
    {
        [self addPickerViewYr];
    }
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // scrollview.frame = CGRectMake(0, self.view.frame.origin.y, 320, 480 );
    [self animateTextField: textField up: YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // scrollview.frame = CGRectMake(0, self.view.frame.origin.y, 320, 480 );
    [self animateTextField: textField up: NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    const int movementDistance = 140; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}


#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerViewObj
numberOfRowsInComponent:(NSInteger)component{
    
    if([pickerViewObj isEqual:  yearPickerView])
    {
        return [yeardataArray count];
    }
    else  if([pickerViewObj isEqual: monthPickerView])
    {
        return [monthdataArray count];
    }
    return 0;
}

#pragma mark- Picker View Delegate

-(void)pickerView:(UIPickerView *)pickerViewObj didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    selectedCategory = @"";
    if([pickerViewObj isEqual:  yearPickerView])
    {
        
        selectedCategory = [NSString stringWithFormat:@"%@",[yeardataArray objectAtIndex:row]];
        cardEdhexpyr.text = [yeardataArray objectAtIndex:row];
    }
    else  if([pickerViewObj isEqual: monthPickerView])
    {
        
        selectedCategory = [NSString stringWithFormat:@"%@",[monthdataArray objectAtIndex:row]];
        cardEdhexpmn.text= [monthdataArray objectAtIndex:row];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerViewObj titleForRow:
(NSInteger)row forComponent:(NSInteger)component{
    if([pickerViewObj isEqual:  yearPickerView])
    {
        
        
        return [yeardataArray objectAtIndex:row];
    }
    else  if([pickerViewObj isEqual: monthPickerView])
    {
        
        return [monthdataArray objectAtIndex:row];
    }
    return @"";
}

-(void)done{
    cardEdhexpyr.text = selectedCategory;
    [cardEdhexpyr resignFirstResponder];
    
}
-(void)donemn{
    cardEdhexpmn.text = selectedCategory;
    [cardEdhexpmn resignFirstResponder];
    
}



-(void)addPickerViewYr  {
    
    yearPickerView = [[UIPickerView alloc]init];
    yearPickerView.dataSource = self;
    yearPickerView.delegate = self;
    yearPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     yearPickerView.frame.size.height-50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    cardEdhexpyr.inputView = yearPickerView;
    cardEdhexpyr.inputAccessoryView = toolBar;
    
}
-(void)addPickerViewMn  {
    
    monthPickerView = [[UIPickerView alloc]init];
    monthPickerView.dataSource = self;
    monthPickerView.delegate = self;
    monthPickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(donemn)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     monthPickerView.frame.size.height-50, 320, 50)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [toolBar setItems:toolbarItems];
    cardEdhexpmn.inputView = monthPickerView;
    cardEdhexpmn.inputAccessoryView = toolBar;
    
}



-(NSString *)convertHTMLTableString:(NSString *)htmlString{
    
    //    NSString *formattedStr;
    htmlString=[self removeHeaderTag:htmlString];
    htmlString=[self validateTableRow:htmlString];
    htmlString=[self validateTableData:htmlString];
    htmlString=[self removeHeaderEnd:htmlString];
    
    
    htmlString=[[[[[[[[[htmlString stringByReplacingOccurrencesOfString:@"<tr>" withString:@"|"]stringByReplacingOccurrencesOfString:@"</tr>" withString:@""]stringByReplacingOccurrencesOfString:@"</td><td>" withString:@"="]stringByReplacingOccurrencesOfString:@"<td></td>" withString:@"="]stringByReplacingOccurrencesOfString:@"<td>" withString:@""]stringByReplacingOccurrencesOfString:@"</td>" withString:@""]stringByReplacingOccurrencesOfString:@"<ul>" withString:@""]stringByReplacingOccurrencesOfString:@"</ul>" withString:@""]stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSLog(@" formatted HTML String ==> %@",htmlString);
    
    return htmlString;
}

-(NSString *)removeHeaderTag:(NSString *)htmlString{
    
    NSString *endOfHeader=@"<tr";
    NSString *headerStr;
    
    NSRange endRange=[htmlString rangeOfString:endOfHeader];
    if(endRange.location!=NSNotFound){
        NSRange targetRange;
        targetRange.location=0;
        targetRange.length=targetRange.location+endRange.location;
        //        NSLog(@"target length= %lu",(unsigned long)targetRange.length);
        headerStr=[htmlString substringWithRange:targetRange];
        //        NSLog(@"Header string %@",headerStr);
        htmlString=[htmlString stringByReplacingOccurrencesOfString:headerStr withString:@""];
    }
    
    htmlString = [htmlString componentsSeparatedByString:@"</th></tr>"][1];
    
    
    return htmlString;
}

-(NSString *)removeHeaderEnd:(NSString *)htmlString{
    
    NSString *startHeaderEnd=@"</tr></";
    NSString *headerStr;
    
    NSRange endRange=NSMakeRange(0,[htmlString length]);
    if(endRange.location!=NSNotFound){
        NSRange targetRange;
        targetRange.location=[htmlString rangeOfString:startHeaderEnd].location;
        targetRange.length=[htmlString length]-targetRange.location;
        //         NSLog(@"target length= %lu",(unsigned long)targetRange.length);
        headerStr=[htmlString substringWithRange:targetRange];
        //        NSLog(@"Header string %@",headerStr);
        htmlString=[htmlString stringByReplacingOccurrencesOfString:headerStr withString:@""];
    }
    htmlString=[htmlString stringByAppendingString:@"</tr>"];
    return htmlString;
    
}

-(NSString *)validateTableRow:(NSString *)htmlString{
    
    NSString *startRowTag=@"<tr";
    NSString *endRowTag=@">";
    NSString *substringRow;
    
    NSRange startRange=[htmlString rangeOfString:startRowTag];
    
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [htmlString length] - targetRange.location;
        NSRange endRange = [htmlString rangeOfString:endRowTag options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            //            NSLog(@"%@", [htmlString substringWithRange:targetRange]);
            substringRow=[htmlString substringWithRange:targetRange];
            htmlString=[htmlString stringByReplacingOccurrencesOfString:substringRow withString:@""];
        }
    }
    return htmlString;
}

-(NSString *)validateTableData:(NSString *)htmlString{
    
    NSString *startDataTag=@"<td";
    NSString *endDataTag=@">";
    NSString *substringData;
    
    NSRange startRange=[htmlString rangeOfString:startDataTag];
    
    if (startRange.location != NSNotFound) {
        NSRange targetRange;
        targetRange.location = startRange.location + startRange.length;
        targetRange.length = [htmlString length] - targetRange.location;
        NSRange endRange = [htmlString rangeOfString:endDataTag options:0 range:targetRange];
        if (endRange.location != NSNotFound) {
            targetRange.length = endRange.location - targetRange.location;
            //            NSLog(@"%@", [htmlString substringWithRange:targetRange]);
            substringData=[htmlString substringWithRange:targetRange];
            htmlString=[htmlString stringByReplacingOccurrencesOfString:substringData withString:@""];
        }
    }
    return htmlString;
}


@end





