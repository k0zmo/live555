cmake_minimum_required(VERSION 3.9)
project(live555 
    LANGUAGES C CXX 
    VERSION 2018.02.18
)

list(APPEND CMAKE_MODULE_PATH ${live555_SOURCE_DIR}/cmake)
include(live555)

option(LIVE555_EPOLL_SUPPORT "Enable epoll task scheduler (Windows also)" ON)
option(LIVE555_BUILD_EXAMPLES "Build examples and test programs" OFF)

add_subdirectory(UsageEnvironment)
add_subdirectory(groupsock)
add_subdirectory(BasicUsageEnvironment)
add_subdirectory(liveMedia)

if(LIVE555_EPOLL_SUPPORT)
    add_subdirectory(EpollTaskScheduler)
endif()

if(LIVE555_BUILD_EXAMPLES)
    add_subdirectory(testProgs)
    add_subdirectory(proxyServer)
    add_subdirectory(mediaServer)
endif()

# Installation stuff
set(config_version_file ${CMAKE_CURRENT_BINARY_DIR}/live555ConfigVersion.cmake)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(${config_version_file}
                                 VERSION ${live555_VERSION}
                                 COMPATIBILITY ExactVersion)

install(FILES ${config_version_file}
    DESTINATION lib/cmake/live555
)

install(EXPORT live555Target
    NAMESPACE live555::
    DESTINATION lib/cmake/live555
    FILE live555Config.cmake
)
