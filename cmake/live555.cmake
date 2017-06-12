function(target_live555_compile_options _target)
    if(WIN32)
        target_compile_definitions(${_target} PUBLIC NOMINMAX
                                                     _WIN32_WINNT=0x0601
                                                     LOCALE_NOT_USED
                                                     SOCKLEN_T=int)
    else()
        target_compile_definitions(${_target} PUBLIC BSD=1
                                                     SOCKLEN_T=socklen_t)
    endif()

    if(MSVC)
        target_compile_options(${_target} PRIVATE /W3)
        target_compile_definitions(${_target} PRIVATE _CRT_SECURE_NO_WARNINGS
                                                      _WINSOCK_DEPRECATED_NO_WARNINGS)
    else()
        target_compile_options(${_target} PRIVATE -Wall)
    endif()
endfunction()

function(add_test_executable _target)
    add_executable(${_target} ${ARGN})
    target_live555_compile_options(${_target})
    target_link_libraries(${_target} liveMedia BasicUsageEnvironment)
    if(TARGET EpollTaskScheduler)
        target_link_libraries(${_target} EpollTaskScheduler)
    endif()
endfunction()
