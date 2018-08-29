set(headers
    include/EpollTaskScheduler.hh
)
add_library(EpollTaskScheduler ${headers} EpollTaskScheduler.cpp)
add_library(live555::EpollTaskScheduler ALIAS EpollTaskScheduler)

if(WIN32)
    target_sources(EpollTaskScheduler 
        PRIVATE 
            epoll.c 
            epoll.h
            msafd.h
            ntapi.h
            tree.h
    )
endif()

target_include_directories(EpollTaskScheduler
    PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
target_link_libraries(EpollTaskScheduler PUBLIC BasicUsageEnvironment)
target_compile_definitions(EpollTaskScheduler INTERFACE HAVE_EPOLL_SCHEDULER)
live555_compile_options(EpollTaskScheduler)

set(EpollTaskScheduler_VERSION_CURRENT 1)
set(EpollTaskScheduler_VERSION_REVISION 0)
set(EpollTaskScheduler_VERSION_AGE 0)
math(EXPR EpollTaskScheduler_VERSION_MAJOR "${EpollTaskScheduler_VERSION_CURRENT} - ${EpollTaskScheduler_VERSION_AGE}")
set_target_properties(EpollTaskScheduler
    PROPERTIES 
        VERSION ${EpollTaskScheduler_VERSION_MAJOR}.${EpollTaskScheduler_VERSION_AGE}.${EpollTaskScheduler_VERSION_REVISION}
        SOVERSION ${EpollTaskScheduler_VERSION_MAJOR}
)

install(TARGETS EpollTaskScheduler EXPORT live555Target
    INCLUDES DESTINATION include
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include
)
