set(headers
    include/GroupEId.hh
    include/Groupsock.hh
    include/GroupsockHelper.hh
    include/IOHandlers.hh
    include/NetAddress.hh
    include/NetCommon.h
    include/NetInterface.hh
    include/groupsock_version.hh
)
add_library(groupsock ${live555_library_type}
    ${headers}
    GroupEId.cpp
    Groupsock.cpp
    GroupsockHelper.cpp
    IOHandlers.cpp
    NetAddress.cpp
    NetInterface.cpp
    inet.c
)
target_include_directories(groupsock
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_link_libraries(groupsock
    PRIVATE live555_cxx_flags
    PUBLIC  UsageEnvironment
)
if(LIVE555_DEBUG_OUTPUT)
    target_compile_definitions(groupsock PRIVATE DEBUG)
endif()
if(WIN32)
    target_link_libraries(groupsock PRIVATE ws2_32 mswsock)
    target_compile_definitions(groupsock PRIVATE NO_GETIFADDRS)
endif()
set_target_properties(groupsock PROPERTIES FOLDER "live555/lib")

if(NOT LIVE555_MONOLITH_BUILD)
    add_library(live555::groupsock ALIAS groupsock)
    live555_target_version(groupsock AUTO)
endif()

install(TARGETS groupsock EXPORT live555Target
    INCLUDES DESTINATION include/groupsock
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include/groupsock
)
