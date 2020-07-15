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
target_link_libraries(groupsock
    PRIVATE live555_cxx_flags
    PUBLIC  UsageEnvironment
)
if(WIN32)
    target_link_libraries(groupsock PRIVATE ws2_32 mswsock)
endif()
live555_target_version(groupsock AUTO)
set_target_properties(groupsock PROPERTIES FOLDER "live555/lib")

install(TARGETS groupsock EXPORT live555Target
    INCLUDES DESTINATION include/groupsock
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include/groupsock
)
