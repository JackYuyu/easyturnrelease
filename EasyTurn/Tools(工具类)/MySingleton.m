//
//  MySingleton.m
//  AudioPlayer
//
//  Created by jack on 10-1-1.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MySingleton.h"
@implementation MySingleton
@synthesize token,toUserid;
@synthesize review;
@synthesize port;

static MySingleton* _sharedMySingleton = nil;

+(MySingleton*)sharedMySingleton
{
	@synchronized([MySingleton class])
	{
		if (!_sharedMySingleton)
			[[self alloc] init];
		
		return _sharedMySingleton;
	}
	
	return nil;
}

+(id)alloc
{
	@synchronized([MySingleton class])
	{
		NSAssert(_sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedMySingleton = [super alloc];
		return _sharedMySingleton;
	}
	
	return nil;
}

-(id)init {
	self = [super init];
	if (self != nil) {
		// initialize stuff here
	}
	
	return self;
}

-(void)sayHello {
	//NSLog(@"**%a",self.flag);
}

+ (id)filterNull:(id)obj{
    if (obj && ![obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    return nil;
}

+ (void)showAlertWithIsActionSheet:(BOOL)isActionSheet title:(NSString *)title msg:(NSString *)msg btnTitles:(NSArray *)btnTitles vc:(UIViewController *)vc click:(void (^)(NSInteger))clickBlock{
    if (!vc) {
        return;
    }
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:isActionSheet?UIAlertControllerStyleActionSheet:UIAlertControllerStyleAlert];
    if (btnTitles && btnTitles.count>0) {
        for (NSInteger i = 0;i<btnTitles.count;i++) {
            NSString *titleTemp = btnTitles[i];
            UIAlertAction *action = [UIAlertAction actionWithTitle:titleTemp style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (clickBlock) {
                    clickBlock(i+1);
                }
            }];
            [alertVC addAction:action];
        }
    }
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
    [alertVC addAction:action];
    __weak typeof(vc) weakController = vc;
    @try {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (isPad) {
                UIPopoverPresentationController *popPresenter = [alertVC popoverPresentationController];
                popPresenter.sourceView = weakController.view;
                popPresenter.sourceRect = CGRectMake(0, Screen_Height, Screen_Width, Screen_Height);
                
            }
            [weakController presentViewController: alertVC animated: YES completion: nil];
            
        });
    } @catch (NSException *exception) {
        NSLog(@"123");
    } @finally {
        
    }
}
@end
