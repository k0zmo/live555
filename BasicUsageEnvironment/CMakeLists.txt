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
target_link_libraries(BasicUsageEnvironment PUBLIC
    live555_cxx_flags
    UsageEnvironment
)
live555_target_version(BasicUsageEnvironment AUTO)
set_target_properties(BasicUsageEnvironment PROPERTIES FOLDER "live555/lib")

install(TARGETS BasicUsageEnvironment EXPORT live555Target
    INCLUDES DESTINATION include
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include
)
