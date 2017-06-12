add_test_executable(openRTSP
                    openRTSP.cpp
                    playCommon.cpp
                    playCommon.hh)
add_test_executable(playSIP
                    playSIP.cpp
                    playCommon.cpp
                    playCommon.hh)

add_test_executable(testRTSPClient testRTSPClient.cpp)
add_test_executable(testH264VideoStreamer testH264VideoStreamer.cpp)
add_test_executable(testOnDemandRTSPServer testOnDemandRTSPServer.cpp)

# TODO: No epoll here yet
add_test_executable(MPEG2TransportStreamIndexer MPEG2TransportStreamIndexer.cpp)
add_test_executable(registerRTSPStream registerRTSPStream.cpp)
add_test_executable(sapWatch sapWatch.cpp)
add_test_executable(testAMRAudioStreamer testAMRAudioStreamer.cpp)
add_test_executable(testDVVideoStreamer testDVVideoStreamer.cpp)
#add_test_executable(testGSMStreamer testGSMStreamer.cpp testGSMEncoder.cpp)
add_test_executable(testH264VideoToTransportStream testH264VideoToTransportStream.cpp)
add_test_executable(testH265VideoStreamer testH265VideoStreamer.cpp)
add_test_executable(testH265VideoToTransportStream testH265VideoToTransportStream.cpp)
add_test_executable(testMKVStreamer testMKVStreamer.cpp)
add_test_executable(testMP3Receiver testMP3Receiver.cpp)
add_test_executable(testMP3Streamer testMP3Streamer.cpp)
add_test_executable(testMPEG1or2AudioVideoStreamer testMPEG1or2AudioVideoStreamer.cpp)
add_test_executable(testMPEG1or2ProgramToTransportStream testMPEG1or2ProgramToTransportStream.cpp)
add_test_executable(testMPEG1or2Splitter testMPEG1or2Splitter.cpp)
add_test_executable(testMPEG1or2VideoReceiver testMPEG1or2VideoReceiver.cpp)
add_test_executable(testMPEG1or2VideoStreamer testMPEG1or2VideoStreamer.cpp)
add_test_executable(testMPEG2TransportReceiver testMPEG2TransportReceiver.cpp)
add_test_executable(testMPEG2TransportStreamTrickPlay testMPEG2TransportStreamTrickPlay.cpp)
add_test_executable(testMPEG2TransportStreamer testMPEG2TransportStreamer.cpp)
add_test_executable(testMPEG4VideoStreamer testMPEG4VideoStreamer.cpp)
add_test_executable(testOggStreamer testOggStreamer.cpp)
add_test_executable(testRelay testRelay.cpp)
add_test_executable(testReplicator testReplicator.cpp)
add_test_executable(testWAVAudioStreamer testWAVAudioStreamer.cpp)
add_test_executable(vobStreamer vobStreamer.cpp)
