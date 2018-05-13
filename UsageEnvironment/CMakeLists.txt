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
target_include_directories(UsageEnvironment
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        # This is a cyclic dependency :(
        $<BUILD_INTERFACE:${live555_SOURCE_DIR}/groupsock/include>
        $<INSTALL_INTERFACE:include>)
live555_compile_options(UsageEnvironment)

set(UsageEnvironment_VERSION_CURRENT 4)
set(UsageEnvironment_VERSION_REVISION 0)
set(UsageEnvironment_VERSION_AGE 1)
math(EXPR UsageEnvironment_VERSION_MAJOR "${UsageEnvironment_VERSION_CURRENT} - ${UsageEnvironment_VERSION_AGE}")
set_target_properties(UsageEnvironment 
    PROPERTIES 
        VERSION ${UsageEnvironment_VERSION_MAJOR}.${UsageEnvironment_VERSION_AGE}.${UsageEnvironment_VERSION_REVISION}
        SOVERSION ${UsageEnvironment_VERSION_MAJOR}
)

install(TARGETS UsageEnvironment EXPORT live555Target
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
)
install(FILES ${headers}
    DESTINATION include
)
