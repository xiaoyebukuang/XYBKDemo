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
//selfweak
#define WeakSelf                    __weak typeof(self) weakSelf = self;
//变量weak
#define WeakObj(o)                  __weak typeof(o) o##Weak = o;


#endif /* PathMacros_h */
