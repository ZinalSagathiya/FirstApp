//
//  card.h
//  WebView
//
//  Created by ATOM TECHNOLOGIES on 10/15/13.
//  Copyright (c) 2013 ATOM TECHNOLOGIES. All rights reserved.
//

#import <UIKit/UIKit.h>

#define statusTag 0
@protocol cardDelegate <NSObject>
-(void) secondviewcontrollerDissmissed:(NSString *)stringForFirst;

@end



@interface card : UIViewController <UITextFieldDelegate, UIWebViewDelegate,UIAlertViewDelegate,NSXMLParserDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
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
    NSString  *channelid;
    
    NSString *amt;
    NSString *txnid;
    NSString *date;
    
    NSString *cardData;
    NSString *cardNumber;
    NSString *cvv;
    NSString *expYear;
    NSString *expMonth;
    
    NSString *cardhname;
    NSString *cardtype;
    NSString *cardAssociate;
    
    NSString *mdd;
    NSString *ru;
    
    
    UIPickerView *yearPickerView;
    UIPickerView *monthPickerView;
    
    UIPickerView *pickerView;
    
    NSMutableArray *yeardataArray;
    NSMutableArray *monthdataArray;
    NSString *selectedCategory;
    
    NSString *navText;
}



@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
@property (strong, nonatomic) IBOutlet UIWebView *codeviewWeb;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic,retain)  UIImageView *imageView;
@property (nonatomic,assign) id <cardDelegate> myDelegate;
@property (strong, nonatomic) IBOutlet UILabel *waitLabel;



@property (strong, nonatomic) NSString *merchantId;
@property (strong, nonatomic) NSString *txnscamt;
@property (strong, nonatomic) NSString *loginid;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *prodid;
@property (strong, nonatomic) NSString *txncurr;
@property (strong, nonatomic) NSString *clientcode;
@property (strong, nonatomic) NSString *custacc;
@property (strong, nonatomic) NSString *channelid;

@property (strong, nonatomic) NSString *amt;
@property (strong, nonatomic) NSString *txnid;
@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) NSString *cardData;
@property (strong, nonatomic) NSString *cardNumber;
@property (strong, nonatomic) NSString *cvv;
@property (strong, nonatomic) NSString *expYear;
@property (strong, nonatomic) NSString *expMonth;

@property (strong, nonatomic) NSString *cardhname;
@property (strong, nonatomic) NSString *cardtype;
@property (strong, nonatomic) NSString *cardAssociate;

@property (strong, nonatomic) NSString *mdd;
@property (strong, nonatomic) NSString *ru;


@property (strong, nonatomic) NSString *navText;

- (IBAction)pay:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollview;

@property (strong, nonatomic) IBOutlet UITextField *cardEdhname;
@property (strong, nonatomic) IBOutlet UITextField *cardEdhnumber;
@property (strong, nonatomic) IBOutlet UITextField *cardEdhexpyr;
@property (strong, nonatomic) IBOutlet UITextField *cardEdhexpmn;
@property (strong, nonatomic) IBOutlet UITextField *cardhEdCvv;
@property (strong, nonatomic) IBOutlet UIButton *pay;


@property (nonatomic, retain) UIPickerView *yearPickerView;
@property (nonatomic, retain) UIPickerView *monthPickerView;
@property (nonatomic, retain) NSMutableArray *yeardataArray;
@property (nonatomic, retain) NSMutableArray *monthdataArray;
@property (strong, nonatomic) NSString *selectedCategory;

@property (strong, nonatomic) IBOutlet UINavigationItem *navItem;

@property (strong, nonatomic) IBOutlet UILabel *labelAmt;
@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIView *secondView;

@property (strong, nonatomic) IBOutlet UIView *middleView;



//-(void) setNavBarColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha;
//-(void) setNavBarText:(NSString *)title;
//
//-(void) setFirstViewColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha;
//-(void) setSecondViewColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha;
//-(void) setMiddleViewColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha;
//
//-(void) setPayButtonColor:(CGFloat)red :(CGFloat)green : (CGFloat)blue : (CGFloat) alpha;

- (IBAction)cancelNav:(id)sender;
-(void)dismiss;

-(void)cardinitialCall;

//-(void)loadInitialView;




@end
