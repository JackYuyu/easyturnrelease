//
//  MySingleton.h
//  AudioPlayer
//
//  Created by jack on 10-1-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MySingleton : NSObject {
	NSString *updateUrl;
}
@property (nonatomic, retain) NSString *token;
@property (nonatomic, assign) int review;
@property (nonatomic, retain) NSString *toUserid;
@property (nonatomic, retain) UIImage *port;
@property (nonatomic, retain) NSMutableArray *scopes;


+(MySingleton*)sharedMySingleton;
-(void)sayHello;
+ (id)filterNull:(id)obj;
+ (void)showAlertWithIsActionSheet:(BOOL)isActionSheet title:(NSString *)title msg:(NSString *)msg btnTitles:(NSArray *)btnTitles vc:(UIViewController *)vc click:(void (^)(NSInteger tag))clickBlock;
@end
