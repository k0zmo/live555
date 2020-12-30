cmake_minimum_required(VERSION 3.9)

# Parse version number from the header file
file(READ ${CMAKE_CURRENT_SOURCE_DIR}/liveMedia/include/liveMedia_version.hh contents)
string(REGEX MATCH "define LIVEMEDIA_LIBRARY_VERSION_STRING	\"([0-9\.]+)\"" _ ${contents})
set(project_version ${CMAKE_MATCH_1})
if(NOT DEFINED PROJECT_NAME)
    set(live555_master_project TRUE)
endif()

project(live555
    LANGUAGES C CXX
    VERSION ${project_version}
)
message(STATUS "live555 version: ${project_version}")

list(APPEND CMAKE_MODULE_PATH ${live555_SOURCE_DIR}/cmake)
include(TargetVersion)

option(LIVE555_EPOLL_SUPPORT "Enable epoll task scheduler (Windows also)" ON)
option(LIVE555_BUILD_EXAMPLES "Build examples and test programs" ${live555_master_project})
option(LIVE555_ENABLE_OPENSSL "Build with OpenSSL support (rtsps, SRTP)." ON)
option(LIVE555_MONOLITH_BUILD "Build all modules as one monolithic library" OFF)

add_library(live555_cxx_flags INTERFACE)
if(WIN32)
    target_compile_definitions(live555_cxx_flags INTERFACE
        LOCALE_NOT_USED
        SOCKLEN_T=int
    )
else()
    target_compile_definitions(live555_cxx_flags INTERFACE
        BSD=1
        SOCKLEN_T=socklen_t
    )
endif()

if(LIVE555_ENABLE_OPENSSL)
    find_package(OpenSSL 1.1.1 REQUIRED COMPONENTS Crypto SSL)
    target_link_libraries(live555_cxx_flags INTERFACE
        OpenSSL::Crypto
        OpenSSL::SSL
    )
else()
    target_compile_definitions(live555_cxx_flags INTERFACE NO_OPENSSL=1)
endif()

install(TARGETS live555_cxx_flags EXPORT live555Target)

if(LIVE555_MONOLITH_BUILD)
    set(live555_library_type OBJECT)
endif()

add_subdirectory(UsageEnvironment)
add_subdirectory(groupsock)
add_subdirectory(BasicUsageEnvironment)
add_subdirectory(liveMedia)
if(LIVE555_EPOLL_SUPPORT)
    add_subdirectory(EpollTaskScheduler)
endif()

if(LIVE555_MONOLITH_BUILD)
    add_library(live555 dummy.cpp)
    target_link_libraries(live555 PUBLIC
        UsageEnvironment
        groupsock
        BasicUsageEnvironment
        liveMedia
    )
    if(TARGET EpollTaskScheduler)
        target_link_libraries(live555 PUBLIC EpollTaskScheduler)
        add_library(live555::EpollTaskScheduler ALIAS EpollTaskScheduler)
    endif()
    add_library(live555::live555 ALIAS live555)
    add_library(live555::UsageEnvironment ALIAS live555)
    add_library(live555::groupsock ALIAS live555)
    add_library(live555::BasicUsageEnvironment ALIAS live555)
    add_library(live555::liveMedia ALIAS live555)

    live555_target_version(live555
        CURRENT 1
        REVISION 0
        AGE 0
    )
    set_target_properties(liveMedia PROPERTIES FOLDER "live555")
else()
    add_library(live555 INTERFACE)
    add_library(live555::live555 ALIAS live555)
    target_link_libraries(live555 INTERFACE
        UsageEnvironment
        groupsock
        BasicUsageEnvironment
        liveMedia
    )
    if(TARGET EpollTaskScheduler)
        target_link_libraries(live555 INTERFACE EpollTaskScheduler)
    endif()
endif()

install(TARGETS live555 EXPORT live555Target
    INCLUDES DESTINATION include/liveMedia
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)

if(LIVE555_BUILD_EXAMPLES)
    add_subdirectory(testProgs)
    add_subdirectory(proxyServer)
    add_subdirectory(mediaServer)
    add_subdirectory(hlsProxy)
endif()

if(live555_master_project)
    set_property(GLOBAL PROPERTY USE_FOLDERS ON)
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
