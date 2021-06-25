//
//  UIDevice+Helper.m
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#import "UIDevice+Helper.h"
#import "KeyChainStore.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#define IOS_VPN         @"utun0"
#define IOS_WIFI        @"en0"
#define IOS_WIFI_MAC    @"en5"
#define IOS_CELLULAR    @"pdp_ip0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

#define  KEY_USERNAME_PASSWORD @"com.kata.cwz51.changxiche"
#define  KEY_MACHINE_PASSWORD  @"com.kata.cwz51.machine"

@implementation UIDevice (Helper)
+ (NSString *)getIDFA {
    // 获取IDFA
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
            }
        }];
    }
    NSString * IDFA = [NSString safe_string:[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
    NSString *tempIDFA = [IDFA stringByReplacingOccurrencesOfString:@"-" withString:@""];
    tempIDFA = [tempIDFA stringByReplacingOccurrencesOfString:@"0" withString:@""];
    return [NSString safe_string:tempIDFA];
}
/** 设备唯一id ->UUID */
+ (NSString *)getDeviceOnlyUUID {
    NSString * strUUID = [NSString safe_string:[KeyChainStore load:KEY_USERNAME_PASSWORD]];
    NSString *historyDeviceModel = [NSString safe_string:[KeyChainStore load:KEY_MACHINE_PASSWORD]];
    NSString *currentDeviceModel = [UIDevice getCurrentDeviceModel];
    if (strUUID.length != 0 && historyDeviceModel.length != 0 && [historyDeviceModel isEqualToString:currentDeviceModel]) {
        return strUUID;
    }
    /** 其他情况生成UUID */
    strUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
    //将该uuid保存到keychain
    [KeyChainStore save:KEY_USERNAME_PASSWORD data:strUUID];
    [KeyChainStore save:KEY_MACHINE_PASSWORD data:currentDeviceModel];
    return [NSString safe_string:strUUID];
}
/** 获取设备IP地址 */
+ (NSString *)getDeviceIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = @[IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI_MAC @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv4];
//    NSArray *searchArray = preferIPv4 ?
//    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
//    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6,  IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    NSDictionary *addresses = [self getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
/** 获取手机设备型号 */
+ (NSString *)getCurrentDeviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";

    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";

    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";

    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";

    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";

    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";

    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";

    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";

    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";

    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";

    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";

    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";

    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";

    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";

    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付

    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";

    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";

    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";

    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";

    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";

    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";

    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";

    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";

    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";

    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";

    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";

    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";

    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";

    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";

    if ([deviceModel isEqualToString:@"iPhone12,1"])   return @"iPhone 11";

    if ([deviceModel isEqualToString:@"iPhone12,3"])   return @"iPhone 11 Pro";

    if ([deviceModel isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";

    if ([deviceModel isEqualToString:@"iPhone12,8"])   return @"iPhone SE (2nd generation)";
    
    if ([deviceModel isEqualToString:@"iPhone13,1"])   return @"iPhone 12 mini";
    
    if ([deviceModel isEqualToString:@"iPhone13,2"])   return @"iPhone 12";
    
    if ([deviceModel isEqualToString:@"iPhone13,3"])   return @"iPhone 12 Pro";
    
    if ([deviceModel isEqualToString:@"iPhone13,4"])   return @"iPhone 12 Pro Max";

    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";

    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";

    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";

    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";

    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";

    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";

    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";

    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";

    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";

    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";

    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";

    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";

    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";

    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";

    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";

    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";

    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";

    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";

    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";

    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";

    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";

    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";

    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";

    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";

    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";

    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";

    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";

    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";

    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";

    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";

    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";

    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";

    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";

    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";

    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";

    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";

    
    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";

    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";

    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";

    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";

    
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";

    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";

    return [NSString safe_string:deviceModel];
}
/** 获取手机设备系统名称 */
+ (NSString *)getCurrentDeviceSystemVersion {
    NSString *deviceNameStr = [[UIDevice currentDevice] systemName];//手机系统名称
    NSString *systemVersionStr = [[UIDevice currentDevice] systemVersion];//手机系统版本号
    return [NSString stringWithFormat:@"%@%@",deviceNameStr,systemVersionStr];
}
/** 获取app版本号 */
+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return [NSString safe_string:app_Version];
}
/** 获取app名称 */
+ (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return [NSString safe_string:app_Name];
}
/** 获取buildId */
+ (NSString *)getAppBuildID {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_buildId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    return [NSString safe_string:app_buildId];
}
/** 拨打电话 */
+ (void)callTel:(NSString *)tel {
    NSString *telStr = [NSString stringWithFormat:@"tel://%@",tel];
    [self openURLStr:telStr];
}
/** 拨打电话 */
+ (void)callCompleteTel:(NSString *)tel {
    NSString *telStr = [NSString safe_string:tel];
    [self openURLStr:telStr];
}
/** 打开设置 */
+ (void)openSetting {
    [self openURLStr:UIApplicationOpenSettingsURLString];
}
/** 打开链接 */
+ (void)openURLStr:(NSString *)urlStr {
    /// 大于等于10.0系统使用此openURL方法
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    }
}


@end
