//
//  UGameManager.m
//  UGameManager
//
//  Created by Developer on 2/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "UGameManager.h"
#import <UIKit/UIKit.h>


@implementation UGameManager

@synthesize delegate;
@synthesize isProcessPayments;

static UGameManager* gameMgr=nil;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc
{
//    [super dealloc];
}

+ (UGameManager*) instance
{
	if (gameMgr==nil)
	{
		gameMgr=[[UGameManager alloc]init];
	}
	
	return gameMgr;
}


// *****************************
// IAP Function
// *****************************
-(void) iniStoreKit
{
	
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

-(BOOL) canProcessPayments
{
	if ([SKPaymentQueue canMakePayments])
	{
		return YES;
	}
	else
	{
		return NO;
	}
}

/*
 - (void) requestProductData
 {
 SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers: [NSSet setWithObject: @"com.Activ8.Shells"]];
 request.delegate = self;
 [request start];
 }
 
 - (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
 {
 // NSArray *myProduct = response.products;
 // populate UI
 [request autorelease];
 }
 */

-(void)purchaseItem:(NSString*) identifier
{
	isProcessPayments=YES;
	SKPayment *payment = [SKPayment paymentWithProductIdentifier:identifier];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
}


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        if (self.block) {
            self.block();
        }
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
            default:
                break;
        }
    }
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{
	isProcessPayments=NO;
	// Your application should implement these two methods.
    [self recordTransaction: transaction];
    [self provideContent: transaction.payment.productIdentifier];
	// Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
	
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{
	isProcessPayments=NO;
	
    [self recordTransaction: transaction];
    [self provideContent: transaction.originalTransaction.payment.productIdentifier];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
	
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	isProcessPayments=NO;
    
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
		// Optionally, display an error here.
//        UnitySendMessage("UGameObject","IOSIAPCallback",[transaction.error.localizedDescription UTF8String]);
        
	}
	else{
		//UnitySendMessage("UGameObject","IOSIAPCallback",[transaction.error.localizedDescription UTF8String]);	
	}
	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
	
}

//向后台传凭证
-(void )recordTransaction:  (SKPaymentTransaction *)transaction
{
    
    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    NSString *receiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    
    NSString* rec=[[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    NSDictionary *params = @{
                             @"receipt": receiptString
                             };
    //    UnitySendMessage("UGameObject","IOSIAPCallback",[identifier UTF8String]);
    [HttpTool put:[NSString stringWithFormat:@"pay/setIapCertificate"] params:params success:^(id responseObj) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"成功" message:@"已经成功购买" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

        [alter show];
        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

-(void )provideContent: (NSString*)identifier
{
    NSLog(@"");

}


// *****************************
// C Function
// *****************************

// Converts C style string to NSString
NSString* CreateNSString (const char* string)
{
	if (string)
		return [NSString stringWithUTF8String: string];
	else
		return [NSString stringWithUTF8String: ""];
}

// Helper method to create C string copy
char* MakeStringCopy (const char* string)
{
	if (string == NULL)
		return NULL;
	
	char* res = (char*)malloc(strlen(string) + 1);
	strcpy(res, string);
	return res;
}

void _startup()
{
    [UGameManager instance];
}



// iap
void _iniStore()
{
	[gameMgr iniStoreKit];
}

BOOL _canProcessPayments()
{
	return [gameMgr canProcessPayments];
}

BOOL _isProcessPayments()
{	
	return [gameMgr isProcessPayments];
}

void _purchaseItem( char* identifier)
{
	[gameMgr purchaseItem:CreateNSString(identifier)];
}

@end
