add_library(EpollTaskScheduler
            EpollTaskScheduler.cpp
            include/EpollTaskScheduler.hh)

if(WIN32)
    target_sources(EpollTaskScheduler PRIVATE epoll.c 
                                              epoll.h
                                              msafd.h
                                              ntapi.h
                                              tree.h)
endif()

target_live555_compile_options(EpollTaskScheduler)
target_include_directories(EpollTaskScheduler PUBLIC include)
target_link_libraries(EpollTaskScheduler PUBLIC BasicUsageEnvironment)
target_compile_definitions(EpollTaskScheduler INTERFACE HAVE_EPOLL_SCHEDULER)

set(EpollTaskScheduler_VERSION_CURRENT 1)
set(EpollTaskScheduler_VERSION_REVISION 0)
set(EpollTaskScheduler_VERSION_AGE 0)
math(EXPR EpollTaskScheduler_VERSION_MAJOR "${EpollTaskScheduler_VERSION_CURRENT} - ${EpollTaskScheduler_VERSION_AGE}")
set_target_properties(EpollTaskScheduler PROPERTIES 
                        VERSION ${EpollTaskScheduler_VERSION_MAJOR}.${EpollTaskScheduler_VERSION_AGE}.${EpollTaskScheduler_VERSION_REVISION}
                        SOVERSION ${EpollTaskScheduler_VERSION_MAJOR})
