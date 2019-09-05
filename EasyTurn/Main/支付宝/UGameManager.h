//
//  UGameManager.h
//  UGameManager
//
//  Created by Developer on 2/8/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@protocol UGameManagerDelegate <NSObject>
@optional
- (void) processGameCenterAuth: (NSError*) error;
@end

@interface UGameManager : NSObject<SKPaymentTransactionObserver>
{
    BOOL isProcessPayments;
}

@property (nonatomic, assign)  id <UGameManagerDelegate> delegate;
@property (nonatomic) BOOL	isProcessPayments;
@property (nonatomic,copy) void (^block)(void);

+ (UGameManager*) instance;

// store kit function
- (void) iniStoreKit;
- (BOOL) canProcessPayments;
- (void) purchaseItem:(NSString*) identifier;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) recordTransaction: (SKPaymentTransaction *)transaction;
- (void) provideContent: (NSString*)identifier;


@end

