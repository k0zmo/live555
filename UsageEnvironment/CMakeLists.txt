set(headers
    include/Boolean.hh
    include/HashTable.hh
    include/UsageEnvironment.hh
    include/UsageEnvironment_version.hh
    include/strDup.hh
)
add_library(UsageEnvironment
    ${headers}
    HashTable.cpp
    UsageEnvironment.cpp
    strDup.cpp
)
add_library(live555::UsageEnvironment ALIAS UsageEnvironment)
target_include_directories(UsageEnvironment
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        # This is a cyclic dependency :(
        $<BUILD_INTERFACE:${live555_SOURCE_DIR}/groupsock/include>
)
live555_compile_options(UsageEnvironment)
live555_target_version(UsageEnvironment AUTO)

install(TARGETS UsageEnvironment EXPORT live555Target
    INCLUDES DESTINATION include
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include
)
