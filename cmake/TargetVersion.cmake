function(__live555_target_version_impl _target _current _revision _age)
    math(EXPR version_major "${_current} - ${_age}")
    set_target_properties(${_target}
        PROPERTIES 
            VERSION ${version_major}.${_age}.${_revision}
            SOVERSION ${version_major}
    )
    message(STATUS "${_target} library version: ${version_major}.${_age}.${_revision}")
endfunction()

function(live555_target_version _target)
    cmake_parse_arguments(options "AUTO" "CURRENT;REVISION;AGE" "" ${ARGN})
    if(options_AUTO)
        # Versioning based on contens in the config.linux-with-shared-libraries file
        file(READ "${live555_SOURCE_DIR}/config.linux-with-shared-libraries" contents)
        string(REGEX MATCH "lib${_target}_VERSION_CURRENT=([0-9]+)" _ ${contents})
        set(current ${CMAKE_MATCH_1})
        string(REGEX MATCH "lib${_target}_VERSION_REVISION=([0-9]+)" _ ${contents})
        set(revision ${CMAKE_MATCH_1})
        string(REGEX MATCH "lib${_target}_VERSION_AGE=([0-9]+)" _ ${contents})
        set(age ${CMAKE_MATCH_1})
        __live555_target_version_impl(${_target} 
            ${current}
            ${revision}
            ${age}
        )
        return()
    endif()

    # Manual versioning
    if(NOT DEFINED options_CURRENT OR 
       NOT DEFINED options_REVISION OR
       NOT DEFINED options_AGE)
        message(FATAL_ERROR "Unsufficient number arguments provided")
    endif()
    __live555_target_version_impl(${_target} 
        ${options_CURRENT}
        ${options_REVISION}
        ${options_AGE}
    )
endfunction()
