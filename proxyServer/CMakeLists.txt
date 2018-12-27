add_executable(live555ProxyServer live555ProxyServer.cpp)
target_link_libraries(live555ProxyServer PRIVATE
    live555_cxx_flags
    liveMedia
    BasicUsageEnvironment
    $<$<TARGET_EXISTS:EpollTaskScheduler>:EpollTaskScheduler>
)
