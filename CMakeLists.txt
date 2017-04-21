cmake_minimum_required(VERSION 3.1.2)
project(live555)

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

add_library(groupsock 
            groupsock/GroupEId.cpp
            groupsock/Groupsock.cpp
            groupsock/GroupsockHelper.cpp
            groupsock/IOHandlers.cpp
            groupsock/NetAddress.cpp
            groupsock/NetInterface.cpp
            groupsock/inet.c
            groupsock/include/GroupEId.hh
            groupsock/include/Groupsock.hh
            groupsock/include/GroupsockHelper.hh
            groupsock/include/IOHandlers.hh
            groupsock/include/NetAddress.hh
            groupsock/include/NetCommon.h
            groupsock/include/NetInterface.hh
            groupsock/include/TunnelEncaps.hh
            groupsock/include/groupsock_version.hh)
target_live555_compile_options(groupsock)
target_include_directories(groupsock PUBLIC groupsock/include)
# This is a cyclic dependency :(
target_include_directories(groupsock PUBLIC UsageEnvironment/include)
if(WIN32)
    target_link_libraries(groupsock ws2_32 mswsock)
endif()

add_library(UsageEnvironment
            UsageEnvironment/HashTable.cpp
            UsageEnvironment/UsageEnvironment.cpp
            UsageEnvironment/strDup.cpp
            UsageEnvironment/include/Boolean.hh
            UsageEnvironment/include/HashTable.hh
            UsageEnvironment/include/UsageEnvironment.hh
            UsageEnvironment/include/UsageEnvironment_version.hh
            UsageEnvironment/include/strDup.hh)
target_live555_compile_options(UsageEnvironment)
target_include_directories(UsageEnvironment PUBLIC UsageEnvironment/include)
target_link_libraries(UsageEnvironment PUBLIC groupsock)

add_library(BasicUsageEnvironment
            BasicUsageEnvironment/BasicHashTable.cpp
            BasicUsageEnvironment/BasicTaskScheduler.cpp
            BasicUsageEnvironment/BasicTaskScheduler0.cpp
            BasicUsageEnvironment/BasicUsageEnvironment.cpp
            BasicUsageEnvironment/BasicUsageEnvironment0.cpp
            BasicUsageEnvironment/DelayQueue.cpp
            BasicUsageEnvironment/include/BasicHashTable.hh
            BasicUsageEnvironment/include/BasicUsageEnvironment.hh
            BasicUsageEnvironment/include/BasicUsageEnvironment0.hh
            BasicUsageEnvironment/include/BasicUsageEnvironment_version.hh
            BasicUsageEnvironment/include/DelayQueue.hh
            BasicUsageEnvironment/include/HandlerSet.hh)
target_live555_compile_options(BasicUsageEnvironment)
target_include_directories(BasicUsageEnvironment PUBLIC BasicUsageEnvironment/include)
target_link_libraries(BasicUsageEnvironment PUBLIC UsageEnvironment)

add_library(liveMedia
            liveMedia/AC3AudioFileServerMediaSubsession.cpp
            liveMedia/AC3AudioRTPSink.cpp
            liveMedia/AC3AudioRTPSource.cpp
            liveMedia/AC3AudioStreamFramer.cpp
            liveMedia/ADTSAudioFileServerMediaSubsession.cpp
            liveMedia/ADTSAudioFileSource.cpp
            liveMedia/AMRAudioFileServerMediaSubsession.cpp
            liveMedia/AMRAudioFileSink.cpp
            liveMedia/AMRAudioFileSource.cpp
            liveMedia/AMRAudioRTPSink.cpp
            liveMedia/AMRAudioRTPSource.cpp
            liveMedia/AMRAudioSource.cpp
            liveMedia/AVIFileSink.cpp
            liveMedia/AudioInputDevice.cpp
            liveMedia/AudioRTPSink.cpp
            liveMedia/Base64.cpp
            liveMedia/BasicUDPSink.cpp
            liveMedia/BasicUDPSource.cpp
            liveMedia/BitVector.cpp
            liveMedia/ByteStreamFileSource.cpp
            liveMedia/ByteStreamMemoryBufferSource.cpp
            liveMedia/ByteStreamMultiFileSource.cpp
            liveMedia/DVVideoFileServerMediaSubsession.cpp
            liveMedia/DVVideoRTPSink.cpp
            liveMedia/DVVideoRTPSource.cpp
            liveMedia/DVVideoStreamFramer.cpp
            liveMedia/DeviceSource.cpp
            liveMedia/DigestAuthentication.cpp
            liveMedia/EBMLNumber.cpp
            liveMedia/EBMLNumber.hh
            liveMedia/FileServerMediaSubsession.cpp
            liveMedia/FileSink.cpp
            liveMedia/FramedFileSource.cpp
            liveMedia/FramedFilter.cpp
            liveMedia/FramedSource.cpp
            liveMedia/GSMAudioRTPSink.cpp
            liveMedia/GenericMediaServer.cpp
            liveMedia/H261VideoRTPSource.cpp
            liveMedia/H263plusVideoFileServerMediaSubsession.cpp
            liveMedia/H263plusVideoRTPSink.cpp
            liveMedia/H263plusVideoRTPSource.cpp
            liveMedia/H263plusVideoStreamFramer.cpp
            liveMedia/H263plusVideoStreamParser.cpp
            liveMedia/H263plusVideoStreamParser.hh
            liveMedia/H264VideoFileServerMediaSubsession.cpp
            liveMedia/H264VideoFileSink.cpp
            liveMedia/H264VideoRTPSink.cpp
            liveMedia/H264VideoRTPSource.cpp
            liveMedia/H264VideoStreamDiscreteFramer.cpp
            liveMedia/H264VideoStreamFramer.cpp
            liveMedia/H264or5VideoFileSink.cpp
            liveMedia/H264or5VideoRTPSink.cpp
            liveMedia/H264or5VideoStreamDiscreteFramer.cpp
            liveMedia/H264or5VideoStreamFramer.cpp
            liveMedia/H265VideoFileServerMediaSubsession.cpp
            liveMedia/H265VideoFileSink.cpp
            liveMedia/H265VideoRTPSink.cpp
            liveMedia/H265VideoRTPSource.cpp
            liveMedia/H265VideoStreamDiscreteFramer.cpp
            liveMedia/H265VideoStreamFramer.cpp
            liveMedia/InputFile.cpp
            liveMedia/JPEGVideoRTPSink.cpp
            liveMedia/JPEGVideoRTPSource.cpp
            liveMedia/JPEGVideoSource.cpp
            liveMedia/Locale.cpp
            liveMedia/MP3ADU.cpp
            liveMedia/MP3ADURTPSink.cpp
            liveMedia/MP3ADURTPSource.cpp
            liveMedia/MP3ADUTranscoder.cpp
            liveMedia/MP3ADUdescriptor.cpp
            liveMedia/MP3ADUdescriptor.hh
            liveMedia/MP3ADUinterleaving.cpp
            liveMedia/MP3AudioFileServerMediaSubsession.cpp
            liveMedia/MP3AudioMatroskaFileServerMediaSubsession.cpp
            liveMedia/MP3AudioMatroskaFileServerMediaSubsession.hh
            liveMedia/MP3FileSource.cpp
            liveMedia/MP3Internals.cpp
            liveMedia/MP3Internals.hh
            liveMedia/MP3InternalsHuffman.cpp
            liveMedia/MP3InternalsHuffman.hh
            liveMedia/MP3InternalsHuffmanTable.cpp
            liveMedia/MP3StreamState.cpp
            liveMedia/MP3StreamState.hh
            liveMedia/MP3Transcoder.cpp
            liveMedia/MPEG1or2AudioRTPSink.cpp
            liveMedia/MPEG1or2AudioRTPSource.cpp
            liveMedia/MPEG1or2AudioStreamFramer.cpp
            liveMedia/MPEG1or2Demux.cpp
            liveMedia/MPEG1or2DemuxedElementaryStream.cpp
            liveMedia/MPEG1or2DemuxedServerMediaSubsession.cpp
            liveMedia/MPEG1or2FileServerDemux.cpp
            liveMedia/MPEG1or2VideoFileServerMediaSubsession.cpp
            liveMedia/MPEG1or2VideoRTPSink.cpp
            liveMedia/MPEG1or2VideoRTPSource.cpp
            liveMedia/MPEG1or2VideoStreamDiscreteFramer.cpp
            liveMedia/MPEG1or2VideoStreamFramer.cpp
            liveMedia/MPEG2IndexFromTransportStream.cpp
            liveMedia/MPEG2TransportFileServerMediaSubsession.cpp
            liveMedia/MPEG2TransportStreamAccumulator.cpp
            liveMedia/MPEG2TransportStreamFramer.cpp
            liveMedia/MPEG2TransportStreamFromESSource.cpp
            liveMedia/MPEG2TransportStreamFromPESSource.cpp
            liveMedia/MPEG2TransportStreamIndexFile.cpp
            liveMedia/MPEG2TransportStreamMultiplexor.cpp
            liveMedia/MPEG2TransportStreamTrickModeFilter.cpp
            liveMedia/MPEG2TransportUDPServerMediaSubsession.cpp
            liveMedia/MPEG4ESVideoRTPSink.cpp
            liveMedia/MPEG4ESVideoRTPSource.cpp
            liveMedia/MPEG4GenericRTPSink.cpp
            liveMedia/MPEG4GenericRTPSource.cpp
            liveMedia/MPEG4LATMAudioRTPSink.cpp
            liveMedia/MPEG4LATMAudioRTPSource.cpp
            liveMedia/MPEG4VideoFileServerMediaSubsession.cpp
            liveMedia/MPEG4VideoStreamDiscreteFramer.cpp
            liveMedia/MPEG4VideoStreamFramer.cpp
            liveMedia/MPEGVideoStreamFramer.cpp
            liveMedia/MPEGVideoStreamParser.cpp
            liveMedia/MPEGVideoStreamParser.hh
            liveMedia/MatroskaDemuxedTrack.cpp
            liveMedia/MatroskaDemuxedTrack.hh
            liveMedia/MatroskaFile.cpp
            liveMedia/MatroskaFileParser.cpp
            liveMedia/MatroskaFileParser.hh
            liveMedia/MatroskaFileServerDemux.cpp
            liveMedia/MatroskaFileServerMediaSubsession.cpp
            liveMedia/MatroskaFileServerMediaSubsession.hh
            liveMedia/Media.cpp
            liveMedia/MediaSession.cpp
            liveMedia/MediaSink.cpp
            liveMedia/MediaSource.cpp
            liveMedia/MultiFramedRTPSink.cpp
            liveMedia/MultiFramedRTPSource.cpp
            liveMedia/OggDemuxedTrack.cpp
            liveMedia/OggDemuxedTrack.hh
            liveMedia/OggFile.cpp
            liveMedia/OggFileParser.cpp
            liveMedia/OggFileParser.hh
            liveMedia/OggFileServerDemux.cpp
            liveMedia/OggFileServerMediaSubsession.cpp
            liveMedia/OggFileServerMediaSubsession.hh
            liveMedia/OggFileSink.cpp
            liveMedia/OnDemandServerMediaSubsession.cpp
            liveMedia/OutputFile.cpp
            liveMedia/PassiveServerMediaSubsession.cpp
            liveMedia/ProxyServerMediaSession.cpp
            liveMedia/QCELPAudioRTPSource.cpp
            liveMedia/QuickTimeFileSink.cpp
            liveMedia/QuickTimeGenericRTPSource.cpp
            liveMedia/RTCP.cpp
            liveMedia/RTPInterface.cpp
            liveMedia/RTPSink.cpp
            liveMedia/RTPSource.cpp
            liveMedia/RTSPClient.cpp
            liveMedia/RTSPCommon.cpp
            liveMedia/RTSPRegisterSender.cpp
            liveMedia/RTSPServer.cpp
            liveMedia/RTSPServerRegister.cpp
            liveMedia/RTSPServerSupportingHTTPStreaming.cpp
            liveMedia/SIPClient.cpp
            liveMedia/ServerMediaSession.cpp
            liveMedia/SimpleRTPSink.cpp
            liveMedia/SimpleRTPSource.cpp
            liveMedia/StreamParser.cpp
            liveMedia/StreamParser.hh
            liveMedia/StreamReplicator.cpp
            liveMedia/T140TextRTPSink.cpp
            liveMedia/TCPStreamSink.cpp
            liveMedia/TextRTPSink.cpp
            liveMedia/TheoraVideoRTPSink.cpp
            liveMedia/TheoraVideoRTPSource.cpp
            liveMedia/VP8VideoRTPSink.cpp
            liveMedia/VP8VideoRTPSource.cpp
            liveMedia/VP9VideoRTPSink.cpp
            liveMedia/VP9VideoRTPSource.cpp
            liveMedia/VideoRTPSink.cpp
            liveMedia/VorbisAudioRTPSink.cpp
            liveMedia/VorbisAudioRTPSource.cpp
            liveMedia/WAVAudioFileServerMediaSubsession.cpp
            liveMedia/WAVAudioFileSource.cpp
            liveMedia/ourMD5.cpp
            liveMedia/rtcp_from_spec.c
            liveMedia/rtcp_from_spec.h
            liveMedia/uLawAudioFilter.cpp
            liveMedia/include/AC3AudioFileServerMediaSubsession.hh
            liveMedia/include/AC3AudioRTPSink.hh
            liveMedia/include/AC3AudioRTPSource.hh
            liveMedia/include/AC3AudioStreamFramer.hh
            liveMedia/include/ADTSAudioFileServerMediaSubsession.hh
            liveMedia/include/ADTSAudioFileSource.hh
            liveMedia/include/AMRAudioFileServerMediaSubsession.hh
            liveMedia/include/AMRAudioFileSink.hh
            liveMedia/include/AMRAudioFileSource.hh
            liveMedia/include/AMRAudioRTPSink.hh
            liveMedia/include/AMRAudioRTPSource.hh
            liveMedia/include/AMRAudioSource.hh
            liveMedia/include/AVIFileSink.hh
            liveMedia/include/AudioInputDevice.hh
            liveMedia/include/AudioRTPSink.hh
            liveMedia/include/Base64.hh
            liveMedia/include/BasicUDPSink.hh
            liveMedia/include/BasicUDPSource.hh
            liveMedia/include/BitVector.hh
            liveMedia/include/ByteStreamFileSource.hh
            liveMedia/include/ByteStreamMemoryBufferSource.hh
            liveMedia/include/ByteStreamMultiFileSource.hh
            liveMedia/include/DVVideoFileServerMediaSubsession.hh
            liveMedia/include/DVVideoRTPSink.hh
            liveMedia/include/DVVideoRTPSource.hh
            liveMedia/include/DVVideoStreamFramer.hh
            liveMedia/include/DeviceSource.hh
            liveMedia/include/DigestAuthentication.hh
            liveMedia/include/FileServerMediaSubsession.hh
            liveMedia/include/FileSink.hh
            liveMedia/include/FramedFileSource.hh
            liveMedia/include/FramedFilter.hh
            liveMedia/include/FramedSource.hh
            liveMedia/include/GSMAudioRTPSink.hh
            liveMedia/include/GenericMediaServer.hh
            liveMedia/include/H261VideoRTPSource.hh
            liveMedia/include/H263plusVideoFileServerMediaSubsession.hh
            liveMedia/include/H263plusVideoRTPSink.hh
            liveMedia/include/H263plusVideoRTPSource.hh
            liveMedia/include/H263plusVideoStreamFramer.hh
            liveMedia/include/H264VideoFileServerMediaSubsession.hh
            liveMedia/include/H264VideoFileSink.hh
            liveMedia/include/H264VideoRTPSink.hh
            liveMedia/include/H264VideoRTPSource.hh
            liveMedia/include/H264VideoStreamDiscreteFramer.hh
            liveMedia/include/H264VideoStreamFramer.hh
            liveMedia/include/H264or5VideoFileSink.hh
            liveMedia/include/H264or5VideoRTPSink.hh
            liveMedia/include/H264or5VideoStreamDiscreteFramer.hh
            liveMedia/include/H264or5VideoStreamFramer.hh
            liveMedia/include/H265VideoFileServerMediaSubsession.hh
            liveMedia/include/H265VideoFileSink.hh
            liveMedia/include/H265VideoRTPSink.hh
            liveMedia/include/H265VideoRTPSource.hh
            liveMedia/include/H265VideoStreamDiscreteFramer.hh
            liveMedia/include/H265VideoStreamFramer.hh
            liveMedia/include/InputFile.hh
            liveMedia/include/JPEGVideoRTPSink.hh
            liveMedia/include/JPEGVideoRTPSource.hh
            liveMedia/include/JPEGVideoSource.hh
            liveMedia/include/Locale.hh
            liveMedia/include/MP3ADU.hh
            liveMedia/include/MP3ADURTPSink.hh
            liveMedia/include/MP3ADURTPSource.hh
            liveMedia/include/MP3ADUTranscoder.hh
            liveMedia/include/MP3ADUinterleaving.hh
            liveMedia/include/MP3AudioFileServerMediaSubsession.hh
            liveMedia/include/MP3FileSource.hh
            liveMedia/include/MP3Transcoder.hh
            liveMedia/include/MPEG1or2AudioRTPSink.hh
            liveMedia/include/MPEG1or2AudioRTPSource.hh
            liveMedia/include/MPEG1or2AudioStreamFramer.hh
            liveMedia/include/MPEG1or2Demux.hh
            liveMedia/include/MPEG1or2DemuxedElementaryStream.hh
            liveMedia/include/MPEG1or2DemuxedServerMediaSubsession.hh
            liveMedia/include/MPEG1or2FileServerDemux.hh
            liveMedia/include/MPEG1or2VideoFileServerMediaSubsession.hh
            liveMedia/include/MPEG1or2VideoRTPSink.hh
            liveMedia/include/MPEG1or2VideoRTPSource.hh
            liveMedia/include/MPEG1or2VideoStreamDiscreteFramer.hh
            liveMedia/include/MPEG1or2VideoStreamFramer.hh
            liveMedia/include/MPEG2IndexFromTransportStream.hh
            liveMedia/include/MPEG2TransportFileServerMediaSubsession.hh
            liveMedia/include/MPEG2TransportStreamAccumulator.hh
            liveMedia/include/MPEG2TransportStreamFramer.hh
            liveMedia/include/MPEG2TransportStreamFromESSource.hh
            liveMedia/include/MPEG2TransportStreamFromPESSource.hh
            liveMedia/include/MPEG2TransportStreamIndexFile.hh
            liveMedia/include/MPEG2TransportStreamMultiplexor.hh
            liveMedia/include/MPEG2TransportStreamTrickModeFilter.hh
            liveMedia/include/MPEG2TransportUDPServerMediaSubsession.hh
            liveMedia/include/MPEG4ESVideoRTPSink.hh
            liveMedia/include/MPEG4ESVideoRTPSource.hh
            liveMedia/include/MPEG4GenericRTPSink.hh
            liveMedia/include/MPEG4GenericRTPSource.hh
            liveMedia/include/MPEG4LATMAudioRTPSink.hh
            liveMedia/include/MPEG4LATMAudioRTPSource.hh
            liveMedia/include/MPEG4VideoFileServerMediaSubsession.hh
            liveMedia/include/MPEG4VideoStreamDiscreteFramer.hh
            liveMedia/include/MPEG4VideoStreamFramer.hh
            liveMedia/include/MPEGVideoStreamFramer.hh
            liveMedia/include/MatroskaFile.hh
            liveMedia/include/MatroskaFileServerDemux.hh
            liveMedia/include/Media.hh
            liveMedia/include/MediaSession.hh
            liveMedia/include/MediaSink.hh
            liveMedia/include/MediaSource.hh
            liveMedia/include/MediaTranscodingTable.hh
            liveMedia/include/MultiFramedRTPSink.hh
            liveMedia/include/MultiFramedRTPSource.hh
            liveMedia/include/OggFile.hh
            liveMedia/include/OggFileServerDemux.hh
            liveMedia/include/OggFileSink.hh
            liveMedia/include/OnDemandServerMediaSubsession.hh
            liveMedia/include/OutputFile.hh
            liveMedia/include/PassiveServerMediaSubsession.hh
            liveMedia/include/ProxyServerMediaSession.hh
            liveMedia/include/QCELPAudioRTPSource.hh
            liveMedia/include/QuickTimeFileSink.hh
            liveMedia/include/QuickTimeGenericRTPSource.hh
            liveMedia/include/RTCP.hh
            liveMedia/include/RTPInterface.hh
            liveMedia/include/RTPSink.hh
            liveMedia/include/RTPSource.hh
            liveMedia/include/RTSPClient.hh
            liveMedia/include/RTSPCommon.hh
            liveMedia/include/RTSPRegisterSender.hh
            liveMedia/include/RTSPServer.hh
            liveMedia/include/RTSPServerSupportingHTTPStreaming.hh
            liveMedia/include/SIPClient.hh
            liveMedia/include/ServerMediaSession.hh
            liveMedia/include/SimpleRTPSink.hh
            liveMedia/include/SimpleRTPSource.hh
            liveMedia/include/StreamReplicator.hh
            liveMedia/include/T140TextRTPSink.hh
            liveMedia/include/TCPStreamSink.hh
            liveMedia/include/TextRTPSink.hh
            liveMedia/include/TheoraVideoRTPSink.hh
            liveMedia/include/TheoraVideoRTPSource.hh
            liveMedia/include/VP8VideoRTPSink.hh
            liveMedia/include/VP8VideoRTPSource.hh
            liveMedia/include/VP9VideoRTPSink.hh
            liveMedia/include/VP9VideoRTPSource.hh
            liveMedia/include/VideoRTPSink.hh
            liveMedia/include/VorbisAudioRTPSink.hh
            liveMedia/include/VorbisAudioRTPSource.hh
            liveMedia/include/WAVAudioFileServerMediaSubsession.hh
            liveMedia/include/WAVAudioFileSource.hh
            liveMedia/include/liveMedia.hh
            liveMedia/include/liveMedia_version.hh
            liveMedia/include/ourMD5.hh
            liveMedia/include/uLawAudioFilter.hh
)
target_live555_compile_options(liveMedia)
target_include_directories(liveMedia PUBLIC liveMedia/include)
target_link_libraries(liveMedia PUBLIC UsageEnvironment)

set(groupsock_VERSION_CURRENT 9)
set(groupsock_VERSION_REVISION 1)
set(groupsock_VERSION_AGE 1)
math(EXPR groupsock_VERSION_MAJOR "${groupsock_VERSION_CURRENT} - ${groupsock_VERSION_AGE}")
set_target_properties(groupsock PROPERTIES 
                      VERSION ${groupsock_VERSION_MAJOR}.${groupsock_VERSION_AGE}.${groupsock_VERSION_REVISION}
                      SOVERSION ${groupsock_VERSION_MAJOR})

set(UsageEnvironment_VERSION_CURRENT 4)
set(UsageEnvironment_VERSION_REVISION 0)
set(UsageEnvironment_VERSION_AGE 1)
math(EXPR UsageEnvironment_VERSION_MAJOR "${UsageEnvironment_VERSION_CURRENT} - ${UsageEnvironment_VERSION_AGE}")
set_target_properties(UsageEnvironment PROPERTIES 
                      VERSION ${UsageEnvironment_VERSION_MAJOR}.${UsageEnvironment_VERSION_AGE}.${UsageEnvironment_VERSION_REVISION}
                      SOVERSION ${UsageEnvironment_VERSION_MAJOR})

set(BasicUsageEnvironment_VERSION_CURRENT 1)
set(BasicUsageEnvironment_VERSION_REVISION 0)
set(BasicUsageEnvironment_VERSION_AGE 0)
math(EXPR BasicUsageEnvironment_VERSION_MAJOR "${BasicUsageEnvironment_VERSION_CURRENT} - ${BasicUsageEnvironment_VERSION_AGE}")
set_target_properties(BasicUsageEnvironment PROPERTIES 
                      VERSION ${BasicUsageEnvironment_VERSION_MAJOR}.${BasicUsageEnvironment_VERSION_AGE}.${BasicUsageEnvironment_VERSION_REVISION}
                      SOVERSION ${BasicUsageEnvironment_VERSION_MAJOR})

set(liveMedia_VERSION_CURRENT 57)
set(liveMedia_VERSION_REVISION 5)
set(liveMedia_VERSION_AGE 0)
math(EXPR liveMedia_VERSION_MAJOR "${liveMedia_VERSION_CURRENT} - ${liveMedia_VERSION_AGE}")
set_target_properties(liveMedia PROPERTIES 
                      VERSION ${liveMedia_VERSION_MAJOR}.${liveMedia_VERSION_AGE}.${liveMedia_VERSION_REVISION}
                      SOVERSION ${liveMedia_VERSION_MAJOR})

option(LIVE555_EPOLL_SUPPORT ON)
if(LIVE555_EPOLL_SUPPORT)
    set(EPOLL_TASK_SCHEDULER_FILES
        EpollTaskScheduler/EpollTaskScheduler.cpp
        EpollTaskScheduler/include/EpollTaskScheduler.hh)

    if(WIN32)
        set(EPOLL_TASK_SCHEDULER_FILES ${EPOLL_TASK_SCHEDULER_FILES}
            EpollTaskScheduler/epoll.c
            EpollTaskScheduler/epoll.h
            EpollTaskScheduler/msafd.h
            EpollTaskScheduler/ntapi.h
            EpollTaskScheduler/tree.h)
    endif()
    add_library(EpollTaskScheduler ${EPOLL_TASK_SCHEDULER_FILES})
    target_live555_compile_options(EpollTaskScheduler)
    target_include_directories(EpollTaskScheduler PUBLIC EpollTaskScheduler/include)
    target_link_libraries(EpollTaskScheduler PUBLIC BasicUsageEnvironment)

    set(EpollTaskScheduler_VERSION_CURRENT 1)
    set(EpollTaskScheduler_VERSION_REVISION 0)
    set(EpollTaskScheduler_VERSION_AGE 0)
    math(EXPR EpollTaskScheduler_VERSION_MAJOR "${EpollTaskScheduler_VERSION_CURRENT} - ${EpollTaskScheduler_VERSION_AGE}")
    set_target_properties(EpollTaskScheduler PROPERTIES 
                          VERSION ${EpollTaskScheduler_VERSION_MAJOR}.${EpollTaskScheduler_VERSION_AGE}.${EpollTaskScheduler_VERSION_REVISION}
                          SOVERSION ${EpollTaskScheduler_VERSION_MAJOR})
endif()

option(LIVE555_BUILD_EXAMPLES OFF)
if(LIVE555_BUILD_EXAMPLES)
    macro(add_test_executable _target)
        add_executable(${_target} ${ARGN})
        target_live555_compile_options(${_target})
        target_link_libraries(${_target} liveMedia BasicUsageEnvironment)
        if(LIVE555_EPOLL_SUPPORT)
            target_link_libraries(${_target} EpollTaskScheduler)
            target_compile_definitions(${_target} PRIVATE HAVE_EPOLL_SCHEDULER)
        endif()
    endmacro()

    # test...
    add_test_executable(testRTSPClient testProgs/testRTSPClient.cpp)
    add_test_executable(testH264VideoStreamer testProgs/testH264VideoStreamer.cpp)
    add_test_executable(testOnDemandRTSPServer testProgs/testOnDemandRTSPServer.cpp)
    # TODO: add more from testProgs/

    # openRTSP
    add_test_executable(openRTSP
                        testProgs/openRTSP.cpp
                        testProgs/playCommon.cpp
                        testProgs/playCommon.hh)

    # Proxy server
    add_test_executable(live555ProxyServer proxyServer/live555ProxyServer.cpp)

    # Media server
    add_test_executable(live555MediaServer
                        mediaServer/DynamicRTSPServer.cpp
                        mediaServer/DynamicRTSPServer.hh
                        mediaServer/live555MediaServer.cpp
                        mediaServer/version.hh)
endif()
