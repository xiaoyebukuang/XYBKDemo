//
//  PathMacros.h
//  XYBKDemo
//
//  Created by 陈晓 on 2018/4/26.
//  Copyright © 2018年 XYBK. All rights reserved.
//

#ifndef PathMacros_h
#define PathMacros_h

/** 文件目录 */
#define PATH_HOME                   NSHomeDirectory()
#define PATH_DOCUMENT               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_CACHE                  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_LIBRARY                [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define PATH_TEMP                   NSTemporaryDirectory()

/** 强弱引用*/
#define WEAK_SELF(type)             __weak typeof(type) weak##type = type;
#define STROONG_SELF(type)          __strong typeof(type) type = weak##type;


#endif /* PathMacros_h */
