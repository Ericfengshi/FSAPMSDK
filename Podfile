source 'https://github.com/CocoaPods/Specs.git'
# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'
inhibit_all_warnings!
def shared_pods
    
    # github pods
    pod 'Logan', '~> 1.2.1'         # Logan 日志库
    pod 'MMKV', '~> 1.0.17'         # MMAP 键值存储

end
def dev_only_pods
    pod 'Aspects', :configuration => 'Debug'                     # 黑魔法，界面统计
    pod 'FBMemoryProfiler', :configuration => 'Debug'            # Facebook内存监控
    pod 'MLeaksFinder', :git => 'https://github.com/Tencent/MLeaksFinder.git', :configuration => 'Debug'              # 腾讯内存监控
    pod 'Reveal-SDK', :configuration => 'Debug'
end
# Note: There are no targets called "default" in any of this workspace's Xcode projects
abstract_target 'default' do
    
    # Common inherited
    shared_pods
    
    target 'FSAPMSDKDemo' do
        # Pods for Main
    end
    
    target 'FSAPMSDKDemoDev' do
        # Pods for dev
        dev_only_pods
    end
    target 'FSAPMSDKDemoTests' do
        inherit! :search_paths
        # Pods for testing
    end
    target 'FSAPMSDKDemoUITests' do
        inherit! :search_paths
        # Pods for testing
    end
end
