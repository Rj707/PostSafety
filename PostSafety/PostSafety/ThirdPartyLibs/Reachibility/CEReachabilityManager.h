#import <Foundation/Foundation.h>
#import <Reachability/Reachability.h>
#define isInternetAvailable [CEReachabilityManager isReachable]
#define NetworkManager [CEReachabilityManager sharedManager]

@class Reachability;

@interface CEReachabilityManager : NSObject

@property (strong, nonatomic) Reachability *reachability;

+ (CEReachabilityManager *)sharedManager;

+ (BOOL)isReachable;

@end
