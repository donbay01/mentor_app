import 'package:career_paddy/components/banners/small.dart';
import 'package:career_paddy/components/drawer/drawer.dart';
import 'package:career_paddy/components/drawer/notification_ui.dart';
import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/pages/home/points.dart';
import 'package:career_paddy/pages/home/session_widget.dart';
import 'package:career_paddy/services/auth.dart';
import 'package:career_paddy/theme/color.dart';
import 'package:career_paddy/theme/text_style.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var service = AuthService();

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, ${user?.displayName!.split(' ').first}",
                      style: largeText(primaryBlack),
                    ),
                    Row(
                      children: [
                        NotificationUI(),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => MyDrawer(),
                          ),
                          child: ProfileIcon(
                            radius: 40,
                            image: user?.photoURL,
                            isExternal: true,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SmallBanners(),
                SizedBox(
                  height: 20,
                ),
                PointsUI(),
                SizedBox(
                  height: 30,
                ),
                SessionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
