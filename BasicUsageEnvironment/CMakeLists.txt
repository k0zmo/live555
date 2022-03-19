set(headers
    include/BasicHashTable.hh
    include/BasicUsageEnvironment.hh
    include/BasicUsageEnvironment0.hh
    include/BasicUsageEnvironment_version.hh
    include/DelayQueue.hh
    include/HandlerSet.hh
)
add_library(BasicUsageEnvironment ${live555_library_type}
    ${headers}
    BasicHashTable.cpp
    BasicTaskScheduler.cpp
    BasicTaskScheduler0.cpp
    BasicUsageEnvironment.cpp
    BasicUsageEnvironment0.cpp
    DelayQueue.cpp
)
target_include_directories(BasicUsageEnvironment
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_link_libraries(BasicUsageEnvironment PUBLIC
    live555_cxx_flags
    UsageEnvironment
)
if(LIVE555_DEBUG_OUTPUT)
    target_compile_definitions(BasicUsageEnvironment PRIVATE DEBUG)
endif()
set_target_properties(BasicUsageEnvironment PROPERTIES FOLDER "live555/lib")

if(NOT LIVE555_MONOLITH_BUILD)
    add_library(live555::BasicUsageEnvironment ALIAS BasicUsageEnvironment)
    live555_target_version(BasicUsageEnvironment AUTO)
endif()

install(TARGETS BasicUsageEnvironment EXPORT live555Target
    INCLUDES DESTINATION include/BasicUsageEnvironment
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include/BasicUsageEnvironment
)
