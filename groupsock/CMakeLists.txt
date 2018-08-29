set(headers
    include/GroupEId.hh
    include/Groupsock.hh
    include/GroupsockHelper.hh
    include/IOHandlers.hh
    include/NetAddress.hh
    include/NetCommon.h
    include/NetInterface.hh
    include/TunnelEncaps.hh
    include/groupsock_version.hh
)
add_library(groupsock
    ${headers}
    GroupEId.cpp
    Groupsock.cpp
    GroupsockHelper.cpp
    IOHandlers.cpp
    NetAddress.cpp
    NetInterface.cpp
    inet.c
)
add_library(live555::groupsock ALIAS groupsock)
target_include_directories(groupsock
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_link_libraries(groupsock UsageEnvironment)
if(WIN32)
    target_link_libraries(groupsock ws2_32 mswsock)
endif()
live555_compile_options(groupsock)

set(groupsock_VERSION_CURRENT 9)
set(groupsock_VERSION_REVISION 1)
set(groupsock_VERSION_AGE 1)
math(EXPR groupsock_VERSION_MAJOR "${groupsock_VERSION_CURRENT} - ${groupsock_VERSION_AGE}")
set_target_properties(groupsock
    PROPERTIES 
        VERSION ${groupsock_VERSION_MAJOR}.${groupsock_VERSION_AGE}.${groupsock_VERSION_REVISION}
        SOVERSION ${groupsock_VERSION_MAJOR}
)

install(TARGETS groupsock EXPORT live555Target
    INCLUDES DESTINATION include
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include
)
