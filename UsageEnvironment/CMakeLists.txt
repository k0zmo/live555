set(headers
    include/Boolean.hh
    include/HashTable.hh
    include/UsageEnvironment.hh
    include/UsageEnvironment_version.hh
    include/strDup.hh
)
add_library(UsageEnvironment ${live555_library_type}
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
)
target_link_libraries(UsageEnvironment PUBLIC live555_cxx_flags)
set_target_properties(UsageEnvironment PROPERTIES FOLDER "live555/lib")

if(NOT LIVE555_MONOLITH_BUILD)
    add_library(live555::UsageEnvironment ALIAS UsageEnvironment)
    live555_target_version(UsageEnvironment AUTO)
endif()

install(TARGETS UsageEnvironment EXPORT live555Target
    INCLUDES DESTINATION include/UsageEnvironment
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include/UsageEnvironment
)
