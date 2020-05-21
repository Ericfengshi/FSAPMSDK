//
//  FSAPMGlobalDefine.h
//  FSAPMSDK
//
//  Created by fengs on 2018/11/7.
//  Copyright © 2018 fengs. All rights reserved.
//

#ifndef FSAPMGlobalDefine_h
#define FSAPMGlobalDefine_h

#pragma mark - 解决静态类无法使用 Category 方法
/**
 * Add this macro before each category implementation, so we don't have to use
 * -all_load or -force_load to load object files from static libraries that only contain
 * categories and no classes.
 * See http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html for more info.
 */
//#define TT_FIX_CATEGORY_BUG(name) NS_ROOT_CLASS @interface TT_FIX_CATEGORY_BUG_##name @end \
//@implementation TT_FIX_CATEGORY_BUG_##name @end

#define FSAPM_FIX_CATEGORY_BUG(name) NS_ROOT_CLASS @interface FSAPM_FIX_CATEGORY_BUG_##name @end \
@implementation FSAPM_FIX_CATEGORY_BUG_##name @end

#endif /* FSAPMGlobalDefine_h */
