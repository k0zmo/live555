function(live555_add_test_executable _target)
    add_executable(${_target} ${ARGN})
    target_link_libraries(${_target} PRIVATE
        live555_cxx_flags
        liveMedia
        BasicUsageEnvironment
        $<$<TARGET_EXISTS:EpollTaskScheduler>:EpollTaskScheduler>
    )
endfunction()

live555_add_test_executable(openRTSP
    openRTSP.cpp
    playCommon.cpp
    playCommon.hh
)
live555_add_test_executable(playSIP
    playSIP.cpp
    playCommon.cpp
    playCommon.hh
)

live555_add_test_executable(testRTSPClient testRTSPClient.cpp)
live555_add_test_executable(testH264VideoStreamer testH264VideoStreamer.cpp)
live555_add_test_executable(testOnDemandRTSPServer testOnDemandRTSPServer.cpp)

# TODO: No epoll here yet
live555_add_test_executable(MPEG2TransportStreamIndexer MPEG2TransportStreamIndexer.cpp)
live555_add_test_executable(registerRTSPStream registerRTSPStream.cpp)
live555_add_test_executable(sapWatch sapWatch.cpp)
live555_add_test_executable(testAMRAudioStreamer testAMRAudioStreamer.cpp)
live555_add_test_executable(testDVVideoStreamer testDVVideoStreamer.cpp)
live555_add_test_executable(testH264VideoToTransportStream testH264VideoToTransportStream.cpp)
live555_add_test_executable(testH265VideoStreamer testH265VideoStreamer.cpp)
live555_add_test_executable(testH265VideoToTransportStream testH265VideoToTransportStream.cpp)
live555_add_test_executable(testMKVStreamer testMKVStreamer.cpp)
live555_add_test_executable(testMP3Receiver testMP3Receiver.cpp)
live555_add_test_executable(testMP3Streamer testMP3Streamer.cpp)
live555_add_test_executable(testMPEG1or2AudioVideoStreamer testMPEG1or2AudioVideoStreamer.cpp)
live555_add_test_executable(testMPEG1or2ProgramToTransportStream testMPEG1or2ProgramToTransportStream.cpp)
live555_add_test_executable(testMPEG1or2Splitter testMPEG1or2Splitter.cpp)
live555_add_test_executable(testMPEG1or2VideoReceiver testMPEG1or2VideoReceiver.cpp)
live555_add_test_executable(testMPEG1or2VideoStreamer testMPEG1or2VideoStreamer.cpp)
live555_add_test_executable(testMPEG2TransportReceiver testMPEG2TransportReceiver.cpp)
live555_add_test_executable(testMPEG2TransportStreamTrickPlay testMPEG2TransportStreamTrickPlay.cpp)
live555_add_test_executable(testMPEG2TransportStreamer testMPEG2TransportStreamer.cpp)
live555_add_test_executable(testMPEG4VideoStreamer testMPEG4VideoStreamer.cpp)
live555_add_test_executable(testOggStreamer testOggStreamer.cpp)
live555_add_test_executable(testRelay testRelay.cpp)
live555_add_test_executable(testReplicator testReplicator.cpp)
live555_add_test_executable(testWAVAudioStreamer testWAVAudioStreamer.cpp)
live555_add_test_executable(vobStreamer vobStreamer.cpp)
