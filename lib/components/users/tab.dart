import 'package:career_paddy/components/users/reviews.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../theme/text_style.dart';
import 'package:cupertino_tabbar/cupertino_tabbar.dart';
import 'about.dart';

class UserTab extends StatefulWidget {
  final UserModel user, mentee;
  final String meetingType;

  const UserTab({
    super.key,
    required this.user,
    required this.mentee,
    required this.meetingType,
  });

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  int cupertinoTabBarIValue = 0;
  int cupertinoTabBarIValueGetter() => cupertinoTabBarIValue;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width / 1.9,
          child: CupertinoTabBar(
            Colors.grey.shade300,
            Colors.white,
            [
              Padding(
                padding: EdgeInsets.only(
                  right: cupertinoTabBarIValue == 0 ? (size.width / 15) : 0,
                ),
                child: Text(
                  "About",
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: cupertinoTabBarIValue == 1 ? (size.width / 20) : 0,
                ),
                child: Text(
                  "Reviews",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            cupertinoTabBarIValueGetter,
            (index) {
              setState(() {
                cupertinoTabBarIValue = index;
              });
            },
            useShadow: false,
          ),
        ),
        if (cupertinoTabBarIValue == 0) ...[
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 16),
            constraints: BoxConstraints(
              maxWidth: 319,
            ),
            child: Text(
              widget.user.bio ??
                  widget.user.description ??
                  'No bio has been setup',
              style: small(),
            ),
          ),
          About(
            user: widget.user,
            mentee: widget.mentee,
            meetingType: widget.meetingType,
          ),
        ] else ...[
          Reviews(
            user: widget.user,
            meetingType: widget.meetingType,
          ),
        ],
      ],
    );
  }
}
