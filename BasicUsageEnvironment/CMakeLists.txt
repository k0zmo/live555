add_library(BasicUsageEnvironment
            BasicHashTable.cpp
            BasicTaskScheduler.cpp
            BasicTaskScheduler0.cpp
            BasicUsageEnvironment.cpp
            BasicUsageEnvironment0.cpp
            DelayQueue.cpp
            include/BasicHashTable.hh
            include/BasicUsageEnvironment.hh
            include/BasicUsageEnvironment0.hh
            include/BasicUsageEnvironment_version.hh
            include/DelayQueue.hh
            include/HandlerSet.hh)
target_live555_compile_options(BasicUsageEnvironment)
target_include_directories(BasicUsageEnvironment PUBLIC include)
target_link_libraries(BasicUsageEnvironment PUBLIC UsageEnvironment)

set(BasicUsageEnvironment_VERSION_CURRENT 1)
set(BasicUsageEnvironment_VERSION_REVISION 1)
set(BasicUsageEnvironment_VERSION_AGE 0)
math(EXPR BasicUsageEnvironment_VERSION_MAJOR "${BasicUsageEnvironment_VERSION_CURRENT} - ${BasicUsageEnvironment_VERSION_AGE}")
set_target_properties(BasicUsageEnvironment PROPERTIES 
                      VERSION ${BasicUsageEnvironment_VERSION_MAJOR}.${BasicUsageEnvironment_VERSION_AGE}.${BasicUsageEnvironment_VERSION_REVISION}
                      SOVERSION ${BasicUsageEnvironment_VERSION_MAJOR})
