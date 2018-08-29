set(headers
    include/BasicHashTable.hh
    include/BasicUsageEnvironment.hh
    include/BasicUsageEnvironment0.hh
    include/BasicUsageEnvironment_version.hh
    include/DelayQueue.hh
    include/HandlerSet.hh
)
add_library(BasicUsageEnvironment
    ${headers}
    BasicHashTable.cpp
    BasicTaskScheduler.cpp
    BasicTaskScheduler0.cpp
    BasicUsageEnvironment.cpp
    BasicUsageEnvironment0.cpp
    DelayQueue.cpp
)
add_library(live555::BasicUsageEnvironment ALIAS BasicUsageEnvironment)
target_include_directories(BasicUsageEnvironment
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_link_libraries(BasicUsageEnvironment PUBLIC UsageEnvironment)
live555_compile_options(BasicUsageEnvironment)

set(BasicUsageEnvironment_VERSION_CURRENT 1)
set(BasicUsageEnvironment_VERSION_REVISION 1)
set(BasicUsageEnvironment_VERSION_AGE 0)
math(EXPR BasicUsageEnvironment_VERSION_MAJOR "${BasicUsageEnvironment_VERSION_CURRENT} - ${BasicUsageEnvironment_VERSION_AGE}")
set_target_properties(BasicUsageEnvironment 
    PROPERTIES 
        VERSION ${BasicUsageEnvironment_VERSION_MAJOR}.${BasicUsageEnvironment_VERSION_AGE}.${BasicUsageEnvironment_VERSION_REVISION}
        SOVERSION ${BasicUsageEnvironment_VERSION_MAJOR}
)

install(TARGETS BasicUsageEnvironment EXPORT live555Target
    INCLUDES DESTINATION include
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include
)
