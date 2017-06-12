add_library(groupsock 
            GroupEId.cpp
            Groupsock.cpp
            GroupsockHelper.cpp
            IOHandlers.cpp
            NetAddress.cpp
            NetInterface.cpp
            inet.c
            include/GroupEId.hh
            include/Groupsock.hh
            include/GroupsockHelper.hh
            include/IOHandlers.hh
            include/NetAddress.hh
            include/NetCommon.h
            include/NetInterface.hh
            include/TunnelEncaps.hh
            include/groupsock_version.hh)
target_live555_compile_options(groupsock)
target_include_directories(groupsock PUBLIC include)
target_link_libraries(groupsock UsageEnvironment)
if(WIN32)
    target_link_libraries(groupsock ws2_32 mswsock)
endif()

set(groupsock_VERSION_CURRENT 9)
set(groupsock_VERSION_REVISION 1)
set(groupsock_VERSION_AGE 1)
math(EXPR groupsock_VERSION_MAJOR "${groupsock_VERSION_CURRENT} - ${groupsock_VERSION_AGE}")
set_target_properties(groupsock PROPERTIES 
                      VERSION ${groupsock_VERSION_MAJOR}.${groupsock_VERSION_AGE}.${groupsock_VERSION_REVISION}
                      SOVERSION ${groupsock_VERSION_MAJOR})
