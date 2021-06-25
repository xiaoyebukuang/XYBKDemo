//
//  RequestMacros.h
//  cwz51
//
//  Created by 陈晓 on 2018/11/5.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef RequestMacros_h
#define RequestMacros_h

/** TARGET_TYPE   1 ： 生产   0：环境切换 */
#define TARGET_TYPE  0

#define TARGET_TYPE_KEY                  @"TARGET_TYPE_KEY"
#define TARGET_TYP_TEST                  0
#define TARGET_TYP_UAT                   1
#define TARGET_TYP_PRO                   2

/*************环境切换状态值*****************/
#if  TARGET_TYPE
/*************环境切换状态值*****************/
    
    /** 生产环境 */
    #define API_BASE_URL                        @"https://app.chengniu.com"
    #define API_BASE_WEB_URL                    @"https://app.chengniu.com:8075/ver6.4.0/#"
    #define API_BASE_WEB_CAD_URL                @"https://activity.chengniu.com/cad"

    //云闪付
    #define CLOUD_PAY_MODE                      @"00"
    //加密
    static NSString * const APP_SECRET_KEY   = @"7FAFB8D5";
    static NSString * const APP_SECRET_GIV   = @"2A44A90B";
    /** 友盟 */
    #define kUMengAppKey               @"5c04ed99b465f5aa3400007b"
    #define kUMengChannel              @"App Store"

#else
    /** 接口 */
    #define API_BASE_URL        [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                @"https://test.chengniu.com:9102" : \
                                ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                @"https://uatapp.chengniu.com" :    \
                                @"https://app.chengniu.com")        \

    /** H5接口 */
    #define API_BASE_WEB_URL    [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                @"https://test.chengniu.com:8071/ver6.4.0/#" :  \
                                ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                @"https://uatapp.chengniu.com:8075/ver6.4.0/#" :\
                                @"https://app.chengniu.com:8075/ver6.4.0/#")    \

    /** H5 CAD 接口 */
    #define API_BASE_WEB_CAD_URL    [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                    @"https://test.chengniu.com:8074/cad" :     \
                                    ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                    @"https://uatactivity.chengniu.com/cad" :   \
                                    @"https://activity.chengniu.com/cad")       \

    /** 云闪付 */
    #define CLOUD_PAY_MODE      @"00"

    /** 加密 */
    //KEY
    #define APP_SECRET_KEY      [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                @"D5ED1E14" :   \
                                ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                @"7FAFB8D5" :   \
                                @"7FAFB8D5")    \
    //GIV
    #define APP_SECRET_GIV      [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                @"9ACBE716" :   \
                                ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                @"2A44A90B" :   \
                                @"2A44A90B")    \


    /** 友盟 */
    #define kUMengAppKey        [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                @"5d65f79f3fc195ca94000352" :   \
                                ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                @"5d65f79f3fc195ca94000352" :   \
                                @"5c04ed99b465f5aa3400007b")    \

    #define kUMengChannel       [[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_TEST ?     \
                                @"App Store Test" :   \
                                ([[NSUserDefaults standardUserDefaults]integerForKey:TARGET_TYPE_KEY] == TARGET_TYP_UAT ?    \
                                @"App Store UAT" :   \
                                @"App Store")    \

#endif

#endif /* RequestMacros_h */
