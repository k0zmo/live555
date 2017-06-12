add_library(UsageEnvironment
            HashTable.cpp
            UsageEnvironment.cpp
            strDup.cpp
            include/Boolean.hh
            include/HashTable.hh
            include/UsageEnvironment.hh
            include/UsageEnvironment_version.hh
            include/strDup.hh)
target_live555_compile_options(UsageEnvironment)
target_include_directories(UsageEnvironment PUBLIC include
                                                   # This is a cyclic dependency :(
                                                   ${LIVE555_SOURCE_DIR}/groupsock/include)

set(UsageEnvironment_VERSION_CURRENT 4)
set(UsageEnvironment_VERSION_REVISION 0)
set(UsageEnvironment_VERSION_AGE 1)
math(EXPR UsageEnvironment_VERSION_MAJOR "${UsageEnvironment_VERSION_CURRENT} - ${UsageEnvironment_VERSION_AGE}")
set_target_properties(UsageEnvironment PROPERTIES 
                      VERSION ${UsageEnvironment_VERSION_MAJOR}.${UsageEnvironment_VERSION_AGE}.${UsageEnvironment_VERSION_REVISION}
                      SOVERSION ${UsageEnvironment_VERSION_MAJOR})
