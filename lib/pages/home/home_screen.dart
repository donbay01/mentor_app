import 'package:career_paddy/components/banners/small.dart';
import 'package:career_paddy/components/drawer/drawer.dart';
import 'package:career_paddy/components/drawer/profile_icon.dart';
import 'package:career_paddy/pages/home/points.dart';
import 'package:career_paddy/pages/home/session_widget.dart';
import 'package:career_paddy/pages/notifications/notifications.dart';
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
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  var service = AuthService();

  @override
  Widget build(BuildContext context) {
    var user = service.getFirebaseUser()!;

    return SafeArea(
      child: Scaffold(
        // drawer: MyDrawer(
        //   user: user,
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hi, ${user.displayName!.split(' ').first}",
                      style: largeText(primaryBlack),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Notifications(),
                              ),
                            );
                          },
                          icon: Icon(Icons.notifications),
                        ),
                        GestureDetector(
                          onTap: () => showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => MyDrawer(user: user),
                          ),
                          child: ProfileIcon(
                            radius: 40,
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
