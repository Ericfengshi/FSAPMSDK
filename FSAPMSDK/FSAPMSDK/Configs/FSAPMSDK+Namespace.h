// Namespaced Header
#ifndef __NS_SYMBOL
// We need to have multiple levels of macros here so that __NAMESPACE_PREFIX_ is
// properly replaced by the time we concatenate the namespace prefix.
#define __NS_REWRITE(ns, symbol) ns ## _ ## symbol
#define __NS_BRIDGE(ns, symbol) __NS_REWRITE(ns, symbol)
#define __NS_SYMBOL(symbol) __NS_BRIDGE(FSAPMSDK, symbol)
#endif

// Classes
#ifndef PPDNSMappingManager
#define PPDNSMappingManager __NS_SYMBOL(PPDNSMappingManager)
#endif

#ifndef PPDNSReporter
#define PPDNSReporter __NS_SYMBOL(PPDNSReporter)
#endif

#ifndef PPDomainRequestResult
#define PPDomainRequestResult __NS_SYMBOL(PPDomainRequestResult)
#endif

#ifndef PPIPValidator
#define PPIPValidator __NS_SYMBOL(PPIPValidator)
#endif

#ifndef PPMappingNode
#define PPMappingNode __NS_SYMBOL(PPMappingNode)
#endif

#ifndef PPMappingUtil
#define PPMappingUtil __NS_SYMBOL(PPMappingUtil)
#endif

#ifndef PPResolvedUrl
#define PPResolvedUrl __NS_SYMBOL(PPResolvedUrl)
#endif

#ifndef PPValidatingNode
#define PPValidatingNode __NS_SYMBOL(PPValidatingNode)
#endif

#ifndef PPWeakTimer
#define PPWeakTimer __NS_SYMBOL(PPWeakTimer)
#endif

#ifndef Reachability
#define Reachability __NS_SYMBOL(Reachability)
#endif

#ifndef DeallocStub
#define DeallocStub __NS_SYMBOL(DeallocStub)
#endif

#ifndef JJException
#define JJException __NS_SYMBOL(JJException)
#endif

#ifndef JJExceptionProxy
#define JJExceptionProxy __NS_SYMBOL(JJExceptionProxy)
#endif

#ifndef JJObserverContainer
#define JJObserverContainer __NS_SYMBOL(JJObserverContainer)
#endif

#ifndef JJSwizzleObject
#define JJSwizzleObject __NS_SYMBOL(JJSwizzleObject)
#endif

#ifndef JJZombieSub
#define JJZombieSub __NS_SYMBOL(JJZombieSub)
#endif

#ifndef KVOObjectContainer
#define KVOObjectContainer __NS_SYMBOL(KVOObjectContainer)
#endif

#ifndef KVOObjectItem
#define KVOObjectItem __NS_SYMBOL(KVOObjectItem)
#endif

#ifndef FSAPMSDKVendor
#define FSAPMSDKVendor __NS_SYMBOL(FSAPMSDKVendor)
#endif

#ifndef TimerObject
#define TimerObject __NS_SYMBOL(TimerObject)
#endif

#ifndef ZombieSelectorHandle
#define ZombieSelectorHandle __NS_SYMBOL(ZombieSelectorHandle)
#endif

// Functions
#ifndef unrecognizedSelectorZombie
#define unrecognizedSelectorZombie __NS_SYMBOL(unrecognizedSelectorZombie)
#endif

#ifndef swizzleClassMethod
#define swizzleClassMethod __NS_SYMBOL(swizzleClassMethod)
#endif

#ifndef get_load_address
#define get_load_address __NS_SYMBOL(get_load_address)
#endif

#ifndef get_slide_address
#define get_slide_address __NS_SYMBOL(get_slide_address)
#endif

#ifndef swizzleInstanceMethod
#define swizzleInstanceMethod __NS_SYMBOL(swizzleInstanceMethod)
#endif

#ifndef jj_requiresDeallocSwizzle
#define jj_requiresDeallocSwizzle __NS_SYMBOL(jj_requiresDeallocSwizzle)
#endif

#ifndef jj_swizzleDeallocIfNeeded
#define jj_swizzleDeallocIfNeeded __NS_SYMBOL(jj_swizzleDeallocIfNeeded)
#endif

#ifndef __JJ_SWIZZLE_BLOCK
#define __JJ_SWIZZLE_BLOCK __NS_SYMBOL(__JJ_SWIZZLE_BLOCK)
#endif

// Externs
#ifndef JJExceptionHandle
#define JJExceptionHandle __NS_SYMBOL(JJExceptionHandle)
#endif

#ifndef FSAPMSDKVendorVersionString
#define FSAPMSDKVendorVersionString __NS_SYMBOL(FSAPMSDKVendorVersionString)
#endif

#ifndef FSAPMSDKVendorVersionNumber
#define FSAPMSDKVendorVersionNumber __NS_SYMBOL(FSAPMSDKVendorVersionNumber)
#endif

#ifndef MAX_ARRAY_SIZE
#define MAX_ARRAY_SIZE __NS_SYMBOL(MAX_ARRAY_SIZE)
#endif

#ifndef kReachabilityChangedNotification
#define kReachabilityChangedNotification __NS_SYMBOL(kReachabilityChangedNotification)
#endif

// JJException Externs manual start 枚举，block名称，系统库Category，全局常量、变量
#ifndef AttributedStringHook
#define AttributedStringHook __NS_SYMBOL(AttributedStringHook)
#endif

#ifndef MutableAttributedStringHook
#define MutableAttributedStringHook __NS_SYMBOL(MutableAttributedStringHook)
#endif

#ifndef MutableSetHook
#define MutableSetHook __NS_SYMBOL(MutableSetHook)
#endif

#ifndef MutableStringHook
#define MutableStringHook __NS_SYMBOL(MutableStringHook)
#endif

#ifndef ClearNotification
#define ClearNotification __NS_SYMBOL(ClearNotification)
#endif

#ifndef SetHook
#define SetHook __NS_SYMBOL(SetHook)
#endif

#ifndef StringHook
#define StringHook __NS_SYMBOL(StringHook)
#endif

#ifndef CleanTimer
#define CleanTimer __NS_SYMBOL(CleanTimer)
#endif

#ifndef DeallocBlock
#define DeallocBlock __NS_SYMBOL(DeallocBlock)
#endif

#ifndef JJExceptionGuardCategory
#define JJExceptionGuardCategory __NS_SYMBOL(JJExceptionGuardCategory)
#endif

#ifndef JJExceptionGuardNone
#define JJExceptionGuardNone __NS_SYMBOL(JJExceptionGuardNone)
#endif

#ifndef JJExceptionGuardUnrecognizedSelector
#define JJExceptionGuardUnrecognizedSelector __NS_SYMBOL(JJExceptionGuardUnrecognizedSelector)
#endif

#ifndef JJExceptionGuardDictionaryContainer
#define JJExceptionGuardDictionaryContainer __NS_SYMBOL(JJExceptionGuardDictionaryContainer)
#endif

#ifndef JJExceptionGuardArrayContainer
#define JJExceptionGuardArrayContainer __NS_SYMBOL(JJExceptionGuardArrayContainer)
#endif

#ifndef JJExceptionGuardZombie
#define JJExceptionGuardZombie __NS_SYMBOL(JJExceptionGuardZombie)
#endif

#ifndef JJExceptionGuardKVOCrash
#define JJExceptionGuardKVOCrash __NS_SYMBOL(JJExceptionGuardKVOCrash)
#endif

#ifndef JJExceptionGuardNSTimer
#define JJExceptionGuardNSTimer __NS_SYMBOL(JJExceptionGuardNSTimer)
#endif

#ifndef JJExceptionGuardNSNotificationCenter
#define JJExceptionGuardNSNotificationCenter __NS_SYMBOL(JJExceptionGuardNSNotificationCenter)
#endif

#ifndef JJExceptionGuardNSStringContainer
#define JJExceptionGuardNSStringContainer __NS_SYMBOL(JJExceptionGuardNSStringContainer)
#endif

#ifndef JJExceptionGuardAllExceptZombie
#define JJExceptionGuardAllExceptZombie __NS_SYMBOL(JJExceptionGuardAllExceptZombie)
#endif

#ifndef JJExceptionGuardAll
#define JJExceptionGuardAll __NS_SYMBOL(JJExceptionGuardAll)
#endif

#ifndef ArrayHook
#define ArrayHook __NS_SYMBOL(ArrayHook)
#endif

#ifndef DictionaryHook
#define DictionaryHook __NS_SYMBOL(DictionaryHook)
#endif

#ifndef MutableArrayHook
#define MutableArrayHook __NS_SYMBOL(MutableArrayHook)
#endif

#ifndef MutableDictionaryHook
#define MutableDictionaryHook __NS_SYMBOL(MutableDictionaryHook)
#endif

#ifndef KVOCrash
#define KVOCrash __NS_SYMBOL(KVOCrash)
#endif

#ifndef UnrecognizedSelectorHook
#define UnrecognizedSelectorHook __NS_SYMBOL(UnrecognizedSelectorHook)
#endif

#ifndef ZombieHook
#define ZombieHook __NS_SYMBOL(ZombieHook)
#endif

#ifndef JJSwizzleOriginalIMP
#define JJSwizzleOriginalIMP __NS_SYMBOL(JJSwizzleOriginalIMP)
#endif

#ifndef JJSwizzledIMPBlock
#define JJSwizzledIMPBlock __NS_SYMBOL(JJSwizzledIMPBlock)
#endif

#ifndef SwizzleHook
#define SwizzleHook __NS_SYMBOL(SwizzleHook)
#endif
// JJException Externs manual end 枚举，block名称，系统库Category，全局常量、变量

// Reachability Externs manual start 枚举，block名称，系统库Category，全局常量、变量
#ifndef ReachabilityVersionNumber
#define ReachabilityVersionNumber __NS_SYMBOL(ReachabilityVersionNumber)
#endif

#ifndef ReachabilityVersionString
#define ReachabilityVersionString __NS_SYMBOL(ReachabilityVersionString)
#endif

#ifndef kReachabilityChangedNotification
#define kReachabilityChangedNotification __NS_SYMBOL(kReachabilityChangedNotification)
#endif

#ifndef NetworkStatus
#define NetworkStatus __NS_SYMBOL(NetworkStatus)
#endif

#ifndef NotReachable
#define NotReachable __NS_SYMBOL(NotReachable)
#endif

#ifndef ReachableViaWiFi
#define ReachableViaWiFi __NS_SYMBOL(ReachableViaWiFi)
#endif

#ifndef ReachableViaWWAN
#define ReachableViaWWAN __NS_SYMBOL(ReachableViaWWAN)
#endif

#ifndef Reachability
#define Reachability __NS_SYMBOL(Reachability)
#endif

#ifndef NetworkReachable
#define NetworkReachable __NS_SYMBOL(NetworkReachable)
#endif

#ifndef NetworkUnreachable
#define NetworkUnreachable __NS_SYMBOL(NetworkUnreachable)
#endif

#ifndef NetworkReachability
#define NetworkReachability __NS_SYMBOL(NetworkReachability)
#endif
// Reachability Externs manual end 枚举，block名称，系统库Category，全局常量、变量

// PPDNSMapping Externs manual start 枚举，block名称，系统库Category，全局常量、变量

#ifndef PPDomainRequestResultStatus
#define PPDomainRequestResultStatus __NS_SYMBOL(PPDomainRequestResultStatus)
#endif

#ifndef PPDomainRequestSuccess
#define PPDomainRequestSuccess __NS_SYMBOL(PPDomainRequestSuccess)
#endif

#ifndef PPDomainRequestFail
#define PPDomainRequestFail __NS_SYMBOL(PPDomainRequestFail)
#endif

#ifndef PPTimerHandler
#define PPTimerHandler __NS_SYMBOL(PPTimerHandler)
#endif
// PPDNSMapping Externs manual end 枚举，block名称，系统库Category，全局常量、变量
