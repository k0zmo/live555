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
target_link_libraries(EpollTaskScheduler PUBLIC
    live555_cxx_flags
    BasicUsageEnvironment
)
target_compile_definitions(EpollTaskScheduler INTERFACE HAVE_EPOLL_SCHEDULER)
live555_target_version(EpollTaskScheduler 
    CURRENT 1
    REVISION 0
    AGE 0
)
set_target_properties(EpollTaskScheduler PROPERTIES FOLDER "live555/lib")

install(TARGETS EpollTaskScheduler EXPORT live555Target
    INCLUDES DESTINATION include
    RUNTIME DESTINATION bin/$<CONFIG>
    LIBRARY DESTINATION lib/$<CONFIG>
    ARCHIVE DESTINATION lib/$<CONFIG>
)
install(FILES ${headers}
    DESTINATION include
)
