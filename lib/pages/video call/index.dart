import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/session_model.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/pages/video%20call/review_call.dart';
import 'package:career_paddy/services/session.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/video_call.dart';

class VideoScreen extends StatefulWidget {
  final String channel;
  final SessionModel session;
  final UserModel user;

  const VideoScreen({
    super.key,
    required this.channel,
    required this.user,
    required this.session,
  });

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;

  late RtcEngine _engine;
  late int uid;
  String? token;

  bool isMute = false;
  bool isVideoCall = true;

  @override
  void initState() {
    uid = widget.user.role == MENTOR ? 0 : 1;
    initAgora();
    super.initState();
  }

  endCall() async {
    await _engine.disableVideo();
    await _engine.stopPreview();
    await _engine.leaveChannel();

    if (widget.user.role == MENTEE) {
      await showModalBottomSheet(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        context: context,
        builder: (_) => ReviewCall(
          session: widget.session,
        ),
      );
    }
  }

  Future<void> initAgora() async {
    await [Permission.microphone, Permission.camera].request();
    token = await SessionService.getToken(uid, widget.channel);

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          SnackBarHelper.displayToastMessage(
            context,
            'You have started the call',
            primaryBlue,
          );
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          debugPrint("remote user $remoteUid joined");
          SnackBarHelper.displayToastMessage(
            context,
            widget.user.role == MENTOR
                ? MENTEE
                : MENTOR + ' just joined the call',
            primaryBlue,
          );
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (connection, remoteUid, reason) {
          debugPrint("remote user $remoteUid left channel");
          SnackBarHelper.displayToastMessage(
            context,
            'You are offline',
            primaryBlue,
          );

          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (connection, token) {
          debugPrint(
            '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token',
          );
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token!,
      channelId: widget.channel,
      uid: uid,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: primaryBlack,
            size: 20,
          ),
          onPressed: () => endCall(),
        ),
        title: Text(
          'Video Call',
          style: TextStyle(
            color: primaryBlack,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        backgroundColor: primaryWhite,
                        child: IconButton(
                          onPressed: () async {
                            isMute = !isMute;
                            _engine.muteLocalAudioStream(isMute);
                            setState(() {});
                          },
                          icon: Icon(
                            isMute ? Icons.mic_off_outlined : Icons.mic,
                            color: textGrey,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: primaryWhite,
                        child: IconButton(
                          onPressed: () => _engine.switchCamera(),
                          icon: Icon(
                            FontAwesomeIcons.cameraRotate,
                            color: textGrey,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.red,
                        child: IconButton(
                          onPressed: () => endCall(),
                          icon: Icon(
                            Icons.call_end,
                            color: primaryWhite,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: primaryWhite,
                        child: IconButton(
                          onPressed: () async {
                            if (isVideoCall) {
                              await _engine.disableVideo();
                              await _engine.muteAllRemoteVideoStreams(true);
                              await _engine.stopPreview();
                            } else {
                              await _engine.startPreview();
                              await _engine.muteAllRemoteVideoStreams(false);
                              await _engine.enableVideo();
                            }

                            setState(() {
                              isVideoCall = !isVideoCall;
                            });
                          },
                          icon: Icon(
                            isVideoCall
                                ? CupertinoIcons.video_camera
                                : Icons.video_call,
                            color: textGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
