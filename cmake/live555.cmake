function(live555_compile_options _target)
    if(WIN32)
        target_compile_definitions(${_target} 
            PUBLIC
                LOCALE_NOT_USED
                SOCKLEN_T=int
        )
        if(MSVC)
            # Turn off the noise
            target_compile_definitions(${_target}
                PRIVATE
                    _CRT_SECURE_NO_WARNINGS
                    _WINSOCK_DEPRECATED_NO_WARNINGS
            )
        endif()
    else()
        target_compile_definitions(${_target}
            PUBLIC
                BSD=1
                SOCKLEN_T=socklen_t
        )
    endif()
endfunction(live555_compile_options)

function(live555_add_test_executable _target)
    add_executable(${_target} ${ARGN})
    live555_compile_options(${_target})
    target_link_libraries(${_target} liveMedia BasicUsageEnvironment)
    if(TARGET EpollTaskScheduler)
        target_link_libraries(${_target} EpollTaskScheduler)
    endif()
endfunction(live555_add_test_executable)
