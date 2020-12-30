add_executable(live555HLSProxy live555HLSProxy.cpp)
target_link_libraries(live555HLSProxy PRIVATE live555::live555)
set_target_properties(live555HLSProxy PROPERTIES FOLDER "live555/Servers")
