cmake_minimum_required(VERSION 3.1.2)
project(live555 LANGUAGES C CXX)

set(LIVE555_SOURCE_DIR ${live555_SOURCE_DIR})
set(LIVE555_CMAKE_MODULE_PATH ${LIVE555_SOURCE_DIR}/cmake)
set(CMAKE_MODULE_PATH ${LIVE555_CMAKE_MODULE_PATH} ${CMAKE_MODULE_PATH})

option(LIVE555_EPOLL_SUPPORT "Enable epoll task scheduler (Windows also)" ON)
option(LIVE555_BUILD_EXAMPLES "Build examples and test programs" OFF)

include(live555)

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

message(STATUS "Epoll support: ${LIVE555_EPOLL_SUPPORT}")
message(STATUS "Building examples: ${LIVE555_BUILD_EXAMPLES}")
