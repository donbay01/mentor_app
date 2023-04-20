import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/helper/snackbar.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:career_paddy/services/session.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/video_call.dart';

class VideoScreen extends StatefulWidget {
  final String channel;
  final UserModel user;

  const VideoScreen({
    super.key,
    required this.channel,
    required this.user,
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

    Navigator.pop(context);
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
                : MENTOR + 'just joined the call',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      isMute = !isMute;
                      _engine.muteLocalAudioStream(isMute);
                      setState(() {});
                    },
                    icon: Icon(
                      isMute ? Icons.volume_off : Icons.volume_up,
                    ),
                  ),
                  IconButton(
                    color: Colors.red.shade600,
                    onPressed: () => endCall(),
                    icon: Icon(
                      Icons.call_end,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _engine.switchCamera(),
                    icon: Icon(
                      Icons.camera_alt,
                    ),
                  ),
                ],
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
