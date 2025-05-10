//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

int poc(char *path);
int backboard_respring(void);

// UIStatusBarServer private API declaration (iOS 16)
@interface UIStatusBarServer : NSObject
+ (void)addStatusBarItem:(int32_t)arg1;
+ (void)removeStatusBarItem:(int32_t)arg1;
+ (void)addStyleOverrides:(int32_t)arg1;
+ (void)removeStyleOverrides:(int32_t)arg1;
@end
